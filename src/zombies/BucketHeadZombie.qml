import QtMultimedia
import "../js/common.js" as Common

Zombie {
    function playShieldHit() {
        soundEffect.play();
    }

    attackValue: 1
    lifeValue: 30
    source: '../../resources/zombies/bucketHeadZombie' + (!attacking ? 'Walk' + Common.getRandomInt(0, 1) : 'Attack') + '.gif'
    type: ZombieType.Type.BucketHeadZombie
    width: height / 142 * 96

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/shieldHit' + Common.getRandomInt(0, 1) + '.wav'
    }
}
