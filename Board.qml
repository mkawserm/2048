import QtQuick 2.10
import "logic.js" as Logic

Rectangle {
    id: board
    property int col: 4
    property int row: 4
    radius: 3;
    property alias grid:grid
    width: Math.min(parent.width,parent.height);
    height: width;
    anchors.centerIn: parent
    color: "#bbada0"

    Grid {
        id: grid
        anchors.fill: parent;
        columns: col;
        rows: row;
        property int marginValue: 5;
        onWidthChanged:{
            var cw = board.width/board.col;
            if(cw==Logic.cellWidth) return;
            Logic.cellWidth = cw;
            //console.log("W:"+width)
            Logic.resizeHandler();
            //Logic.restart();
        }
        onHeightChanged:{
            var hw = board.height/board.row;
            if(hw==Logic.cellHeight) return;
            Logic.cellHeight = hw;
            Logic.resizeHandler();
            //Logic.restart();
        }
        Repeater {
            model: grid.columns * grid.rows;

            Rectangle {
                width: grid.width / grid.columns;
                height: grid.height / grid.rows;
                color: "transparent";
                Rectangle {
                    color: "#ccc0b2"
                    radius: 3
                    anchors {
                        right: parent.right; rightMargin: grid.marginValue
                        left: parent.left; leftMargin: grid.marginValue
                        bottom: parent.bottom; bottomMargin: grid.marginValue
                        top: parent.top; topMargin: grid.marginValue
                    }
                }
                Component.onCompleted: {
                }
            }
        }
    }
}
