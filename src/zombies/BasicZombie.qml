import "../js/common.js" as Common

Zombie {
    attackValue: 1
    lifeValue: 10
    source: '../../resources/zombies/basicZombie' + (!attackTarget ? 'Walk' + Common.getRandomInt(0, 1) : 'Attack') + '.gif'
    type: ZombieType.Type.BasicZombie
    width: height / 130 * 94
}
