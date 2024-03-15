function getRandomInt(n, m) {
    return Math.floor(Math.random() * (m - n + 1)) + n;
}

function getRandomFloat(min, max) {
    return Math.random() * (max - min) + min;
}

function createBasicZombieStand() {
    const component = Qt.createComponent('../zombies/BasicZombieStand.qml');
    const zombieHeight = Qt.binding(function () {
        return image.height * 0.23;
    });
    const incubator0 = component.incubateObject(image, {
        height: zombieHeight,
        x: Qt.binding(function () {
            return image.width * 0.8;
        }),
        y: Qt.binding(function () {
            return image.height * 0.15
        })
    });
    xAnimator.readied.connect(function () {
        incubator0.object.destroy();
    });
    const incubator1 = component.incubateObject(image, {
        height: zombieHeight,
        x: Qt.binding(function () {
            return image.width * 0.83;
        }),
        y: Qt.binding(function () {
            return image.height * 0.4
        })
    });
    xAnimator.readied.connect(function () {
        incubator1.object.destroy();
    });
    const incubator2 = component.incubateObject(image, {
        height: zombieHeight,
        x: Qt.binding(function () {
            return image.width * 0.9;
        }),
        y: Qt.binding(function () {
            return image.height * 0.6
        })
    });
    xAnimator.readied.connect(function () {
        incubator2.object.destroy();
    });
    const incubator3 = component.incubateObject(image, {
        height: zombieHeight,
        x: Qt.binding(function () {
            return image.width * 0.85;
        }),
        y: Qt.binding(function () {
            return image.height * 0.7
        })
    });
    xAnimator.readied.connect(function () {
        incubator3.object.destroy();
    });
}

function generateSunlight(beginPosition, endPositionY, natural) {
    const incubator = sunlightProducer.sunlightComponent.incubateObject(image, {
        natural: Qt.binding(function () {
            return natural;
        }),
        height: Qt.binding(function () {
            return image.height * 0.14;
        }),
        paused: Qt.binding(function () {
            return image.paused;
        }),
        x: Qt.binding(function () {
            return beginPosition.x;
        }),
        y: Qt.binding(function () {
            return beginPosition.y;
        }),
        endPositionY: Qt.binding(function () {
            return endPositionY;
        }),
        collectedPosition: Qt.binding(function () {
            return Qt.point(image.leftMargin + image.width * 0.008, -image.height * 0.01);
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready)
            incubator.object.collected.connect(
                function () {
                    seedBank.increaseSunlight();
                }
            );
    };
}

function naturalGenerateSunlight() {
    const sunlightHeight = image.height * 0.14;
    generateSunlight(Qt.point(getRandomFloat(image.leftMargin, image.width - image.rightMargin - sunlightHeight),
        seedBank.height), getRandomFloat(seedBank.height + image.height * 0.1, image.height - sunlightHeight), true);
}

function plant(properties, subPlantAreaId) {
    const incubator = seedBank.plantComponent.incubateObject(image, {
        height: Qt.binding(function () {
            return properties.height;
        }),
        x: Qt.binding(function () {
            return properties.x;
        }),
        y: Qt.binding(function () {
            return properties.y;
        }),
        paused: Qt.binding(function () {
            return image.paused;
        }),
        shoveling: Qt.binding(function () {
            return shovelBank.shoveling && subPlantAreaId.containsMouse;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const plant = incubator.object;
            const index = subPlantAreaId.index;
            switch (plant.type) {
                case Plants.PlantType.Type.Sunflower:
                    initSunflower(plant);
                    break;
                case Plants.PlantType.Type.PeaShooter:
                    initPeaShooter(plant);
                    break;
            }
            plant.died.connect(function () {
                plantArea.plantContainer[index[0]][index[1]] = null;
            });
            plantArea.plantContainer[index[0]][index[1]] = plant;
        }
    };
}

function initSunflower(sunflower) {
    sunflower.sunlightProduced.connect(function () {
        generateSunlight(Qt.point(sunflower.x, sunflower.y), sunflower.y + sunflower.height * 0.5, false);
    });
}

function initPeaShooter(peaShooter) {
    peaShooter.peaShot.connect(function (position) {
        const incubator = peaShooter.peaComponent.incubateObject(image, {
            x: Qt.binding(function () {
                return position.x;
            }),
            y: Qt.binding(function () {
                return position.y;
            }),
            height: Qt.binding(function () {
                return image.height * 0.1;
            }),
            paused: Qt.binding(function () {
                return image.paused;
            }),
            endPositionX: Qt.binding(function () {
                return image.width - image.rightMargin;
            })
        });
    });
}

function createZombie() {
    const zombieHeight = image.height * 0.24;
    const rowIndex = getRandomInt(0, 4);
    const zombieY = plantArea.y + (rowIndex + 1) * plantArea.subPlantAreaSize.height - zombieHeight;
    const incubator = zombieProducer.zombieComponent.incubateObject(image, {
        x: Qt.binding(function () {
            return image.width - image.rightMargin;
        }),
        y: Qt.binding(function () {
            return zombieY;
        }),
        height: Qt.binding(function () {
            return zombieHeight;
        }),
        paused: Qt.binding(function () {
            return image.paused;
        }),
        endPositionX: Qt.binding(function () {
            return image.leftMargin;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const zombie = incubator.object;
            const plantArray = plantArea.plantContainer[rowIndex];
            const zombieSet = zombieProducer.zombieContainer[rowIndex];
            zombie.xChanged.connect(function () {
                for (let i = 8; i >= 0; --i) {
                    const plant = plantArray[i];
                    if (plant && zombie.x > plant.x && zombie.x < plant.x + plant.width * 0.5)
                        zombie.startAttack(plant);
                }
            });
            zombie.died.connect(function () {
                for (let i = 8; i >= 0; --i) {
                    const plant = plantArray[i];
                    if (plant && plant.type === Plants.PlantType.Type.PeaShooter && zombie.x >= plant.x + plant.width * 0.5)
                        --plant.zombieCount;
                }
                zombieSet.delete(zombie)
            });
            for (let i = 8; i >= 0; --i) {
                const plant = plantArray[i];
                if (plant && plant.type === Plants.PlantType.Type.PeaShooter)
                    ++plant.zombieCount;
            }
            zombieSet.add(zombie);
        }
    };
}
