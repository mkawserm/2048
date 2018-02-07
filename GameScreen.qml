import QtQuick 2.10
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0

import "logic.js" as Logic

Rectangle {
    id: window;
    visible: true
    //width: 380
    //height: 480
    color: "#fbf8ef";
    Keys.forwardTo: [keyFocus]

    Settings {
        id: settings;
        property alias columns: board.col;
        property alias rows: board.row;
        property alias bestScore: scoreBoard.bestScore;
        property alias boardSize: optionsWnd.boardSize
        //        onColumnsChanged: {
        //            __main__app.setValue("columns",board.col)
        //        }
        //        onRowsChanged: {
        //            __main__app.setValue("rows",board.row)
        //        }
        //        onBestScoreChanged: {
        //            __main__app.setValue("bestScore",scoreBoard.bestScore)
        //        }
        //        onBoardSizeChanged: {
        //            __main__app.setValue("boardSize",optionsWnd.boardSize)
        //        }
        //        Component.onCompleted: {
        //            settings.columns = __main__app.getValue("columns",4);
        //            settings.rows = __main__app.getValue("rows",4);
        //            settings.bestScore = __main__app.getValue("bestScore",0);
        //            settings.boardSize = __main__app.getValue("boardSize",1);
        //            board.col = settings.columns;
        //            board.row = settings.rows;
        //            Logic.columns = settings.columns;
        //            Logic.rows = settings.rows;
        //        }

    }

    property alias board: board;
    property alias scoreBoard: scoreBoard;
    property alias gameOverWnd: gameOverWnd

    ScoreBoard {
        id: scoreBoard;

        onOptionsClicked: {
            if (optionsWnd.opacity === 0.0)
                optionsWnd.animShow.start();
            else
                optionsWnd.animHide.start();
        }

        Component.onCompleted: {
            optionsWnd.opacity = 0.0;
        }
    }
    Rectangle {
        anchors {
            right: parent.right; rightMargin: 5
            left: parent.left; leftMargin: 5
            bottom: parent.bottom; bottomMargin: 5
            top: parent.top; topMargin: 100
        }
        color: "#bbada0"
        Board {
            id: board
            MouseArea {
                anchors.fill: parent
                property int minimumLength: window.width < window.height ? window.width / 5 : window.height / 5
                property int startX
                property int startY
                onPressed: {
                    startX = mouse.x
                    startY = mouse.y
                }
                onReleased: {
                    var length = Math.sqrt(Math.pow(mouse.x - startX, 2) + Math.pow(mouse.y - startY, 2))
                    if (length < minimumLength)
                        return
                    var diffX = mouse.x - startX
                    var diffY = mouse.y - startY
                    // not sure what the exact angle is but it feels good
                    if (Math.abs(Math.abs(diffX) - Math.abs(diffY)) < minimumLength / 2)
                        return
                    if (Math.abs(diffX) > Math.abs(diffY))
                        if (diffX > 0){
                            if(Logic.move(Qt.Key_Right)) {
                                movingTimer.start();
                            }
                        }
                        else{
                            if(Logic.move(Qt.Key_Left)) {
                                movingTimer.start();
                            }
                        }
                    else
                        if (diffY > 0){
                            if(Logic.move(Qt.Key_Down)) {
                                movingTimer.start();
                            }
                        }
                        else{
                            if(Logic.move(Qt.Key_Up)) {
                                movingTimer.start();
                            }
                        }
                }
            }
        }
    }

    Timer {
        id: movingTimer
        interval: 100; running: false;
        onTriggered: {
            Logic.onAnimEnd();
        }
    }

    Rectangle{
        id: keyFocus
        focus: true
        Keys.onPressed: {
            //console.log("GOT ME");
            if(Logic.move(event.key)) {
                movingTimer.start();
            }
            event.accepted = true;
        }
    }

    GameOverWnd {
        id: gameOverWnd;
    }

    OptionsWnd {
        id: optionsWnd;

        onApply: {
            var value = boardSize + 4;
            board.col = Logic.columns = value
            board.row = Logic.rows = value

            var cw = board.width/board.col;
            Logic.cellWidth = cw;
            var hw = board.height/board.row;
            Logic.cellHeight = hw;

            Logic.restart();
            Logic.resizeHandler();
            keyFocus.forceActiveFocus();

        }
    }

    Component.onCompleted: {
        Logic.init(board.col,board.row,window);
    }

    Component.onDestruction: {
        scoreBoard.bestScore = Math.max(scoreBoard.bestScore, scoreBoard.score);
    }
}
