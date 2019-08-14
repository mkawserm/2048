import Qb 1.0
import Qb.Core 1.0
import Qb.Android 1.0

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

QbApp{
    id: __main__app
    Keys.forwardTo: [__game_screen]


    Pane{
        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0
        anchors.fill: parent
        Material.theme: Material.Light
        Material.primary: Material.Lime
        Material.accent: Material.Teal
        Material.background: Material.Grey
        Material.foreground: Material.Brown
        ToolButton{
            anchors.right: parent.right
            text: QbMF3.icon("mf-close")
            font.family: QbMF3.family
            font.pixelSize: QbCoreOne.scale(25)
            z: 100
            visible: Qt.platform.os === "android" || Qt.platform.os === "ios"
            onClicked: {
                __main__app.close();
            }
        }

	    GameScreen {
	        id: __game_screen
	        anchors.centerIn: parent
	        anchors.fill: parent
	    }

    }
    QbSettings {
        id: settings
        name: "GameSettings"
        property alias columns: __game_screen.col
        property alias rows: __game_screen.row
        property alias bestScore: __game_screen.bestScore
        property alias boardSize: __game_screen.boardSize
    }
}
