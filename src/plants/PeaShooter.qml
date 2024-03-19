import QtQml

Plant {
    property int zombieCount: 0

    signal peaShot(point position)

    lifeValue: 5
    shadowHeight: height * 0.52
    shadowPosition: Qt.point(width * 0.07, height * 0.55)
    source: '../../resources/plants/' + (zombieCount > 0 ? 'shootingP' : 'p') + 'eaShooter.gif'
    type: PlantType.Type.PeaShooter

    onCurrentFrameChanged: (currentFrame, frameCount) => {
        if (zombieCount > 0 && currentFrame === 13)
            peaShot(Qt.point(x + width, y + height * 0.12));
    }
}
