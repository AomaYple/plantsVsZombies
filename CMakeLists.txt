cmake_minimum_required(VERSION 3.30.3)

project(plantsVsZombies)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)

qt_add_executable(${PROJECT_NAME})

set_target_properties(${PROJECT_NAME} PROPERTIES
        CXX_STANDARD 23
        CXX_STANDARD_REQUIRED ON
        AUTOMOC ON
        WIN32_EXECUTABLE $<$<CONFIG:Debug>:TRUE,FALSE>
        MACOSX_BUNDLE $<$<CONFIG:Debug>:TRUE,FALSE>
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}
)

target_compile_options(${PROJECT_NAME} PRIVATE
        $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra -Wpedantic>
        $<$<CXX_COMPILER_ID:Clang>:-Weverything>
        $<$<CXX_COMPILER_ID:MSVC>:/Wall>

        $<$<AND:$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>,$<CONFIG:Debug>>:-Og>
        $<$<AND:$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>,$<CONFIG:Release>>:-Ofast>
)

target_link_libraries(${PROJECT_NAME} PRIVATE
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

file(GLOB_RECURSE QML_FILES CONFIGURE_DEPENDS src/*.qml src/*.js)
removePrefix("${QML_FILES}")
set(QML_FILES ${REPLACED_FILES})

file(GLOB_RECURSE RESOURCES CONFIGURE_DEPENDS resources/*)
removePrefix("${RESOURCES}")
set(RESOURCES ${REPLACED_FILES})

qt_add_qml_module(${PROJECT_NAME}
        URI ${PROJECT_NAME}

        SOURCES
        src/main.cpp

        QML_FILES
        ${QML_FILES}

        RESOURCES
        ${RESOURCES}

        DEPENDENCIES
        QtQuick
        QtMultimedia

        NO_RESOURCE_TARGET_PATH
)
