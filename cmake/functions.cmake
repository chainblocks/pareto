function(target_exception_options TARGET_NAME)
    if (MSVC)
        # MSVC requires this flag if the code uses C++ exception handling
        target_compile_options(${TARGET_NAME} PRIVATE /EHsc)
    endif()
endfunction()

function(target_bigobj_options TARGET_NAME)
    if (MSVC)
        # MSVC requires this flag if the file has a lot of code
        target_compile_options(${TARGET_NAME} PRIVATE /bigobj)
    endif()
endfunction()

function(target_pedantic_options TARGET_NAME)
    # Set warning levels to about the same level for MSVC, GCC, and Clang
    if (BUILD_WITH_PEDANTIC_WARNINGS)
        if (MSVC)
            target_compile_options(${TARGET_NAME} PRIVATE /W4 /WX)
        else()
            target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra -pedantic -Werror)
        endif()
    endif()
endfunction()

function(target_msvc_compile_options TARGET_NAME DEFINITION)
    if(MSVC)
        target_compile_options(${TARGET_NAME} PUBLIC ${DEFINITION})
    endif()
endfunction()

function(target_longtests_definitions TARGET_NAME)
    if (BUILD_LONG_TESTS)
        target_compile_definitions(${TARGET_NAME} PUBLIC BUILD_LONG_TESTS)
    endif()
endfunction()

function(set_master_project_vars)
    if (${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
        set(MASTER_PROJECT ON PARENT_SCOPE)
    else()
        set(MASTER_PROJECT OFF PARENT_SCOPE)
    endif()
endfunction()

function(set_debug_booleans)
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(DEBUG_MODE ON PARENT_SCOPE)
        set(NOT_DEBUG_MODE OFF PARENT_SCOPE)
        set(RELEASE_MODE OFF PARENT_SCOPE)
        set(NOT_RELEASE_MODE ON PARENT_SCOPE)
    else ()
        set(DEBUG_MODE OFF PARENT_SCOPE)
        set(NOT_DEBUG_MODE ON PARENT_SCOPE)
        set(RELEASE_MODE ON PARENT_SCOPE)
        set(NOT_RELEASE_MODE OFF PARENT_SCOPE)
    endif ()
endfunction()

macro(add_sanitizer flag)
    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=${flag} -fno-omit-frame-pointer")
        set(DCMAKE_C_FLAGS "${DCMAKE_C_FLAGS} -fsanitize=${flag} -fno-omit-frame-pointer")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=${flag}")
        set(DCMAKE_MODULE_LINKER_FLAGS "${DCMAKE_MODULE_LINKER_FLAGS} -fsanitize=${flag}")
    endif()
endmacro()

macro(add_address_sanitizer)
    add_sanitizer("address")
endmacro()

macro(add_thread_sanitizer)
    add_sanitizer("thread")
endmacro()

macro(add_undefined_sanitizer)
    add_sanitizer("undefined")
endmacro()

macro(add_memory_sanitizer)
    add_sanitizer("memory")
endmacro()

macro(add_leak_sanitizer)
    add_sanitizer("leak")
endmacro()

macro(add_all_sanitizers)
    add_address_sanitizer()
    add_leak_sanitizer()
    add_undefined_sanitizer()
    # add_thread_sanitizer() # not allowed with address
    # add_memory_sanitizer() # not supported with darwin20.1.0
endmacro()