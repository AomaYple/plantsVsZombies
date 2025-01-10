Zombie {
    attackValue: 1
    lifeValue: 10
    source: '../../res/zombies/' + (!attacking ? 'walkingBasicZombie' + Math.round(Math.random()) : 'attackingBasicZombie') + '.gif'
    type: ZombieType.Type.BasicZombie
    width: height / 130 * 94
}
