const carts = [null, null, null, null, null];
const sunlightComponent = Qt.createComponent('../scenes/Sunlight.qml', Component.Asynchronous)
const peaComponent = Qt.createComponent('../plants/Pea.qml', Component.Asynchronous)
const snowPeaComponent = Qt.createComponent('../plants/SnowPea.qml', Component.Asynchronous)
const mashedPotatoComponent = Qt.createComponent('../plants/MashedPotato.qml', Component.Asynchronous)
const zombieSets = [new Set(), new Set(), new Set(), new Set(), new Set(), new Set()]
const diedZombieComponent = Qt.createComponent('../zombies/DiedZombie.qml', Component.Asynchronous)

function getRandomInt(n, m) {
    return Math.floor(Math.random() * (m - n + 1)) + n;
}

function getRandomFloat(min, max) {
    return Math.random() * (max - min) + min;
}

function produceStandingZombies() {
    for (let i = 0; i !== 9; ++i) {
        let standingZombieComponent = null, zombieHeight = null, zombieWidth = null;
        if (i < 4) {
            standingZombieComponent = Qt.createComponent('../zombies/StandingBasicZombie.qml');
            zombieHeight = image.height * 0.23;
            zombieWidth = zombieHeight / 126 * 84;
        } else if (i >= 4 && i < 7) {
            standingZombieComponent = Qt.createComponent('../zombies/StandingConeHeadZombie.qml');
            zombieHeight = image.height * 0.25;
            zombieWidth = zombieHeight / 148 * 82;
        } else {
            standingZombieComponent = Qt.createComponent('../zombies/StandingBucketHeadZombie.qml');
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

function initCart() {
    const cartComponent = Qt.createComponent('../scenes/Cart.qml');
    const cartHeight = image.height * 0.1, cartWidth = cartHeight / 70 * 85;
    for (let i = 0; i !== 5; ++i) {
        const incubator = cartComponent.incubateObject(image, {
            width: cartWidth,
            height: cartHeight,
            x: image.leftMargin - cartWidth,
            y: image.areaY + image.chunkSize.height * (i + 1) - cartHeight
        });
        incubator.onStatusChanged = function (status) {
            if (status === Component.Ready) {
                const cart = incubator.object;
                if (i === 0)
                    cart.emerged.connect(function () {
                        readySetPlant.start();
                        item.chose();
                    });
                else {
                    cart.emerged.connect(function () {
                        carts[i - 1].emerge(image.leftMargin - carts[i - 1].width * 0.4);
                    });
                    if (i === 4) seedBank.emerged.connect(function () {
                        cart.emerge(image.leftMargin - cart.width * 0.4)
                    });
                }
                cart.xChanged.connect(function () {
                    for (const zombie of zombieSets[i])
                        if (cart.x + cart.width >= zombie.x + zombie.width * 0.4 && cart.x <= zombie.x + zombie.width)
                            zombie.die();
                });
                carts[i] = cart;
            }
        };
    }
}

function produceSunlight(beginPosition, endPositionY, natural) {
    const incubator = sunlightComponent.incubateObject(image, {
        height: image.height * 0.14,
        x: beginPosition.x,
        y: beginPosition.y,
        endPositionY: endPositionY,
        collectedPosition: Qt.point(image.leftMargin + image.width * 0.008, -image.height * 0.01),
        paused: Qt.binding(function () {
            return item.paused;
        }),
        natural: natural
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const sunlight = incubator.object;
            sunlight.clicked.connect(function () {
                soundEffects.playPoints();
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
            const zombieSet = zombieSets[rowIndex];
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

            const plantArray = plantArea.plantArrays[rowIndex];

            function clearFromArrays() {
                plantArray[columnIndex] = null;
            }

            plant.died.connect(clearFromArrays);
            plant.shovelled.connect(clearFromArrays);
            plantArray[columnIndex] = plant;
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
        for (let i = 0; i !== count; ++i) {
            const peaHeight = image.height * 0.1, peaX = position.x + (i === 1 ? peaHeight : 0),
                peaEndPositionX = image.width - image.rightMargin;
            if (peaX >= peaEndPositionX)
                return;
            const component = peaShooter.type === Plants.PlantType.Type.SnowPeaShooter ? snowPeaComponent : peaComponent;
            const incubator = component.incubateObject(image, {
                x: peaX,
                y: position.y,
                height: peaHeight,
                endPositionX: peaEndPositionX,
                paused: Qt.binding(function () {
                    return item.paused;
                })
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
                        soundEffects.playSplat();
                    else
                        soundEffects.playShieldHit();
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
        mashedPotatoComponent.incubateObject(image, {
            width: objectWidth,
            height: objectHeight,
            x: potatoMine.x - (objectWidth - potatoMine.width) / 2,
            y: potatoMine.y - (objectHeight - potatoMine.height) / 2,
            paused: Qt.binding(function () {
                return item.paused;
            })
        });
        judderAnimator.start();
        soundEffects.playPotatoMine();
    });
}

function produceZombie(zombieComponent) {
    let zombieHeight = null;
    if (zombieComponent === zombieProducer.basicZombieComponent)
        zombieHeight = image.height * 0.24;
    else if (zombieComponent === zombieProducer.coneHeadZombieComponent)
        zombieHeight = image.height * 0.26;
    else if (zombieComponent === zombieProducer.bucketHeadZombieComponent)
        zombieHeight = image.height * 0.25;
    else
        zombieHeight = image.height * 0.27;
    const rowIndex = getRandomInt(0, 4);
    const incubator = zombieComponent.incubateObject(image, {
        height: zombieHeight,
        x: image.width - image.rightMargin,
        y: plantArea.y + (rowIndex + 1) * plantArea.subPlantAreaSize.height - zombieHeight,
        paused: Qt.binding(function () {
            return item.paused;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            const zombie = incubator.object;
            const plantArray = plantArea.plantArrays[rowIndex];
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
                zombieXChanged(zombie, plantArray, rowIndex);
            });
            zombie.froze.connect(function () {
                soundEffects.playFrozen();
            });
            const zombieSet = zombieSets[rowIndex];
            zombie.died.connect(function () {
                zombieDied(zombie, plantArray, zombieSet);
            });
            zombieSet.add(zombie);
        }
    };
}

function zombieXChanged(zombie, plantArray, rowIndex) {
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
                soundEffects.playChomp();
            }

            function stopAttack() {
                plant.died.disconnect(eatUp);
                plant.shovelled.disconnect(stopAttack);
                zombie.attacked.disconnect(attackPlant);
                zombie.died.disconnect(stopAttack);
                zombie.stopAttack();
                soundEffects.stopChomp();
            }

            function eatUp() {
                stopAttack();
                soundEffects.playGulp();
            }

            plant.died.connect(eatUp);
            plant.shovelled.connect(stopAttack);
            zombie.attacked.connect(attackPlant);
            zombie.died.connect(stopAttack);
        }
    }
    if (zombie.x + zombie.width * 0.4 <= carts[rowIndex].x + carts[rowIndex].width) {
        carts[rowIndex].march(image.width - image.rightMargin);
        carts[rowIndex].paused = Qt.binding(function () {
            return item.paused;
        });
    }
    if (zombie.x + zombie.width < image.leftMargin)
        image.lose();
}

function zombieDied(zombie, plantArray, zombieSet) {
    zombieSet.delete(zombie);
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
    const diedZombieHeight = zombie.height, diedZombieWidth = diedZombieHeight / 136 * 180;
    const incubator = diedZombieComponent.incubateObject(image, {
        width: diedZombieWidth,
        height: diedZombieHeight,
        x: zombie.x + (zombie.width - diedZombieWidth) / 2,
        y: zombie.y + (zombie.height - diedZombieHeight) / 2,
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
