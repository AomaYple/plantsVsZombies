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
    moveAnimator.readied.connect(function () {
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
    moveAnimator.readied.connect(function () {
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
    moveAnimator.readied.connect(function () {
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
    moveAnimator.readied.connect(function () {
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

function plant(property, subPlantAreaId) {
    const incubator = seedBank.plantComponent.incubateObject(image, {
        height: Qt.binding(function () {
            return property.height;
        }),
        x: Qt.binding(function () {
            return property.x;
        }),
        y: Qt.binding(function () {
            return property.y;
        }),
        shoveling: Qt.binding(function () {
            return shovelBank.shoveling && subPlantAreaId.containsMouse;
        })
    });
    incubator.onStatusChanged = function (status) {
        if (status === Component.Ready) {
            seedBank.plant();
            const plant = incubator.object;
            const index = subPlantAreaId.index;
            switch (plant.type) {
                case Plants.PlantType.Type.Sunflower:
                    initSunflower(plant);
                    break;
                case Plants.PlantType.Type.PeaShooter:
                case Plants.PlantType.Type.SnowPeaShooter:
                case Plants.PlantType.Type.Repeater:
                    initPeaShooter(plant, zombieProducer.zombieContainer[index[0]]);
                    break;
                case Plants.PlantType.Type.WallNut:
                    initWallNut(plant);
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
    sunflower.paused = Qt.binding(function () {
        return image.paused;
    });
    sunflower.sunlightProduced.connect(function () {
        generateSunlight(Qt.point(sunflower.x, sunflower.y), sunflower.y + sunflower.height * 0.5, false);
    });
}

function initPeaShooter(peaShooter, zombies) {
    peaShooter.paused = Qt.binding(function () {
        return image.paused;
    });
    for (const zombie of zombies) {
        if (zombie.x >= peaShooter.x + peaShooter.width * 0.5)
            ++peaShooter.zombieCount;
    }
    peaShooter.peaShot.connect(function (position) {
        const incubator0 = peaShooter.peaComponent.incubateObject(image, {
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
        if (peaShooter.type === Plants.PlantType.Type.Repeater) {
            const incubator1 = peaShooter.peaComponent.incubateObject(image, {
                x: Qt.binding(function () {
                    return position.x + image.height * 0.1;
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
            incubator1.onStatusChanged = function (status) {
                if (status === Component.Ready) {
                    initPea(incubator1.object, zombies);
                }
            }
        }
        incubator0.onStatusChanged = function (status) {
            if (status === Component.Ready)
                initPea(incubator0.object, zombies);
        }
    });
}

function initWallNut(wallNut) {
    wallNut.paused = Qt.binding(function () {
        return image.paused || wallNut.zombieCount > 0;
    });
}

function initPea(pea, zombies) {
    pea.xChanged.connect(function () {
        const x = pea.x + pea.width;
        for (const zombie of zombies) {
            const left = zombie.x + zombie.width * 0.3, right = zombie.x + zombie.width;
            if (x >= left && x <= right) {
                zombie.lifeValue -= pea.attackValue;
                if (pea.type === Plants.PeaType.Type.SnowPea)
                    zombie.decelerate();
                pea.destroy();
                zombie.twinkle();
                zombie.playSplat();
            }
        }
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
                for (const plant of plantArray) {
                    if (plant && zombie.x > plant.x && zombie.x < plant.x + plant.width * 0.5) {
                        switch (plant.type) {
                            case Plants.PlantType.Type.WallNut:
                                ++plant.zombieCount;
                                break;
                            case Plants.PlantType.Type.PotatoMine:
                                plant.die();
                                potatoMineBomb(Qt.rect(plant.x, plant.y, plant.width, plant.height));
                                image.judder();
                                zombie.die();
                                break;
                        }
                        zombie.startAttack();
                        zombie.attacked.connect(function () {
                            plant.lifeValue -= zombie.attackValue;
                            plant.twinkle();
                        });
                        plant.lifeValueChanged.connect(function () {
                            if (plant.lifeValue <= 0)
                                zombie.stopAttack();
                        });
                    }
                }
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
                                if (zombie.x > plant.x && zombie.x < plant.x + plant.width * 0.5)
                                    break;
                            default:
                                return;
                        }
                        --plant.zombieCount;
                    }
                }
                zombieSet.delete(zombie)
            });
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
            zombieSet.add(zombie);
        }
    };
}

function potatoMineBomb(plantProperty) {
    const component = Qt.createComponent('../plants/MashedPotato.qml');
    const objectHeight = image.height * 0.16, objectWidth = objectHeight / 92 * 131;
    component.incubateObject(image, {
        height: Qt.binding(function () {
            return objectHeight;
        }),
        width: Qt.binding(function () {
            return objectWidth;
        }),
        x: Qt.binding(function () {
            return plantProperty.x - (objectWidth - plantProperty.width) / 2;
        }),
        y: Qt.binding(function () {
            return plantProperty.y - (objectHeight - plantProperty.height) / 2;
        }),
    });
}
