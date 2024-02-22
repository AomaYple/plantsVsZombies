cmake_minimum_required(VERSION 3.28.3)

project(PlantsVsZombies)

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

        $<$<AND:$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>,$<CONFIG:Debug>>:-Og -fsanitize=address>
        $<$<AND:$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>,$<CONFIG:Release>>:-Ofast>
        $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/fsanitize=address>
)

target_link_options(${PROJECT_NAME} PRIVATE
        $<$<AND:$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>,$<CONFIG:Debug>>:-fsanitize=address>
)

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt6::Quick
        Qt6::Multimedia
)

qt_add_qml_module(${PROJECT_NAME}
        URI ${PROJECT_NAME}

        SOURCES
        src/main.cpp

        QML_FILES
        src/qml/DaytimeGrass.qml
        src/qml/main.qml
        src/qml/MainMenu.qml
        src/qml/PopCapLogo.qml
        src/qml/SeedBank.qml
        src/qml/ShovelBank.qml
        src/qml/TitleScreen.qml
        src/qml/Zombie.qml

        RESOURCES
        resources/gif/basicZombieStand1.gif
        resources/gif/basicZombieStand2.gif

        resources/images/daytimeGrass.png
        resources/images/favicon.ico
        resources/images/loadBar.png
        resources/images/mainMenu.png
        resources/images/menuBack.png
        resources/images/popCapLogo.png
        resources/images/quit.png
        resources/images/quitHighlight.png
        resources/images/seedBank.png
        resources/images/shadow.png
        resources/images/shovel.png
        resources/images/shovelBank.png
        resources/images/startAdventure.png
        resources/images/startAdventureHighlight.png
        resources/images/startPlant.png
        resources/images/startReady.png
        resources/images/startSet.png
        resources/images/titleScreen.png
        resources/images/zombieHand1.png
        resources/images/zombieHand2.png
        resources/images/zombieHand3.png
        resources/images/zombieHand4.png
        resources/images/zombieHand5.png
        resources/images/zombieHand6.png
        resources/images/zombieHand7.png

        resources/music/ChooseYourSeeds.flac
        resources/music/CrazyDave.flac
        resources/music/GrassWalk.flac

        resources/sounds/bleep.wav
        resources/sounds/evilLaugh.flac
        resources/sounds/readySetPlant.flac
        resources/sounds/shovel.flac

        NO_RESOURCE_TARGET_PATH
)
