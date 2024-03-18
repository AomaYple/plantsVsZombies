import "../js/common.js" as Common

Zombie {
    attackValue: 1
    lifeValue: 20
    source: '../../resources/zombies/coneHeadZombie' + (!attacking ? 'Walk' + Common.getRandomInt(0, 1) : 'Attack') + '.gif'
    type: ZombieType.Type.ConeHeadZombie
    width: height / 148 * 94
}
