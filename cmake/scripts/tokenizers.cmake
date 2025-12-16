include(ExternalProject)


set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

ExternalProject_Add(
    tokenizers_external
    GIT_REPOSITORY      https://github.com/mlc-ai/tokenizers-cpp
    GIT_TAG             v0.1.1
    PREFIX              ${EXTERNAL_PROJECTS_DIR}/tokenizers
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_POLICY_DEFAULT_CMP0169=OLD
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DSPM_USE_EXTERNAL_ABSL=ON
        -DSPM_USE_BUILTIN_PROTOBUF=OFF
        -DCMAKE_PREFIX_PATH=${ABSL_INSTALL_DIR};${PROTOBUF_INSTALL_DIR}
        -Dabsl_DIR=${EXTERNAL_PROJECTS_DIR}/abseil-cpp/install/lib/cmake/absl
)
