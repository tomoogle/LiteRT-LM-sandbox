include(FetchContent)

set(ANTLR_SRC_DIR ${CMAKE_BINARY_DIR}/_deps/antlr_lib-src/runtime/Cpp/runtime/src)
FetchContent_Declare(
  antlr_lib
  GIT_REPOSITORY https://github.com/antlr/antlr4.git
  # GIT_TAG faa457ae5b9c39b572334814f0b36c855bc23010
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_SUBDIR runtime/Cpp

)
block()
  set(CMAKE_POLICY_VERSION_MINIMUM "3.5")
  set(ANTLR_BUILD_STATIC)
  FetchContent_MakeAvailable(antlr_lib)
endblock()


set(LIBPNG_SRC_DIR ${THIRD_PARTY_DIR}/libpng)
FetchContent_Declare(
  libpng_lib
  GIT_REPOSITORY https://github.com/glennrp/libpng.git
  GIT_TAG v1.6.40
  GIT_SHALLOW true
  SOURCE_DIR ${LIBPNG_SRC_DIR}
)
block()
  set(PNG_SHARED OFF)
  set(PNG_TESTS OFF)
  set(PNG_EXECUTABLES OFF)
  set(SKIP_INSTALL_ALL ON)

  if(TARGET zlib)
    get_target_property(ZLIB_INCLUDE_DIR zlib INTERFACE_INCLUDE_DIRECTORIES)
    set(ZLIB_LIBRARY zlib)
  elseif(TARGET zlibstatic)
    get_target_property(ZLIB_INCLUDE_DIR zlibstatic INTERFACE_INCLUDE_DIRECTORIES)
    set(ZLIB_LIBRARY zlibstatic)
  endif()

  FetchContent_MakeAvailable(libpng_lib)
endblock()
if(NOT TARGET PNG::PNG)
  add_library(PNG::PNG ALIAS png_static)
endif()


set(KISSFFT_SRC_DIR ${THIRD_PARTY_DIR}/kissfft)
FetchContent_Declare(
  kissfft_lib
  GIT_REPOSITORY https://github.com/mborgerding/kissfft
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${KISSFFT_SRC_DIR}
)
block()
  cmake_policy(SET CMP0077 OLD)
  set(KISSFFT_TEST OFF)
  set(KISSFFT_TOOLS OFF)
  FetchContent_MakeAvailable(kissfft_lib)
endblock()








set(MINIAUDIO_SRC_DIR ${THIRD_PARTY_DIR}/miniaudio)
FetchContent_Declare(
  miniaudio_lib
  GIT_REPOSITORY https://github.com/mackron/miniaudio
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${MINIAUDIO_SRC_DIR}
)
FetchContent_MakeAvailable(miniaudio_lib)


set(MINIZIP_SRC_DIR ${THIRD_PARTY_DIR}/minizip)
FetchContent_Declare(
  minizip_lib
  GIT_REPOSITORY https://github.com/domoticz/minizip
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${MINIZIP_SRC_DIR}
)
  FetchContent_MakeAvailable(minizip_lib)


set(MINJA_SRC_DIR ${THIRD_PARTY_DIR}/minja)
FetchContent_Declare(
  minja_lib
  GIT_REPOSITORY https://github.com/google/minja
  GIT_TAG main
  GIT_SHALLOW true
  SOURCE_DIR ${MINJA_SRC_DIR}
)
set(MINJA_TEST_ENABLED OFF)
FetchContent_MakeAvailable(minja_lib)


set(JSON_SRC_DIR ${THIRD_PARTY_DIR}/json)
FetchContent_Declare(
  json_lib
  GIT_REPOSITORY https://github.com/nlohmann/json
  GIT_TAG v3.12.0
  GIT_SHALLOW true
  SOURCE_DIR ${JSON_SRC_DIR}
)
FetchContent_Populate(json_lib)


set(STB_SRC_DIR ${THIRD_PARTY_DIR}/stb_lib)
FetchContent_Declare(
  stb_lib
  GIT_REPOSITORY https://github.com/nothings/stb.git
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${STB_SRC_DIR}
)
FetchContent_Populate(stb_lib)


set(ZLIB_SRC_DIR ${THIRD_PARTY_DIR}/zlib)
FetchContent_Declare(
  zlib_lib
  GIT_REPOSITORY https://github.com/madler/zlib
  GIT_TAG master
  GIT_SHALLOW true
  SOURCE_DIR ${ZLIB_SRC_DIR}
)
block()
  set(BUILD_SHARED_LIBS OFF)
  FetchContent_MakeAvailable(zlib_lib)
endblock()



set(FETCHCONTENT_MODULE_SRC_DIRS
  ${ANTLR_SRC_DIR}
  ${KISSFFT_SRC_DIR}
  ${MINIAUDIO_SRC_DIR}
  ${MINIZIP_SRC_DIR}
  ${MINJA_SRC_DIR}
  ${JSON_SRC_DIR}
  ${STB_SRC_DIR}
  ${ZLIB_SRC_DIR}
)


set(FETCHCONTENT_MODULE_INCLUDE_DIR
  ${ANTLR_SRC_DIR}
  ${KISSFFT_SRC_DIR}
  ${MINIAUDIO_SRC_DIR}
  ${MINIZIP_SRC_DIR}/minizip
  ${MINJA_SRC_DIR}/include
  ${JSON_SRC_DIR}/include
  ${STB_SRC_DIR}
  ${ZLIB_SRC_DIR}
)