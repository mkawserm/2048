import Qb 1.0
import Qb.Ssh 1.0
import Qb.Core 1.0
import Qb.Android 1.0

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0

QbApp{
    id: __main__app
    Keys.forwardTo: [__game_screen]

    GameScreen {
        id: __game_screen
        anchors.centerIn: parent
        anchors.fill: parent
    }

}
