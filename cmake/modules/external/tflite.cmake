include(ExternalProject)

set(TFLITE_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/tensorflow)
set(TFLITE_INSTALL_PREFIX ${TFLITE_EXT_PREFIX}/install)
set(TFLITE_CONFIG_CMAKE_FILE "${TFLITE_INSTALL_PREFIX}/lib/libtensorflow-lite.a")

# --- Parameters for consumption by higher layers (LiteRT-LM) ---
set(TFLITE_INCLUDE_DIR ${TFLITE_INSTALL_PREFIX}/include)
set(TFLITE_LIB_DIR     ${TFLITE_INSTALL_PREFIX}/lib)

if(NOT EXISTS "${TFLITE_CONFIG_CMAKE_FILE}")
  message(STATUS "TFLite not found. Configuring external build...")

  ExternalProject_Add(
    tflite_external
    DEPENDS 
      absl_external
      flatbuffers_external
      protobuf_external
      tokenizers-cpp_external
      googletest_external
    GIT_REPOSITORY
      https://github.com/tensorflow/tensorflow.git
    GIT_TAG
      v2.20.0
    PREFIX
      ${TFLITE_EXT_PREFIX}
    SOURCE_SUBDIR
      tensorflow/lite
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_PREFIX}
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
      -DCMAKE_POLICY_DEFAULT_CMP0170=OLD
      -DCMAKE_CXX_STANDARD=17
      -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON

      "-D_abseil-cpp_LICENSE_FILE:FILEPATH=${ABSL_EXT_PREFIX}/src/absl_external/LICENSE"

      # -DFETCHCONTENT_SOURCE_DIR_ABSEIL_CPP=${ABSL_EXT_PREFIX}/src/absl_external
      -Dabseil-cpp_SOURCE_DIR=${ABSL_EXT_PREFIX}/src/absl_external
      -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
      -Dabseil-cpp_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl


      -Dflatbuffers_DIR=${FLATBUFFERS_INSTALL_PREFIX}/lib/cmake/flatbuffers
      
      -DTFLITE_ENABLE_INSTALL=OFF
      -DTFLITE_ENABLE_XNNPACK=ON
          
      -DTFLITE_ENABLE_RESOURCE_VARIABLE=OFF
      
      -DXNNPACK_SET_VERBOSITY=OFF
      
      "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""
      "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DTF_MAJOR_VERSION=2 -DTF_MINOR_VERSION=20 -DTF_PATCH_VERSION=0 -DTF_VERSION_SUFFIX=\"\""
  )
  
  # Assuming you have a verify_install macro similar to your protobuf setup
  # verify_install(tflite_external ${TFLITE_CONFIG_MARKER})

else()
    message(STATUS "TFLite already installed at: ${TFLITE_INSTALL_PREFIX}")
    if(NOT TARGET tflite_external)
        add_custom_target(tflite_external)
    endif()
endif()



# --- TFLite Manual Imports ---

import_static_lib(imp_tflite_core "${TFLITE_LIB_DIR}/libtensorflow-lite.a")

import_static_lib(imp_xnnpack "${TFLITE_LIB_DIR}/libXNNPACK.a")
import_static_lib(imp_cpuinfo  "${TFLITE_LIB_DIR}/libcpuinfo.a")
import_static_lib(imp_pthreadpool "${TFLITE_LIB_DIR}/libpthreadpool.a")


if(NOT TARGET litertlm-tflite::runtime)
    add_library(litertlm-tflite::runtime INTERFACE)
    
    target_link_libraries(litertlm-tflite::runtime INTERFACE 
        imp_tflite_core
        imp_xnnpack
        imp_cpuinfo
        imp_pthreadpool
    )

    target_include_directories(litertlm-tflite::runtime INTERFACE 
        "${TFLITE_INCLUDE_DIR}"
        "${FLATBUFFERS_INSTALL_PREFIX}/include" 
    )
    add_dependencies(litertlm-tflite::runtime tflite_external)
endif()


# set(TFLITE_EXT_PREFIX ${EXTERNAL_PROJECTS_DIR}/tensorflow)
# set(TFLITE_INSTALL_PREFIX ${TFLITE_EXT_PREFIX}/install)
# set(TFLITE_MARKER_FILE "${TFLITE_INSTALL_PREFIX}/lib/libtensorflow-lite.a")

# if(NOT EXISTS "${TFLITE_MARKER_FILE}")
#     message(STATUS "TFLite not found. Configuring external build with standardized Abseil...")

#     ExternalProject_Add(
#         tflite_external
#         # TFLite depends on Abseil (and often Flatbuffers, but Abseil is the priority here)
#         DEPENDS
#             abseil_external
#             flatbuffers_external
#         GIT_REPOSITORY 
#             https://github.com/tensorflow/tensorflow.git
#         GIT_TAG 
#             v2.20.0
#         PREFIX
#             ${TFLITE_EXT_PREFIX}
#         SOURCE_SUBDIR
#             tensorflow/lite

#         # Manual override to force use of our specific Abseil binaries
#         CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env 
#             "LDFLAGS=-L${ABSL_INSTALL_PREFIX}/lib"
#             "CXXFLAGS=-I${ABSL_INSTALL_PREFIX}/include"
#             ${CMAKE_COMMAND} -S <SOURCE_DIR> -B <BINARY_DIR>
#                 -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_PREFIX}
#                 -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#                 -DCMAKE_CXX_STANDARD=17
#                 -DCMAKE_POSITION_INDEPENDENT_CODE=ON
                
#                 # Force TFLite to use our Abseil "package"
#                 -DTFLITE_ENABLE_EXTERNAL_DELEGATE=ON
#                 -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
                
#                 # The "Sentencepiece Hack": Force the linker to use our Abseil objects 
#                 # to satisfy TFLite's internal dependencies during its own build/test phase
#                 "-DCMAKE_CXX_STANDARD_LIBRARIES=-Wl,--start-group -labsl_status -labsl_statusor -labsl_raw_logging_internal -labsl_base -labsl_throw_delegate -labsl_int128 -labsl_log_internal_check_op -labsl_log_internal_message -labsl_log_internal_nullguard -labsl_strings -labsl_string_view -labsl_synchronization -labsl_debugging_internal -labsl_time -labsl_time_zone -labsl_utf8_for_code_point -Wl,--end-group -lpthread -lm -ldl"
                
#                 # Disable TFLite's internal fetchers to ensure it doesn't ignore our flags
#                 -DTFLITE_ENABLE_INSTALL=ON
#                 -DFETCHCONTENT_FULLY_DISCONNECTED=ON 
#     )

# else()
#     message(STATUS "TFLite already installed at: ${TFLITE_INSTALL_PREFIX}")
#     if(NOT TARGET tflite_external)
#         add_custom_target(tflite_external)
#     endif()
# endif()




# set(TFLITE_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/tensorflow")
# set(TFLITE_INSTALL_DIR "${TFLITE_PREFIX}/install")

# ExternalProject_Add(
#     tflite_external
#     GIT_REPOSITORY      https://github.com/tensorflow/tensorflow.git
#     GIT_TAG             v2.20.0  
#     PREFIX              ${TFLITE_PREFIX}
#     SOURCE_SUBDIR       tensorflow/lite
    
#     CMAKE_ARGS
#         -DCMAKE_INSTALL_PREFIX=${TFLITE_INSTALL_DIR}
#         -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#         -DCMAKE_POSITION_INDEPENDENT_CODE=ON
#         -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
#         -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
#         -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        
# )



# # --- TFLite Libs ---
# set(TFLITE_PROFILING_SRC_DIR
#     "${CMAKE_BINARY_DIR}/litert/src/tflite_external/tflite/profiling"
# )

# set(TFLITE_PROFILING_SOURCES
#     "${TFLITE_PROFILING_SRC_DIR}/memory_usage_monitor.cc"
#     "${TFLITE_PROFILING_SRC_DIR}/memory_info.cc"
# )

# add_library(tflite_profiling_monitor STATIC ${TFLITE_PROFILING_SOURCES})
# target_include_directories(tflite_profiling_monitor
#     PRIVATE
#         ${LITERT_INCLUDE_DIR}
#         ${_LITERT_SRC_DIR}
#         ${_LITERT_ABSL_SRC_DIR}
# )
# target_link_libraries(tflite_profiling_monitor PRIVATE
#     absl_synchronization_libs
#     absl_time_libs
#     litert_logging
#     tensorflow-lite
#     m pthread
# )
# add_dependencies(tflite_profiling_monitor tflite_external)




# add_library(tflite_extra_libs INTERFACE)
# target_link_libraries(tflite_extra_libs INTERFACE
#   tflite_profiling_monitor
# )
