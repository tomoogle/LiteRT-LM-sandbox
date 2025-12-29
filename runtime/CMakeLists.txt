add_subdirectory(components)
add_subdirectory(conversation)
# add_subdirectory(conversation/model_data_processor)
add_subdirectory(core)
add_subdirectory(engine)
add_subdirectory(executor)
add_subdirectory(framework)
add_subdirectory(proto)
add_subdirectory(testdata)
add_subdirectory(util)



# runtime/CMakeLists.txt

# 1. Util MUST be first so "ConvertTensorBuffer" is defined
# add_subdirectory(util)

# # 2. Components can now link to Util
# add_subdirectory(components)

# # 3. Conversation / Core / Engine follow...
# add_subdirectory(conversation)
# add_subdirectory(core)
# add_subdirectory(engine)
# add_subdirectory(executor)
