message(STATUS "[LITERTLM PATCHER] Injecting shim into Abseil-cpp root...")
set(ROOT_LIST "${ABSL_SRC_DIR}/CMakeLists.txt")
if(EXISTS "${ROOT_LIST}")
    file(READ "${ROOT_LIST}" ROOT_CONTENT)

    string(REPLACE "project(absl LANGUAGES CXX VERSION 20250814)" 
               "project(absl LANGUAGES CXX VERSION 20250814)\ninclude(${ABSL_PACKAGE_DIR}/absl_root_shim.cmake)" 
               ROOT_CONTENT "${ROOT_CONTENT}")
    
    file(WRITE "${ROOT_LIST}" "${ROOT_CONTENT}")
    message(STATUS "[LITERTLM PATCHER] Injection successful.")
else()
    message(FATAL_ERROR "Could not find Abseil-cpp CMakeLists.txt at ${ROOT_LIST}")
endif()

set(SRC_LIST "${ABSL_SRC_DIR}/absl/CMakeLists.txt")
if(EXISTS "${SRC_LIST}")
    file(READ "${SRC_LIST}" SRC_CONTENT)

    string(PREPEND SRC_CONTENT "include(${ABSL_PACKAGE_DIR}/absl_src_shim.cmake)\n")
    
    file(WRITE "${SRC_LIST}" "${SRC_CONTENT}")
    message(STATUS "[LITERTLM PATCHER] Injection successful.")
else()
    message(FATAL_ERROR "Could not find Abseil-cpp CMakeLists.txt at ${SRC_LIST}")
endif()