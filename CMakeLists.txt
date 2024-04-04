cmake_minimum_required(VERSION 3.29.1)

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

        src/plants/MashedPotato.qml
        src/plants/Pea.qml
        src/plants/PeaShooter.qml
        src/plants/PeaType.qml
        src/plants/Plant.qml
        src/plants/PlantType.qml
        src/plants/PotatoMine.qml
        src/plants/Repeater.qml
        src/plants/SnowPea.qml
        src/plants/SnowPeaShooter.qml
        src/plants/Sunflower.qml
        src/plants/WallNut.qml

        src/scenes/Cart.qml
        src/scenes/GameScene.qml
        src/scenes/HugeWave.qml
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
        src/scenes/SoundEffects.qml
        src/scenes/StartAdventure.qml
        src/scenes/Sunlight.qml
        src/scenes/SunlightProducer.qml
        src/scenes/SuspendableTimer.qml
        src/scenes/ZombieHand.qml
        src/scenes/ZombieProducer.qml
        src/scenes/ZombieWon.qml

        src/zombies/BasicZombie.qml
        src/zombies/BucketHeadZombie.qml
        src/zombies/ConeHeadZombie.qml
        src/zombies/DiedZombie.qml
        src/zombies/FlagZombie.qml
        src/zombies/StandingBasicZombie.qml
        src/zombies/StandingBucketHeadZombie.qml
        src/zombies/StandingConeHeadZombie.qml
        src/zombies/StandingZombie.qml
        src/zombies/Zombie.qml
        src/zombies/ZombieType.qml

        src/main.qml

        RESOURCES
        resources/music/chooseYourSeeds.flac
        resources/music/crazyDave.flac
        resources/music/grassWalk.flac

        resources/plants/initializingPotatoMine.png
        resources/plants/mashedPotato.png
        resources/plants/pea.png
        resources/plants/peaShooter.gif
        resources/plants/peaShooter.png
        resources/plants/peaShooterSeed.png
        resources/plants/potatoMine.gif
        resources/plants/potatoMine.png
        resources/plants/potatoMineSeed.png
        resources/plants/repeater.gif
        resources/plants/repeater.png
        resources/plants/repeaterSeed.png
        resources/plants/risingPotatoMine.gif
        resources/plants/shootingPeaShooter.gif
        resources/plants/shootingRepeater.gif
        resources/plants/shootingSnowPeaShooter.gif
        resources/plants/snowPea.png
        resources/plants/snowPeaShooter.gif
        resources/plants/snowPeaShooter.png
        resources/plants/snowPeaShooterSeed.png
        resources/plants/sunflower.gif
        resources/plants/sunflower.png
        resources/plants/sunflowerSeed.png
        resources/plants/wallNut.gif
        resources/plants/wallNut.png
        resources/plants/wallNutSeed.png

        resources/scenes/button.png
        resources/scenes/cart.gif
        resources/scenes/daytimeGrass.png
        resources/scenes/favicon.ico
        resources/scenes/highlightQuit.png
        resources/scenes/highlightStartAdventure.png
        resources/scenes/hugeWave.png
        resources/scenes/loadBar.png
        resources/scenes/mainMenu.png
        resources/scenes/optionsMenuBackground.png
        resources/scenes/optionsMenuButton.png
        resources/scenes/popCapLogo.png
        resources/scenes/quit.png
        resources/scenes/risingZombieHand.gif
        resources/scenes/seedBank.png
        resources/scenes/shadow.png
        resources/scenes/shovel.png
        resources/scenes/shovelBank.png
        resources/scenes/startAdventure.png
        resources/scenes/startPlant.png
        resources/scenes/startReady.png
        resources/scenes/startSet.png
        resources/scenes/sunlight.gif
        resources/scenes/titleScreen.png
        resources/scenes/zombieWon.png

        resources/sounds/awooga.wav
        resources/sounds/bleep.wav
        resources/sounds/buzzer.wav
        resources/sounds/chomp0.wav
        resources/sounds/chomp1.wav
        resources/sounds/chomp2.wav
        resources/sounds/evilLaugh.wav
        resources/sounds/frozen.wav
        resources/sounds/groan0.wav
        resources/sounds/groan1.wav
        resources/sounds/groan2.wav
        resources/sounds/groan3.wav
        resources/sounds/groan4.wav
        resources/sounds/groan5.wav
        resources/sounds/gulp.wav
        resources/sounds/hugeWave.wav
        resources/sounds/lawnMower.wav
        resources/sounds/loseSound.wav
        resources/sounds/pause.wav
        resources/sounds/plant0.wav
        resources/sounds/plant1.wav
        resources/sounds/points.wav
        resources/sounds/potatoMine.wav
        resources/sounds/readySetPlant.wav
        resources/sounds/scream.wav
        resources/sounds/seedLift.wav
        resources/sounds/shieldHit0.wav
        resources/sounds/shieldHit1.wav
        resources/sounds/shovel.wav
        resources/sounds/siren.wav
        resources/sounds/splat0.wav
        resources/sounds/splat1.wav
        resources/sounds/splat2.wav

        resources/zombies/attackingBasicZombie.gif
        resources/zombies/attackingBucketHeadZombie.gif
        resources/zombies/attackingConeHeadZombie.gif
        resources/zombies/attackingFlagZombie.gif
        resources/zombies/diedZombie0.gif
        resources/zombies/diedZombie1.gif
        resources/zombies/diedZombie2.gif
        resources/zombies/standingBasicZombie0.gif
        resources/zombies/standingBasicZombie1.gif
        resources/zombies/standingBucketHeadZombie0.gif
        resources/zombies/standingBucketHeadZombie1.gif
        resources/zombies/standingConeHeadZombie0.gif
        resources/zombies/standingConeHeadZombie1.gif
        resources/zombies/walkingBasicZombie0.gif
        resources/zombies/walkingBasicZombie1.gif
        resources/zombies/walkingBucketHeadZombie0.gif
        resources/zombies/walkingBucketHeadZombie1.gif
        resources/zombies/walkingConeHeadZombie0.gif
        resources/zombies/walkingConeHeadZombie1.gif
        resources/zombies/walkingFlagZombie0.gif
        resources/zombies/walkingFlagZombie1.gif

        NO_RESOURCE_TARGET_PATH
)
