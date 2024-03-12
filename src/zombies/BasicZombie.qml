import "../js/common.js" as Common

Zombie {
    damageValue: 1
    lifeValue: 10
    source: rootPath + '/resources/zombies/basicZombieWalk' + Common.getRandomInt(0, 1) + '.gif'
    type: ZombieType.Type.BasicZombie
    width: height / 130 * 94
}
