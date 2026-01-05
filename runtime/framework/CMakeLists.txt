set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# ==============================================================================
# 1. Thread Options
#    Bazel: cc_library(name = "thread_options" ...)
# ==============================================================================
add_litertlm_library(runtime_framework_thread_options INTERFACE)
add_library(LiteRTLM::Framework::ThreadOptions ALIAS runtime_framework_thread_options)

target_include_directories(runtime_framework_thread_options 
  INTERFACE 
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

# ==============================================================================
# 2. Thread Pool
#    Bazel: cc_library(name = "threadpool" ...)
# ==============================================================================

# [FIX] Implement Platform Selection Logic (Bazel's 'select')
set(THREADPOOL_SRCS
  threadpool.cc
  worker_thread.cc
)

if(WIN32 OR LITERTLM_USE_STD_THREAD)
  list(APPEND THREADPOOL_SRCS worker_thread_std_thread.cc)
else()
  # Default for Linux/Android/macOS
  list(APPEND THREADPOOL_SRCS worker_thread_pthread.cc)
endif()

add_litertlm_library(runtime_framework_threadpool STATIC
  ${THREADPOOL_SRCS}
)
add_library(LiteRTLM::Framework::ThreadPool ALIAS runtime_framework_threadpool)

target_include_directories(runtime_framework_threadpool 
  PUBLIC 
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

target_link_libraries(runtime_framework_threadpool
  PUBLIC 
    LiteRTLM::Framework::ThreadOptions 
    LITERTLM_DEPS
    litert_libs
)

# ==============================================================================
# 3. Folder Facade
# ==============================================================================
add_library(runtime_framework_libs INTERFACE)
add_library(LiteRTLM::Framework ALIAS runtime_framework_libs)

target_link_libraries(runtime_framework_libs INTERFACE
  LiteRTLM::Framework::ThreadOptions
  LiteRTLM::Framework::ThreadPool
)