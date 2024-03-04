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
        src/scenes/BasicZombieStand.qml
        src/scenes/DaytimeGrass.qml
        src/scenes/LoadBar.qml
        src/scenes/LoadScreen.qml
        src/scenes/main.qml
        src/scenes/MainMenu.qml
        src/scenes/MenuButton.qml
        src/scenes/MenuDialog.qml
        src/scenes/QuitButton.qml
        src/scenes/ReadySetPlant.qml
        src/scenes/SeedBank.qml
        src/scenes/ShovelBank.qml
        src/scenes/StartAdventure.qml
        src/scenes/ZombieHandRise.qml

        RESOURCES
        resources/music/chooseYourSeeds.flac
        resources/music/crazyDave.flac
        resources/music/grassWalk.flac

        resources/scenes/button.png
        resources/scenes/daytimeGrass.png
        resources/scenes/favicon.ico
        resources/scenes/loadBar.png
        resources/scenes/mainMenu.png
        resources/scenes/optionsMenuBackground.png
        resources/scenes/optionsMenuButton.png
        resources/scenes/popCapLogo.png
        resources/scenes/quit.png
        resources/scenes/quitHighlight.png
        resources/scenes/seedBank.png
        resources/scenes/shadow.png
        resources/scenes/shovel.png
        resources/scenes/shovelBank.png
        resources/scenes/startAdventure.png
        resources/scenes/startAdventureHighlight.png
        resources/scenes/startPlant.png
        resources/scenes/startReady.png
        resources/scenes/startSet.png
        resources/scenes/titleScreen.png
        resources/scenes/zombieHandRise.gif

        resources/sounds/bleep.wav
        resources/sounds/evilLaugh.wav
        resources/sounds/pause.wav
        resources/sounds/readySetPlant.wav
        resources/sounds/shovel.wav

        resources/zombies/basicZombieAttack.gif
        resources/zombies/basicZombieStand0.gif
        resources/zombies/basicZombieStand1.gif
        resources/zombies/basicZombieWalk0.gif
        resources/zombies/basicZombieWalk1.gif

        NO_RESOURCE_TARGET_PATH
)
