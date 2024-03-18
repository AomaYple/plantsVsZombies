import QtQml
import QtMultimedia

SuspendableTimer {
    readonly property var basicZombieComponent: Qt.createComponent('../zombies/BasicZombie.qml', Component.Asynchronous)
    readonly property var bucketHeadZombieComponent: Qt.createComponent('../zombies/BucketHeadZombie.qml', Component.Asynchronous)
    readonly property var coneHeadZombieComponent: Qt.createComponent('../zombies/ConeHeadZombie.qml', Component.Asynchronous)
    property int index: 1
    property var zombieComponent: null
    readonly property var zombieContainer: [new Set(), new Set(), new Set(), new Set(), new Set(), new Set(),]

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
            soundEffect.play();
        ++index;
    }

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/siren.wav'
    }
}
