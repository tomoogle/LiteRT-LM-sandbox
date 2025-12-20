set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Thread Options ---
add_litertlm_library(runtime_framework_thread_options INTERFACE)
add_library(LiteRTLM::Framework::ThreadOptions ALIAS runtime_framework_thread_options)

target_include_directories(runtime_framework_thread_options 
  INTERFACE 
    ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- Thread Pool ---
add_litertlm_library(runtime_framework_threadpool STATIC
  threadpool.cc
  worker_thread.cc
  worker_thread_std_thread.cc
  worker_thread_pthread.cc
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
  PRIVATE 
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(runtime_framework_libs INTERFACE)
add_library(LiteRTLM::Framework ALIAS runtime_framework_libs)

target_link_libraries(runtime_framework_libs INTERFACE
  LiteRTLM::Framework::ThreadOptions
  LiteRTLM::Framework::ThreadPool
)