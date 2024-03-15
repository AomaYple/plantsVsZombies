cmake_minimum_required(VERSION 3.29.0-rc4)

project(PlantsVsZombies)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)

qt_add_executable(${PROJECT_NAME})

set_target_properties(${PROJECT_NAME} PROPERTIES
        CXX_STANDARD 23
        CXX_STANDARD_REQUIRED ON
        AUTOMOC ON
        WIN32_EXECUTABLE $<$<CONFIG:Debug>:TRUE,FALSE>
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}
)

target_compile_options(${PROJECT_NAME} PRIVATE
        /Wall
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
        src/js/common.js

        src/plants/Pea.qml
        src/plants/PeaShooter.qml
        src/plants/Plant.qml
        src/plants/PlantType.qml
        src/plants/Sunflower.qml

        src/scenes/DaytimeGrass.qml
        src/scenes/LoadBar.qml
        src/scenes/LoadScreen.qml
        src/scenes/MainMenu.qml
        src/scenes/MenuButton.qml
        src/scenes/MenuDialog.qml
        src/scenes/PlantArea.qml
        src/scenes/PreviewPlant.qml
        src/scenes/QuitButton.qml
        src/scenes/ReadySetPlant.qml
        src/scenes/Seed.qml
        src/scenes/SeedBank.qml
        src/scenes/Shadow.qml
        src/scenes/Shovel.qml
        src/scenes/ShovelBank.qml
        src/scenes/StartAdventure.qml
        src/scenes/Sunlight.qml
        src/scenes/SunlightProducer.qml
        src/scenes/SuspendableTimer.qml
        src/scenes/ZombieHandRise.qml
        src/scenes/ZombieProducer.qml

        src/zombies/BasicZombie.qml
        src/zombies/BasicZombieStand.qml
        src/zombies/Zombie.qml
        src/zombies/ZombieType.qml

        src/main.qml

        RESOURCES
        resources/music/chooseYourSeeds.flac
        resources/music/crazyDave.flac
        resources/music/grassWalk.flac

        resources/plants/pea.png
        resources/plants/peaShooter.gif
        resources/plants/peaShooter.png
        resources/plants/peaShooterSeed.png
        resources/plants/peaShooterShooting.gif
        resources/plants/sunflower.gif
        resources/plants/sunflower.png
        resources/plants/sunflowerSeed.png

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
        resources/scenes/sunlight.gif
        resources/scenes/titleScreen.png
        resources/scenes/zombieHandRise.gif

        resources/sounds/bleep.wav
        resources/sounds/buzzer.wav
        resources/sounds/chomp0.wav
        resources/sounds/chomp1.wav
        resources/sounds/chomp2.wav
        resources/sounds/evilLaugh.wav
        resources/sounds/groan0.wav
        resources/sounds/groan1.wav
        resources/sounds/groan2.wav
        resources/sounds/groan3.wav
        resources/sounds/groan4.wav
        resources/sounds/groan5.wav
        resources/sounds/gulp.wav
        resources/sounds/pause.wav
        resources/sounds/plant.wav
        resources/sounds/points.wav
        resources/sounds/readySetPlant.wav
        resources/sounds/seedLift.wav
        resources/sounds/shovel.wav
        resources/sounds/splat0.wav
        resources/sounds/splat1.wav
        resources/sounds/splat2.wav

        resources/zombies/basicZombieAttack.gif
        resources/zombies/basicZombieStand0.gif
        resources/zombies/basicZombieStand1.gif
        resources/zombies/basicZombieWalk0.gif
        resources/zombies/basicZombieWalk1.gif

        NO_RESOURCE_TARGET_PATH
)
