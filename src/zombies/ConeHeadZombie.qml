Zombie {
    attackValue: 1
    lifeValue: 20
    source: '../../res/zombies/' + (!attacking ? 'walkingConeHeadZombie' + Math.round(Math.random()) : 'attackingConeHeadZombie') + '.gif'
    type: ZombieType.Type.ConeHeadZombie
    width: height / 148 * 94
}
