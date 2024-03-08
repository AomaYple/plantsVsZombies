function getRandomFloat(min, max) {
    return Math.random() * (max - min) + min;
}

function naturalGenerateSunlight() {
    const incubator = sunlightProducer.sunlightComponent.incubateObject(root, {
        height: Qt.binding(function () {
            return root.height * 0.14;
        }),
        paused: Qt.binding(function () {
            return root.paused;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const sunlight = incubator.object;
            const beginPosition = Qt.point(getRandomFloat(root.width * 0.1, root.width * 0.9), root.height * 0.2);
            const endPositionY = getRandomFloat(root.height * 0.4, root.height * 0.9);
            const collectedPosition = Qt.point(root.width * 0.008, -root.height * 0.01);
            sunlight.naturalGenerate(beginPosition, endPositionY, collectedPosition);
            sunlight.collected.connect(function () {
                seedBank.increaseSunlight();
            });
        }
    };
}
