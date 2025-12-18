macro(add_litert_library target_name lib_type)
    add_library(${target_name} ${lib_type} ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()


### [DEPRECATED] [TODO] Refactor to add_litert_library ###
macro(add_litert_static_library target_name)
    add_library(${target_name} STATIC ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()

### [DEPRECATED] [TODO] Refactor to add_litert_library ###
macro(add_litert_interface_library target_name)
    add_library(${target_name} INTERFACE ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()


macro(add_litert_executable target_name)
    add_executable(${target_name} ${ARGN})
    # Inject the critical build order dependency
    add_dependencies(${target_name} litert_external) 
endmacro()






macro(define_litert_target target_name lib_name lib_subdir)
    add_library(${target_name} STATIC IMPORTED)
    set_target_properties(${target_name} PROPERTIES
        IMPORTED_LOCATION "${LITERT_BUILD_DIR}/${lib_subdir}/${lib_name}"
        INTERFACE_INCLUDE_DIRECTORIES "${LITERT_INCLUDE_DIR}"
    )
    add_dependencies(${target_name} litert_external)
endmacro()


macro(define_imported_target target_name lib_name lib_subdir)
    add_library(${target_name} STATIC IMPORTED)
    set_target_properties(${target_name} PROPERTIES
        IMPORTED_LOCATION "${LITERT_BUILD_DIR}/${lib_subdir}/${lib_name}"
        INTERFACE_INCLUDE_DIRECTORIES "${LITERT_INCLUDE_DIR}"
    )
endmacro()
