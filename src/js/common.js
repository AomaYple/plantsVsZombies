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
            return item.paused;
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
            const rowIndex = subPlantArea.index[0], columnIndex = subPlantArea.index[1];
            const zombieSet = zombieProducer.zombieContainer[rowIndex];
            let pausedSetting = Qt.binding(function () {
                return item.paused;
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
                    pausedSetting = Qt.binding(function () {
                        return item.paused || plant.zombieCount > 0;
                    });
                    break;
                case Plants.PlantType.Type.PotatoMine:
                    initPotatoMine(plant, zombieSet);
                    break;
            }
            plant.paused = pausedSetting;
            const plantArray = plantArea.plantContainer[rowIndex];
            plantArray[columnIndex] = plant;

            function clearFromContainer() {
                plantArray[columnIndex] = null;
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
            const peaHeight = image.height * 0.1, peaX = position.x + (i === 1 ? peaHeight : 0),
                peaEndPositionX = image.width - image.rightMargin;
            if (peaX >= peaEndPositionX)
                return;
            const peaComponent = peaShooter.type === Plants.PlantType.Type.SnowPeaShooter ? image.snowPeaComponent : image.peaComponent;
            const incubator = peaComponent.incubateObject(image, {
                x: peaX,
                y: position.y,
                height: peaHeight,
                paused: Qt.binding(function () {
                    return item.paused;
                }),
                endPositionX: peaEndPositionX,
            });
            incubator.onStatusChanged = function (status) {
                if (status === Component.Ready)
                    initPea(incubator.object, zombieSet);
            };
        }
    });
}

function initPea(pea, zombieSet) {
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
                        image.playSplat();
                    else
                        image.playShieldHit();
                }
            }
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
            return item.paused;
        })
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
                zombieXChanged(zombie, plantArray);
            });
            zombie.froze.connect(function () {
                frozen.play();
            });
            zombie.died.connect(function () {
                zombieDied(zombie, plantArray, zombieSet);
            });
        }
    };
}

function zombieXChanged(zombie, plantArray) {
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
                    }
                    break;
            }
            zombie.startAttack();

            function attackPlant() {
                plant.lifeValue -= zombie.attackValue;
                plant.twinkle();
                image.playChomp();
            }

            function stopAttack() {
                plant.died.disconnect(eatUp);
                plant.shovelled.disconnect(stopAttack);
                zombie.attacked.disconnect(attackPlant);
                zombie.died.disconnect(stopAttack);
                zombie.stopAttack();
                image.stopChomp();
            }

            function eatUp() {
                stopAttack();
                gulp.play();
            }

            plant.died.connect(eatUp);
            plant.shovelled.connect(stopAttack);
            zombie.attacked.connect(attackPlant);
            zombie.died.connect(stopAttack);
        }
    }
    const edge = zombie.x - zombie.width * 0.5;
    if (edge <= cart0.x + cart0.width) {
        cart0.paused = Qt.binding(function () {
            return item.paused;
        });
        cart0.march(image.width - image.rightMargin);
    }
    if (edge <= cart1.x + cart1.width) {
        cart1.march(image.width - image.rightMargin);
        cart1.paused = Qt.binding(function () {
            return item.paused;
        });
    }
    if (edge <= cart2.x + cart2.width) {
        cart2.march(image.width - image.rightMargin);
        cart2.paused = Qt.binding(function () {
            return item.paused;
        });
    }
    if (edge <= cart3.x + cart3.width) {
        cart3.march(image.width - image.rightMargin);
        cart3.paused = Qt.binding(function () {
            return item.paused;
        });
    }
    if (edge <= cart4.x + cart4.width) {
        cart4.march(image.width - image.rightMargin);
        cart4.paused = Qt.binding(function () {
            return item.paused;
        });
    }
    if (zombie.x + zombie.width < image.leftMargin) {
        zombie.paused = false;
        image.lose();
    }
}

function zombieDied(zombie, plantArray, zombieSet) {
    for (const plant of plantArray) {
        if (plant) {
            switch (plant.type) {
                case Plants.PlantType.Type.PeaShooter:
                case Plants.PlantType.Type.SnowPeaShooter:
                case Plants.PlantType.Type.Repeater:
                    if (zombie.x > plant.x + plant.width * 0.5)
                        --plant.zombieCount;
                    break;
                case Plants.PlantType.Type.WallNut:
                    if (zombie.x >= plant.x && zombie.x <= plant.x + plant.width * 0.5)
                        --plant.zombieCount;
                    break;
            }
        }
    }
    zombieSet.delete(zombie);
    const diedZombieHeight = zombie.height, diedZombieWidth = diedZombieHeight / 136 * 180;
    const incubator = image.diedZombieComponent.incubateObject(image, {
        x: zombie.x + (zombie.width - diedZombieWidth) / 2,
        y: zombie.y + (zombie.height - diedZombieHeight) / 2,
        width: diedZombieWidth,
        height: diedZombieHeight,
        paused: Qt.binding(function () {
            return item.paused;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const diedZombie = incubator.object;
            diedZombie.currentFrameChanged.connect(function () {
                if (diedZombie.currentFrame === diedZombie.frameCount - 1)
                    diedZombie.destroy();
            });
        }
    };
}
