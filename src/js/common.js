function getRandomInt(n, m) {
    return Math.floor(Math.random() * (m - n + 1)) + n;
}

function getRandomFloat(min, max) {
    return Math.random() * (max - min) + min;
}

function produceStandingZombies() {
    for (let i = 0; i < 9; ++i) {
        let standingZombieComponent = null, zombieHeight = null, zombieWidth = null;
        if (i < 4) {
            standingZombieComponent = image.standingBasicZombieComponent;
            zombieHeight = image.height * 0.23;
            zombieWidth = zombieHeight / 126 * 84;
        } else if (i >= 4 && i < 7) {
            standingZombieComponent = image.standingConeHeadZombie;
            zombieHeight = image.height * 0.25;
            zombieWidth = zombieHeight / 148 * 82;
        } else {
            standingZombieComponent = image.standingBucketHeadZombie;
            zombieHeight = image.height * 0.24;
            zombieWidth = zombieHeight / 140 * 84;
        }
        const incubator = standingZombieComponent.incubateObject(image, {
            width: zombieWidth,
            height: zombieHeight,
            x: getRandomFloat(image.width - image.rightMargin, image.width - zombieWidth),
            y: getRandomFloat(0, image.height - zombieHeight)
        });

        function destroyStandingZombie() {
            incubator.object.destroy();
            moveAnimator.readied.disconnect(destroyStandingZombie);
        }

        moveAnimator.readied.connect(destroyStandingZombie);
    }
}

function produceSunlight(beginPosition, endPositionY, natural) {
    const incubator = sunlightProducer.sunlightComponent.incubateObject(image, {
        natural: natural,
        height: image.height * 0.14,
        paused: Qt.binding(function () {
            return image.paused;
        }),
        x: beginPosition.x,
        y: beginPosition.y,
        endPositionY: endPositionY,
        collectedPosition: Qt.point(image.leftMargin + image.width * 0.008, -image.height * 0.01)
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const sunlight = incubator.object;
            sunlight.clicked.connect(function () {
                points.play();
            });
            sunlight.collected.connect(function () {
                seedBank.increaseSunlight();
            });
        }
    };
}

function plant(property, subPlantArea) {
    const incubator = seedBank.plantingSeed.plantComponent.incubateObject(image, {
        height: property.height,
        x: property.x,
        y: property.y,
        shoveling: Qt.binding(function () {
            return shovelBank.shoveling && subPlantArea.containsMouse;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            seedBank.plant();
            const plant = incubator.object;
            const index = subPlantArea.index;
            const zombieSet = zombieProducer.zombieContainer[index[0]];
            let setPaused = Qt.binding(function () {
                return image.paused;
            });
            switch (plant.type) {
                case Plants.PlantType.Type.Sunflower:
                    plant.sunlightProduced.connect(function () {
                        produceSunlight(Qt.point(plant.x, plant.y), plant.y + plant.height * 0.5, false);
                    });
                    break;
                case Plants.PlantType.Type.PeaShooter:
                case Plants.PlantType.Type.SnowPeaShooter:
                case Plants.PlantType.Type.Repeater:
                    initPeaShooter(plant, zombieSet);
                    break;
                case Plants.PlantType.Type.WallNut:
                    setPaused = Qt.binding(function () {
                        return image.paused || plant.zombieCount > 0;
                    });
                    break;
                case Plants.PlantType.Type.PotatoMine:
                    initPotatoMine(plant, zombieSet);
                    break;
            }
            plant.paused = setPaused;
            const plantArray = plantArea.plantContainer[index[0]];
            plantArray[index[1]] = plant;

            function clearFromContainer() {
                plantArray[index[1]] = null;
            }

            plant.died.connect(clearFromContainer);
            plant.shovelled.connect(clearFromContainer);
        }
    };
}

function initPeaShooter(peaShooter, zombieSet) {
    for (const zombie of zombieSet) {
        if (zombie.x > peaShooter.x + peaShooter.width * 0.5)
            ++peaShooter.zombieCount;
    }
    peaShooter.peaShot.connect(function (position) {
        const count = peaShooter.type === Plants.PlantType.Type.Repeater ? 2 : 1;
        for (let i = 0; i < count; ++i) {
            const peaX = position.x + (i === 1 ? peaShooter.width * 0.1 : 0),
                peaEndPositionX = image.width - image.rightMargin;
            if (peaX >= peaEndPositionX)
                return;
            const peaComponent = peaShooter.type === Plants.PlantType.Type.SnowPeaShooter ? image.snowPeaComponent : image.peaComponent;
            const incubator = peaComponent.incubateObject(image, {
                x: peaX,
                y: position.y,
                height: image.height * 0.1,
                paused: Qt.binding(function () {
                    return image.paused;
                }),
                endPositionX: peaEndPositionX,
            });
            incubator.onStatusChanged = function (status) {
                if (status === Component.Ready) {
                    const pea = incubator.object;
                    pea.xChanged.connect(function () {
                        if (pea.attack) {
                            const edge = pea.x + pea.width;
                            for (const zombie of zombieSet) {
                                const left = zombie.x + zombie.width * 0.3, right = zombie.x + zombie.width;
                                if (edge >= left && edge <= right) {
                                    pea.attack = false;
                                    zombie.lifeValue -= pea.attackValue;
                                    if (pea.type === Plants.PeaType.Type.SnowPea)
                                        zombie.decelerate();
                                    pea.destroy();
                                    zombie.twinkle();
                                    if (zombie.type !== Zombies.ZombieType.Type.BucketHeadZombie)
                                        item.playSplat();
                                    else
                                        item.playShieldHit();
                                }
                            }
                        }
                    });
                }
            };
        }
    });
}

function initPotatoMine(potatoMine, zombieSet) {
    potatoMine.exploded.connect(function () {
        for (const zombie of zombieSet)
            if (zombie.x >= potatoMine.x && zombie.x <= potatoMine.x + potatoMine.width)
                zombie.die();
        const objectHeight = image.height * 0.16, objectWidth = objectHeight / 92 * 131;
        const incubator = image.mashedPotatoComponent.incubateObject(image, {
            height: objectHeight,
            width: objectWidth,
            x: potatoMine.x - (objectWidth - potatoMine.width) / 2,
            y: potatoMine.y - (objectHeight - potatoMine.height) / 2,
        });
        judderAnimator.start();
        potatoMineBomb.play();

        function destroyMashedPotatoComponent() {
            potatoMineBomb.playingChanged.disconnect(destroyMashedPotatoComponent);
            incubator.object.destroy();
        }

        potatoMineBomb.playingChanged.connect(destroyMashedPotatoComponent);
    });
}

function produceZombie(zombieComponent) {
    let zombieHeight = null;
    if (zombieComponent === zombieProducer.basicZombieComponent)
        zombieHeight = image.height * 0.24;
    else if (zombieComponent === zombieProducer.coneHeadZombieComponent)
        zombieHeight = image.height * 0.26;
    else
        zombieHeight = image.height * 0.25;
    const rowIndex = getRandomInt(0, 4);
    const incubator = zombieComponent.incubateObject(image, {
        x: image.width - image.rightMargin,
        y: plantArea.y + (rowIndex + 1) * plantArea.subPlantAreaSize.height - zombieHeight,
        height: zombieHeight,
        paused: Qt.binding(function () {
            return image.paused;
        }),
        endPositionX: image.leftMargin
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const zombie = incubator.object;
            const plantArray = plantArea.plantContainer[rowIndex];
            const zombieSet = zombieProducer.zombieContainer[rowIndex];
            zombieSet.add(zombie);
            for (const plant of plantArray) {
                if (plant) {
                    switch (plant.type) {
                        case Plants.PlantType.Type.PeaShooter:
                        case Plants.PlantType.Type.SnowPeaShooter:
                        case Plants.PlantType.Type.Repeater:
                            ++plant.zombieCount;
                    }
                }
            }
            zombie.xChanged.connect(function () {
                for (const plant of plantArray) {
                    if (plant && zombie.x >= plant.x && zombie.x <= plant.x + plant.width * 0.5) {
                        switch (plant.type) {
                            case Plants.PlantType.Type.WallNut:
                                ++plant.zombieCount;
                                break;
                            case Plants.PlantType.Type.PotatoMine:
                                if (plant.ready) {
                                    plant.explode();
                                    return;
                                } else
                                    break;
                        }
                        zombie.startAttack();
                        item.playChomp();

                        function attackPlant() {
                            plant.twinkle();
                            plant.lifeValue -= zombie.attackValue;
                        }

                        function stopAttack() {
                            zombie.attacked.disconnect(attackPlant);
                            zombie.stopAttack();
                            item.stopChomp();
                        }

                        zombie.attacked.connect(attackPlant);
                        plant.died.connect(function () {
                            stopAttack();
                            gulp.play();
                        });
                        plant.shovelled.connect(stopAttack);
                    }
                }
            });
            zombie.froze.connect(function () {
                frozen.play();
            });
            zombie.died.connect(function () {
                for (const plant of plantArray) {
                    if (plant) {
                        switch (plant.type) {
                            case Plants.PlantType.Type.PeaShooter:
                            case Plants.PlantType.Type.SnowPeaShooter:
                            case Plants.PlantType.Type.Repeater:
                                if (zombie.x >= plant.x + plant.width * 0.5)
                                    break;
                            case Plants.PlantType.Type.WallNut:
                                if (zombie.x >= plant.x && zombie.x <= plant.x + plant.width * 0.5)
                                    break;
                            default:
                                return;
                        }
                        --plant.zombieCount;
                    }
                }
                zombieSet.delete(zombie);
            });
        }
    };
}
