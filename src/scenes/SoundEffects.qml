import QtQml
import QtMultimedia
import "../js/common.js" as Common

QtObject {
    readonly property SoundEffect chomp0: SoundEffect {
        source: '../../resources/sounds/chomp0.wav'
    }
    readonly property SoundEffect chomp1: SoundEffect {
        source: '../../resources/sounds/chomp1.wav'
    }
    readonly property SoundEffect chomp2: SoundEffect {
        source: '../../resources/sounds/chomp2.wav'
    }
    readonly property SoundEffect frozen: SoundEffect {
        source: '../../resources/sounds/frozen.wav'
    }
    readonly property SoundEffect gulp: SoundEffect {
        source: '../../resources/sounds/gulp.wav'
    }
    readonly property SoundEffect points: SoundEffect {
        source: '../../resources/sounds/points.wav'
    }
    readonly property SoundEffect potatoMine: SoundEffect {
        source: '../../resources/sounds/potatoMine.wav'
    }
    readonly property SoundEffect shieldHit0: SoundEffect {
        source: '../../resources/sounds/shieldHit0.wav'
    }
    readonly property SoundEffect shieldHit1: SoundEffect {
        source: '../../resources/sounds/shieldHit1.wav'
    }
    readonly property SoundEffect splat0: SoundEffect {
        source: '../../resources/sounds/splat0.wav'
    }
    readonly property SoundEffect splat1: SoundEffect {
        source: '../../resources/sounds/splat1.wav'
    }
    readonly property SoundEffect splat2: SoundEffect {
        source: '../../resources/sounds/splat2.wav'
    }

    function playChomp() {
        const index = Common.getRandomInt(0, 2);
        switch (index) {
        case 0:
            if (!chomp0.playing)
                chomp0.play();
            break;
        case 1:
            if (!chomp1.playing)
                chomp1.play();
            break;
        case 2:
            if (!chomp2.playing)
                chomp2.play();
            break;
        }
    }

    function playFrozen() {
        frozen.play();
    }

    function playGulp() {
        gulp.play();
    }

    function playPoints() {
        points.play();
    }

    function playPotatoMine() {
        potatoMine.play();
    }

    function playShieldHit() {
        const index = Math.round(Math.random());
        switch (index) {
        case 0:
            if (!shieldHit0.playing)
                shieldHit0.play();
            break;
        case 1:
            if (!shieldHit1.playing)
                shieldHit1.play();
            break;
        }
    }

    function playSplat() {
        const index = Common.getRandomInt(0, 2);
        switch (index) {
        case 0:
            if (!splat0.playing)
                splat0.play();
            break;
        case 1:
            if (!splat1.playing)
                splat1.play();
            break;
        case 2:
            if (!splat2.playing)
                splat2.play();
            break;
        }
    }

    function stopChomp() {
        chomp0.stop();
        chomp1.stop();
        chomp2.stop();
    }
}
