import QtQuick

Item {
    id: root

    signal finished
    anchors.fill: parent

    Image {
        id: background

        property list<QtObject> previewZombies

        function createPreviewZombies() {
            const component = Qt.createComponent('../zombies/BasicZombieStand.qml');
            previewZombies.push(component.createObject(background, {
                width: background.width * 0.07,
                x: background.width * 0.82,
                y: background.height * 0.2
            }));
            previewZombies.push(component.createObject(background, {
                width: background.width * 0.07,
                x: background.width * 0.86,
                y: background.height * 0.4
            }));
            previewZombies.push(component.createObject(background, {
                width: background.width * 0.07,
                x: background.width * 0.9,
                y: background.height * 0.6
            }));
            previewZombies.push(component.createObject(background, {
                width: background.width * 0.07,
                x: background.width * 0.85,
                y: background.height * 0.7
            }));
        }
        function destroyPreviewZombies() {
            for (let i = 0; i < previewZombies.length; ++i)
                previewZombies[i].destroy();
            previewZombies = [];
        }

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready) {
            pauseView.start();
            createPreviewZombies();
        }

        Timer {
            id: pauseView

            interval: 1500

            onTriggered: leftRightMove.start()
        }
        XAnimator {
            id: leftRightMove

            duration: 2000
            target: background
            to: root.width - background.width

            onFinished: {
                if (to === root.width - background.width) {
                    to = -background.width * 0.157;
                    pauseView.start();
                } else {
                    background.destroyPreviewZombies();
                    root.finished();
                }
            }
        }
    }
}
