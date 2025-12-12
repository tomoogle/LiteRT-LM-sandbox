set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

add_litert_library(runtime_framework_thread_options INTERFACE)
target_include_directories(runtime_framework_thread_options INTERFACE ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS})

add_litert_library(runtime_framework_threadpool STATIC
  threadpool.cc
  worker_thread.cc
  worker_thread_std_thread.cc
  worker_thread_pthread.cc
)
target_include_directories(runtime_framework_threadpool PUBLIC ${PKG_ROOT}
    ${LITERTLM_INCLUDE_PATHS})
target_link_libraries(runtime_framework_threadpool
  PUBLIC 
  runtime_framework_thread_options
  PRIVATE 
  LITERTLM_DEPS
  litert_libs
  )

# add_litert_executable(runtime_framework_threadpool_test
#   threadpool_test.cc
# )
# target_link_libraries(runtime_framework_threadpool_test PRIVATE
#   runtime_framework_thread_options
#   runtime_framework_threadpool
#   runtime_util_test_utils
#   ${LITERTLM_DEPS}
#   ${absl_libs}
# )
# add_test(NAME runtime_framework_threadpool_test COMMAND threadpool_test)

# Unsupported rule config_setting for //runtime/framework:litert_lm_std_thread

add_library(runtime_framework_libs INTERFACE)
target_link_libraries(runtime_framework_libs INTERFACE
  runtime_framework_threadpool
)