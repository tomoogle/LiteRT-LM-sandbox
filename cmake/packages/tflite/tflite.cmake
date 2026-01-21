include(ExternalProject)
include("${LITERTLM_PACKAGES_DIR}/tflite/tflite_aggregate.cmake")

# ==============================================================================
# SECTION 1: PATH CONFIGURATION
# ==============================================================================
set(TFLITE_EXT_PREFIX       "${EXTERNAL_PROJECT_BINARY_DIR}/tensorflow")
set(TFLITE_INSTALL_PREFIX   "${TFLITE_EXT_PREFIX}/install")

# --- Exported Paths for LiteRT-LM ---
set(TFLITE_INCLUDE_DIR      "${TFLITE_INSTALL_PREFIX}/include")
set(TFLITE_LIB_DIR          "${TFLITE_INSTALL_PREFIX}/lib")
set(TFLITE_SRC_DIR          "${TFLITE_EXT_PREFIX}/src/tflite_external/tensorflow/lite")
set(TFLITE_BUILD_DIR        "${TFLITE_EXT_PREFIX}/src/tflite_external-build" CACHE INTERNAL "TFLite Build Directory")
set(TENSORFLOW_SOURCE_DIR   "${TFLITE_EXT_PREFIX}/src/tflite_external")
set(TFLITE_STATIC_LIB       "${TFLITE_BUILD_DIR}/libtensorflow-lite.a")
set(RUY_INCLUDE_DIR         "${EXTERNAL_PROJECT_BINARY_DIR}/tflite_external-build")


# ==============================================================================
# SECTION 2: EXTERNAL BUILD DEFINITION
# ==============================================================================
if(NOT EXISTS "${TFLITE_STATIC_LIB}")
    message(STATUS "[TFLite] Binary not found. Configuring external build at ${TFLITE_EXT_PREFIX}...")

    # Define shim code for dependencies if needed by patch scripts
    set(SHIM_CODE 
        "add_library(LiteRTLM::absl::absl INTERFACE IMPORTED GLOBAL)
         set_target_properties(LiteRTLM::absl::absl PROPERTIES INTERFACE_LINK_LIBRARIES \"-Wl,--start-group ${ABSL_LIBS_FLAT} -Wl,--end-group\")"
    )

    ExternalProject_Add(
        tflite_external
        DEPENDS 
            absl_external
            flatbuffers_external
            gtest_external
            opencl_headers_external
            protobuf_external
            tokenizers-cpp_external

        # --- Source Control ---
        GIT_REPOSITORY  https://github.com/tensorflow/tensorflow.git
        GIT_TAG         061041963ead867e8f47fb63e153db3e61e3b20b
        PREFIX          "${TFLITE_EXT_PREFIX}"
        SOURCE_SUBDIR   "tensorflow/lite"

        # --- Patching & Decoupling ---
        PATCH_COMMAND
            git checkout -- . && git clean -df
            # 1. Version Constraints & Converter Patches
            COMMAND sed -i "s/FLATBUFFERS_VERSION_MAJOR == [0-9]*/FLATBUFFERS_VERSION_MAJOR >= 25/" <SOURCE_DIR>/tensorflow/lite/acceleration/configuration/configuration_generated.h
            COMMAND unzip -o "${PROJECT_ROOT}/cmake/patches/litert_converter.zip" -d "${TFLITE_SRC_DIR}"
            
            # 2. Build Logic Overrides
            COMMAND sed -i "s|find_program(FLATC_BIN flatc HINTS \${FLATC_PATHS})|set(FLATC_BIN \"${FLATC_EXECUTABLE}\" CACHE FILEPATH \"Forced by LiteRT-LM\")|g" <SOURCE_DIR>/tensorflow/lite/CMakeLists.txt
            
            # 3. Schema Version Relaxations
            COMMAND sed -i "s/FLATBUFFERS_VERSION_MAJOR == 24/FLATBUFFERS_VERSION_MAJOR >= 24/g" <SOURCE_DIR>/tensorflow/compiler/mlir/lite/schema/schema_generated.h
            COMMAND sed -i "s/FLATBUFFERS_VERSION_MINOR == 3/FLATBUFFERS_VERSION_MINOR >= 0/g" <SOURCE_DIR>/tensorflow/compiler/mlir/lite/schema/schema_generated.h
            COMMAND sed -i "s/FLATBUFFERS_VERSION_REVISION == 25/FLATBUFFERS_VERSION_REVISION >= 0/g" <SOURCE_DIR>/tensorflow/compiler/mlir/lite/schema/schema_generated.h 

            # 4. Neutralize TFLite Downloaders (Prevent Network Access)
            COMMAND sed -i "1i return()" <SOURCE_DIR>/tensorflow/lite/tools/cmake/modules/abseil-cpp.cmake
            COMMAND sed -i "1i return()" <SOURCE_DIR>/tensorflow/lite/tools/cmake/modules/protobuf.cmake
            COMMAND sed -i "1i return()" <SOURCE_DIR>/tensorflow/lite/tools/cmake/modules/flatbuffers.cmake

            # 5. Global Dependency Redirection (The "Shim Injection")
            COMMAND find <SOURCE_DIR>/tensorflow/lite -name "CMakeLists.txt" -exec sed -i "s|[[:space:]]absl::[a-zA-Z0-9_]*| LiteRTLM::absl::absl|g" {} +
            COMMAND find <SOURCE_DIR>/tensorflow/lite -name "CMakeLists.txt" -exec sed -i "s|[[:space:]]protobuf::[a-zA-Z0-9_-]*| LiteRTLM::protobuf::libprotobuf|g" {} +
            COMMAND find <SOURCE_DIR>/tensorflow/lite -name "CMakeLists.txt" -exec sed -i "s|[[:space:]]flatbuffers::[a-zA-Z0-9_-]*| LiteRTLM::flatbuffers::flatbuffers|g" {} +

            # 6. Run Internal Patcher
            COMMAND ${CMAKE_COMMAND} 
                -DFLATC_EXECUTABLE=${FLATC_EXECUTABLE} 
                -DTFLITE_SRC_DIR=${TFLITE_SRC_DIR} 
                -DTFLITE_BUILD_DIR=${TFLITE_BUILD_DIR}
                -DTENSORFLOW_SOURCE_DIR=${TENSORFLOW_SOURCE_DIR} 
                -DLITERTLM_PACKAGES_DIR=${LITERTLM_PACKAGES_DIR}
                -P "${LITERTLM_PACKAGES_DIR}/tflite/tflite_patcher.cmake"

        # --- CMake Configuration ---
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_PREFIX}
            -DCMAKE_POLICY_VERSION_MINIMUM=3.5
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
            -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
            -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DCMAKE_POSITION_INDEPENDENT_CODE=ON
            -DCMAKE_CROSSCOMPILING=ON
            
            # Flags & Versioning
            "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\" -w"
            "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""

            # Host Tools
            -DTFLITE_HOST_TOOLS_DIR=${LITERTLM_INSTALL_DIR}/bin

            # Dependency Injection: Abseil
            -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
            -D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_SRC_DIR}/absl_external/LICENSE
            "-DLITERTLM_ABSL_LIBRARIES=${ABSL_LIBS_FLAT}"
            "-DLITERTLM_ABSL_INCLUDE_DIRS=${ABSL_INCLUDE_DIR}"

            # Dependency Injection: FlatBuffers
            -DFLATBUFFERS_BUILD_FLATC=OFF
            -DFLATBUFFERS_INSTALL=OFF
            "-DFlatBuffers_BINARY_DIR=${FLATBUFFERS_BIN_DIR}"
            "-DFLATBUFFERS_PROJECT_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external"
            "-DFlatBuffers_SOURCE_DIR=${FLATBUFFERS_SRC_DIR}/flatbuffers_external"
            "-D_flatbuffers_LICENSE_FILE=${FLATBUFFERS_SRC_DIR}/flatbuffers_external/LICENSE"
            "-DFLATC_PATHS=${FLATBUFFERS_BIN_DIR}"
            "-DFLATBUFFERS_FLATC_EXECUTABLE=${FLATC_EXECUTABLE}"
            "-Dflatbuffers_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers"
            "-DFLATC_TARGET=${FLATC_EXECUTABLE}"
            "-DFLATC_EXECUTABLE=${FLATC_EXECUTABLE}"

            # Dependency Injection: Protobuf
            -Dprotobuf_BINARY_DIR=${PROTO_BIN_DIR}
            -Dprotobuf_BUILD_PROTOC_BINARIES=OFF
            -Dprotobuf_SOURCE_DIR=${PROTO_SRC_DIR}
            "-DLITERTLM_PROTO_LIBRARIES=${PROTO_LIBS_FLAT}"
            "-DLITERTLM_PROTO_INCLUDE_DIRS=${PROTO_INCLUDE_DIR}"
            "-DLITERTLM_PROTOC_EXECUTABLE=${PROTO_PROTOC_EXECUTABLE}"

            # Dependency Injection: LibPNG
            "-DCMAKE_PREFIX_PATH=${ABSL_INSTALL_PREFIX};${libpng_lib_BINARY_DIR}"
            -DPNG_FOUND=ON
            -DPNG_LIBRARY=${libpng_lib_BINARY_DIR}/libpng.a
            -DPNG_PNG_INCLUDE_DIR=${libpng_lib_SOURCE_DIR}

            # TFLite Feature Flags
            -DTFLITE_ENABLE_INSTALL=OFF
            -DTFLITE_ENABLE_XNNPACK=ON
            -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
            -DXNNPACK_SET_VERBOSITY=OFF
            -DTFLITE_ENABLE_GPU=OFF
            -DTENSORFLOW_SOURCE_DIR=${TENSORFLOW_SOURCE_DIR}
            "-DTFLITE_HOST_TOOLS_DIR=${FLATBUFFERS_BIN_DIR}"
            
            # System Linking
            "-DCMAKE_EXE_LINKER_FLAGS=-L${ABSL_LIB_DIR} -L${PROTO_INSTALL_PREFIX}/lib"
            "-DCMAKE_CXX_STANDARD_LIBRARIES=-lpthread"
            "-DLITERTLM_PACKAGES_DIR=${LITERTLM_PACKAGES_DIR}"
    )

else()
    message(STATUS "[TFLite] Found existing installation at: ${TFLITE_STATIC_LIB}")
    if(NOT TARGET tflite_external)
        add_custom_target(tflite_external)
    endif()
endif()


# ==============================================================================
# SECTION 3: LIBRARY DISCOVERY (THE PRODUCER)
# ==============================================================================
# Glob all TFLite and related dependency libraries.
# We search both the external install lib dir and the internal build dir.
file(GLOB _TFLITE_ALL_STATIC_LIBS 
    "${TFLITE_LIB_DIR}/*.a"
    "${TFLITE_BUILD_DIR}/*.a"
)

if(NOT _TFLITE_ALL_STATIC_LIBS)
    message(WARNING "[TFLite] No static libraries found. Ensure build has completed.")
endif()

# Lists to classify libraries for linking strategy
set(TFLITE_FORCE_LOAD_TARGETS "")  # Core libs requiring --whole-archive
set(TFLITE_STANDARD_TARGETS "")    # Support libs for standard linking

foreach(_LIB_PATH ${_TFLITE_ALL_STATIC_LIBS})
    get_filename_component(_LIB_FILENAME ${_LIB_PATH} NAME)
    
    # Create a sanitized target name (e.g., tflite_imp_libXNNPACK)
    string(REPLACE "." "_" _SAFE_NAME "tflite_imp_${_LIB_FILENAME}")
    
    if(NOT TARGET ${_SAFE_NAME})
        add_library(${_SAFE_NAME} STATIC IMPORTED)
        set_target_properties(${_SAFE_NAME} PROPERTIES IMPORTED_LOCATION "${_LIB_PATH}")
    endif()

    # Classification Logic
    # Core TFLite, LiteRT, and Delegates must be whole-archived for op registration.
    if(_LIB_FILENAME MATCHES "libtensorflow-lite.a" OR 
       _LIB_FILENAME MATCHES "libxnnpack-delegate.a" OR 
       _LIB_FILENAME MATCHES "liblitert")
        list(APPEND TFLITE_FORCE_LOAD_TARGETS ${_SAFE_NAME})
    else()
        list(APPEND TFLITE_STANDARD_TARGETS ${_SAFE_NAME})
    endif()
endforeach()


# ==============================================================================
# SECTION 4: THE KITCHEN SINK INTERFACE
# ==============================================================================
# This creates a single logical target that encapsulates all TFLite complexity.
# Linking against this target automatically handles circular dependencies and
# static symbol registration.

# add_library(tflite_kitchen_sink INTERFACE)
# add_library(LiteRTLM::tflite::tflite ALIAS tflite_kitchen_sink)

# target_include_directories(tflite_kitchen_sink SYSTEM INTERFACE 
#     "${TFLITE_INCLUDE_DIR}"
#     "${TFLITE_BUILD_DIR}" # Required for generated ruy/cpuinfo headers
# )

# target_link_libraries(tflite_kitchen_sink INTERFACE
#     # --- PHASE 1: FORCE LOAD (The Hammer) ---
#     # Ensures registration of static kernels and operators
#     $<$<PLATFORM_ID:Linux,Android,FreeBSD>:-Wl,--whole-archive>
#     $<$<PLATFORM_ID:Darwin>:-Wl,-force_load>
#         ${TFLITE_FORCE_LOAD_TARGETS}
#     $<$<PLATFORM_ID:Linux,Android,FreeBSD>:-Wl,--no-whole-archive>

#     # --- PHASE 2: CIRCULAR DEPENDENCIES (The Group) ---
#     # Handles Math/Utility libs (XNNPACK, Ruy, cpuinfo)
#     $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--start-group>
#         ${TFLITE_STANDARD_TARGETS}
#         # Include Hermetic Shim Dependencies
#         LiteRTLM::absl::absl
#         LiteRTLM::flatbuffers::flatbuffers
#     $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wl,--end-group>

#     # --- PHASE 3: SYSTEM LINKS ---
#     pthread
#     $<$<PLATFORM_ID:Linux>:dl>
#     $<$<PLATFORM_ID:Android>:log>
# )


generate_tflite_aggregate(
    "${TFLITE_FORCE_LOAD_TARGETS}" 
    "${TFLITE_STANDARD_TARGETS}"
    "${TFLITE_INCLUDE_DIR}"
    "${TFLITE_BUILD_DIR}"
)