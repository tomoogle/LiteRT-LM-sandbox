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
