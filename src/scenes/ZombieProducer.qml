import QtQml
import QtMultimedia
import "../js/common.js" as Common

SuspendableTimer {
    readonly property Component basicZombieComponent: Qt.createComponent('../zombies/BasicZombie.qml', Component.Asynchronous)
    readonly property Component bucketHeadZombieComponent: Qt.createComponent('../zombies/BucketHeadZombie.qml', Component.Asynchronous)
    readonly property Component coneHeadZombieComponent: Qt.createComponent('../zombies/ConeHeadZombie.qml', Component.Asynchronous)
    property int index: 1
    property Component zombieComponent: null

    signal hugeWaved

    function playGroan() {
        const groanIndex = Common.getRandomInt(0, 5);
        switch (groanIndex) {
        case 0:
            groan0.play();
            break;
        case 1:
            groan1.play();
            break;
        case 2:
            groan2.play();
            break;
        case 3:
            groan3.play();
            break;
        case 4:
            groan4.play();
            break;
        case 5:
            groan5.play();
            break;
        }
    }

    interval: 5000
    repeat: true

    onTriggered: {
        if (index % 2 === 0)
            zombieComponent = coneHeadZombieComponent;
        else if (index % 5 === 0)
            zombieComponent = bucketHeadZombieComponent;
        else
            zombieComponent = basicZombieComponent;
        if (index === 1)
            awooga.play();
        if (index === 20) {
            interval = 1000;
            restart();
            hugeWaved();
        }
        ++index;
        playGroan();
    }

    SoundEffect {
        id: awooga

        source: '../../resources/sounds/awooga.wav'
    }

    SoundEffect {
        id: groan0

        source: '../../resources/sounds/groan0.wav'
    }

    SoundEffect {
        id: groan1

        source: '../../resources/sounds/groan1.wav'
    }

    SoundEffect {
        id: groan2

        source: '../../resources/sounds/groan2.wav'
    }

    SoundEffect {
        id: groan3

        source: '../../resources/sounds/groan3.wav'
    }

    SoundEffect {
        id: groan4

        source: '../../resources/sounds/groan4.wav'
    }

    SoundEffect {
        id: groan5

        source: '../../resources/sounds/groan5.wav'
    }
}
