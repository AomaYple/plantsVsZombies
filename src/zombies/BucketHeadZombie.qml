Zombie {
    attackValue: 1
    lifeValue: 30
    source: '../../res/zombies/' + (!attacking ? 'walkingBucketHeadZombie' + Math.round(Math.random()) : 'attackingBucketHeadZombie') + '.gif'
    type: ZombieType.Type.BucketHeadZombie
    width: height / 142 * 96
}
