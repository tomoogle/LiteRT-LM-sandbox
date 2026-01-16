# ==============================================================================
# LiteRTLM Shared TFLite Linker Logic
# ==============================================================================
# This file defines the canonical logic for linking TensorFlow Lite static archives.
# It is shared between the TFLite build recipe (Producer) and the LiteRT Patcher (Consumer)
# to ensure zero drift in linker flags or dependency ordering.
# ==============================================================================

macro(literlm_configure_tflite_interface force_load_targets standard_targets include_dirs build_dir)

    # 1. Define the Interface Target
    if(NOT TARGET tflite_kitchen_sink)
        add_library(tflite_kitchen_sink INTERFACE IMPORTED GLOBAL)
    endif()

    # 2. Establish the Alias
    # This ensures consistent naming across the build ecosystem
    if(NOT TARGET LiteRTLM::tflite::tflite)
        add_library(LiteRTLM::tflite::tflite ALIAS tflite_kitchen_sink)
    endif()

    # 3. Configure Include Directories
    # We use SYSTEM to suppress warnings from TFLite headers
    target_include_directories(tflite_kitchen_sink SYSTEM INTERFACE 
        ${include_dirs}
        ${build_dir} # Required for generated headers (ruy/cpuinfo)
    )

    # 4. Configure Linker Logic
    target_link_libraries(tflite_kitchen_sink INTERFACE
        # --- PHASE 1: FORCE LOAD (The Hammer) ---
        # Ensures registration of static kernels and operators.
        # Critical for TFLite's self-registering OpResolver.
        $<$<PLATFORM_ID:Linux,Android,FreeBSD>:-Wl,--whole-archive>
        $<$<PLATFORM_ID:Darwin>:-Wl,-force_load>
            ${force_load_targets}
        $<$<PLATFORM_ID:Linux,Android,FreeBSD>:-Wl,--no-whole-archive>

        # --- PHASE 2: CIRCULAR DEPENDENCIES (The Group) ---
        # Handles Math/Utility libs (XNNPACK, Ruy, cpuinfo) which often
        # have circular symbol references.
        $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
            ${standard_targets}
            
            # Hermetic Shim Dependencies (Must be defined in calling scope)
            LiteRTLM::absl::absl
            LiteRTLM::flatbuffers::flatbuffers
        $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>

        # --- PHASE 3: SYSTEM LINKS ---
        pthread
        $<$<PLATFORM_ID:Linux>:dl>
        $<$<PLATFORM_ID:Android>:log>
    )

endmacro()