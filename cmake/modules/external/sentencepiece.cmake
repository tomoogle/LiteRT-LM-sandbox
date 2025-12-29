include(ExternalProject)

set(SENTENCE_EXT_PREFIX ${EXTERNAL_PROJECT_BINARY_DIR}/sentencepiece)
set(SENTENCE_INSTALL_PREFIX ${SENTENCE_EXT_PREFIX}/install)
set(SENTENCE_INCLUDE_DIR ${SENTENCE_INSTALL_PREFIX}/include)

# Detect lib vs lib64
if(EXISTS "${SENTENCE_INSTALL_PREFIX}/lib64")
  set(SENTENCE_LIB_DIR "${SENTENCE_INSTALL_PREFIX}/lib64")
else()
  set(SENTENCE_LIB_DIR "${SENTENCE_INSTALL_PREFIX}/lib")
endif()

set(SENTENCE_LIBRARY_STATIC "${SENTENCE_LIB_DIR}/libsentencepiece.a")
set(SENTENCE_LIBRARY_TRAIN  "${SENTENCE_LIB_DIR}/libsentencepiece_train.a")


set(ABSL_LINK_FLAGS "-L${ABSL_LIB_DIR} -Wl,--start-group -l:libabsl_*.a -Wl,--end-group -lpthread")


if(NOT EXISTS "${SENTENCE_LIBRARY_STATIC}")
  message(STATUS "SentencePiece not found. Configuring external build...")
  
  ExternalProject_Add(
    sentencepiece_external
    DEPENDS 
      absl_external
      protobuf_external
    GIT_REPOSITORY https://github.com/google/sentencepiece.git
    GIT_TAG        v0.2.1
    PREFIX         ${SENTENCE_EXT_PREFIX}
    
    PATCH_COMMAND
      ${CMAKE_COMMAND} -E remove_directory <SOURCE_DIR>/third_party/abseil-cpp
      COMMAND ${CMAKE_COMMAND} -E remove_directory <SOURCE_DIR>/third_party/protobuf
      
      # Step 2: Remove C++17 enforcement
      COMMAND sed -i "/set(CMAKE_CXX_STANDARD 17)/d" <SOURCE_DIR>/CMakeLists.txt
      
      # # Step 3: Append logic to link Abseil to SentencePiece targets
      # # We use 'bash -c' because '>>' redirection is a shell feature.
      # COMMAND bash -c "echo '' >> <SOURCE_DIR>/src/CMakeLists.txt"
      # COMMAND bash -c "echo '# --- PATCH: Force link Abseil for Protobuf dependencies ---' >> <SOURCE_DIR>/src/CMakeLists.txt"
      # COMMAND bash -c "echo 'file(GLOB ALL_ABSL_LIBS \"${ABSL_INSTALL_PREFIX}/lib/libabsl_*.a\")' >> <SOURCE_DIR>/src/CMakeLists.txt"
      # COMMAND bash -c "echo 'target_link_libraries(sentencepiece-static PUBLIC \${ALL_ABSL_LIBS})' >> <SOURCE_DIR>/src/CMakeLists.txt"
      # COMMAND bash -c "echo 'target_link_libraries(sentencepiece_train-static PUBLIC \${ALL_ABSL_LIBS})' >> <SOURCE_DIR>/src/CMakeLists.txt"



    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${SENTENCE_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5
      
      # Force C++20
      -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
      -DCMAKE_CXX_STANDARD_REQUIRED=ON
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      
      # "-DCMAKE_EXE_LINKER_FLAGS=${ABSL_LINK_FLAGS}"
      # "-DCMAKE_SHARED_LINKER_FLAGS=${ABSL_LINK_FLAGS}"


      # --- THE FIX ---
      # 1. Tell the linker where to look for libraries (-L)
      "-DCMAKE_SHARED_LINKER_FLAGS=-L${ABSL_LIB_DIR}"
      
      "-DCMAKE_EXE_LINKER_FLAGS=-L${ABSL_INSTALL_PREFIX}/lib -L${PROTO_INSTALL_PREFIX}/lib"
      
      "-DCMAKE_CXX_STANDARD_LIBRARIES= \
          -lprotobuf -lutf8_range \
          -Wl,--start-group \
          -labsl_leak_check \
          -labsl_cordz_handle -labsl_crc32c -labsl_crc_internal -labsl_crc_cpu_detect \
          -labsl_symbolize -labsl_stacktrace -labsl_debugging_internal -labsl_examine_stack \
          -labsl_log_internal_check_op -labsl_log_internal_message \
          -labsl_log_internal_globals -labsl_log_globals -labsl_log_sink \
          -labsl_log_internal_log_sink_set -labsl_log_internal_format \
          -labsl_log_internal_conditions -labsl_log_internal_nullguard \
          -labsl_status -labsl_statusor -labsl_raw_logging_internal \
          -labsl_base -labsl_throw_delegate -labsl_int128 \
          -labsl_strings -labsl_string_view -labsl_synchronization \
          -labsl_time -labsl_time_zone -labsl_utf8_for_code_point \
          -Wl,--end-group \
          -lpthread"

      # Provider Settings
      -DSPM_ABSL_PROVIDER=package
      -DSPM_PROTOBUF_PROVIDER=package
      -DSPM_ENABLE_SHARED=OFF
      -DSPM_ENABLE_TCMALLOC=OFF
      -DCMAKE_PREFIX_PATH="${ABSL_INSTALL_PREFIX};${PROTO_INSTALL_PREFIX}"
      
      -Dabsl_DIR=${ABSL_INSTALL_PREFIX}/lib/cmake/absl
      -DABSL_INCLUDE_DIRS=${ABSL_INCLUDE_DIR}

      -DProtobuf_DIR=${PROTO_INSTALL_PREFIX}/lib/cmake/protobuf
      -DProtobuf_LIBRARIES=${PROTO_LIB_DIR}
      -DProtobuf_INCLUDE_DIR=${PROTO_INCLUDE_DIR}
      -DProtobuf_LIBRARY_DEBUG=${PROTO_LIB_DIR}/libprotobuf.a
      -DProtobuf_LIBRARY_RELEASE=${PROTO_LIB_DIR}/libprotobuf.a
      -DProtobuf_LITE_LIBRARY_DEBUG=${PROTO_LIB_DIR}/libprotobuf-lite.a
      -DProtobuf_LITE_LIBRARY_RELEASE=${PROTO_LIB_DIR}/libprotobuf-lite.a
      -DProtobuf_PROTOC_EXECUTABLE=${PROTO_PROTOC_EXECUTABLE}
      -DProtobuf_PROTOC_LIBRARY_DEBUG=${PROTO_LIB_DIR}/libprotoc.a
      -DProtobuf_PROTOC_LIBRARY_RELEASE=${PROTO_LIB_DIR}/libprotoc.a

  )
else()
  if(NOT TARGET sentencepiece_external)
    add_custom_target(sentencepiece_external)
  endif()
endif()

# Import Libs
import_static_lib(imp_sentencepiece       "${SENTENCE_LIBRARY_STATIC}")
import_static_lib(imp_sentencepiece_train "${SENTENCE_LIBRARY_TRAIN}")

add_library(sentencepiece_libs INTERFACE)
target_include_directories(sentencepiece_libs INTERFACE ${SENTENCE_INCLUDE_DIR})

target_link_libraries(sentencepiece_libs INTERFACE 
    imp_sentencepiece
    imp_sentencepiece_train
    absl_libs 
    proto_lib
)