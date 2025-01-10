BasicZombie {
    source: '../../res/zombies/' + (!attacking ? 'walkingFlagZombie' + Math.round(Math.random()) : 'attackingFlagZombie') + '.gif'
    type: ZombieType.Type.FlagZombie
    width: height / 150 * 116
}
