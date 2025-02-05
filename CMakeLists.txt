cmake_minimum_required(VERSION 3.30)

project(plantsVsZombies)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)
qt_policy(SET QTP0004 NEW)

qt_add_executable(${PROJECT_NAME})

set_target_properties(${PROJECT_NAME}
        PROPERTIES
        CXX_STANDARD ${CMAKE_CXX_STANDARD_LATEST}
        CXX_STANDARD_REQUIRED ON
        COMPILE_WARNING_AS_ERROR ON
        INTERPROCEDURAL_OPTIMIZATION_RELEASE TRUE
        AUTOMOC ON
        WIN32_EXECUTABLE $<$<CONFIG:Release>:TRUE>
        MACOSX_BUNDLE $<$<CONFIG:Release>:TRUE>
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}
)

option(NATIVE "Enable native optimization")
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options(${PROJECT_NAME}
            PRIVATE
            -Wall -Wextra -Wpedantic
            $<$<CONFIG:Debug>:-g3 -ggdb3 -Og -fsanitize=address -fsanitize=leak -fsanitize=undefined>
            $<$<CONFIG:Release>:-Ofast>
            $<$<AND:$<CONFIG:Release>,$<BOOL:${NATIVE}>>:-march=native>
    )
    target_link_options(${PROJECT_NAME}
            PRIVATE
            $<$<CONFIG:Debug>:-fsanitize=address -fsanitize=leak -fsanitize=undefined>
    )
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    target_compile_options(${PROJECT_NAME}
            PRIVATE
            -stdlib=libc++
            -Wall -Wextra -Wpedantic
            $<$<CONFIG:Debug>:-g3 -ggdb3 -glldb -Og -fsanitize=address -fsanitize=leak -fsanitize=undefined>
            $<$<CONFIG:Release>:-O3 -ffast-math>
            $<$<AND:$<CONFIG:Release>,$<BOOL:${NATIVE}>>:-march=native>
    )
    target_link_options(${PROJECT_NAME}
            PRIVATE
            $<$<CONFIG:Debug>:-fsanitize=address -fsanitize=leak -fsanitize=undefined>
    )
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${PROJECT_NAME}
            PRIVATE
            /permissive- /utf-8 /W4 /MP
            $<$<CONFIG:Debug>:/sdl /fsanitize=address>
            $<$<CONFIG:Release>:/Ob3 /GT /Gy /fp:fast>
    )

    target_link_options(${PROJECT_NAME}
            PRIVATE
            $<$<CONFIG:Release>:/OPT:REF,ICF /LTCG:incremental>
    )
endif ()

target_link_libraries(${PROJECT_NAME}
        PRIVATE
        Qt6::Quick
        Qt6::Multimedia
)

function(removePrefix FILES)
    set(REPLACED_FILES)
    foreach (FILE ${FILES})
        string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR}/ "" REPLACED_FILE ${FILE})
        list(APPEND REPLACED_FILES ${REPLACED_FILE})
    endforeach ()
    set(REPLACED_FILES ${REPLACED_FILES} PARENT_SCOPE)
endfunction()

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
        src/*.cpp
)
removePrefix("${SOURCES}")
set(SOURCES ${REPLACED_FILES})

file(GLOB_RECURSE QML_FILES CONFIGURE_DEPENDS
        src/*.qml
        src/*.js
)
removePrefix("${QML_FILES}")
set(QML_FILES ${REPLACED_FILES})

file(GLOB_RECURSE RESOURCES CONFIGURE_DEPENDS
        res/*
)
removePrefix("${RESOURCES}")
set(RESOURCES ${REPLACED_FILES})

qt_add_qml_module(${PROJECT_NAME}
        URI
        ${PROJECT_NAME}

        SOURCES
        ${SOURCES}

        QML_FILES
        ${QML_FILES}

        RESOURCES
        ${RESOURCES}

        DEPENDENCIES
        QtQuick
        QtMultimedia

        NO_RESOURCE_TARGET_PATH
)
