﻿import QtQuick 2.12

Item {
    id: r
    implicitWidth: (soundWidth + columnSpacing) * columnCount
    implicitHeight: (soundHeight + rowSpacing) * rowCount
    Component {
        id: soundComp
        Image {
            source: "qrc:/EffectImage/Img/soundRect.png"
            width: soundWidth
            height: soundHeight
        }
    }
    property bool running: true
    property int interval: 320
    property int soundWidth: 12
    property int soundHeight: 6

    property int rowCount: 15
    property int columnCount: 30

    property int rowSpacing: 4
    property int columnSpacing: 4

    property var objPool: []
    property var map:[]
    property int __arrayRatio: 100
    Component.onCompleted: {
        let startX = 0
        let startY = r.height - 12
        for (let i = 0; i < columnCount; ++i) {
            map.push(getRandomInt(0, rowCount))

            let px = startX + i * (soundWidth + columnSpacing)
            for (let j = 0; j < rowCount; ++j) {
                let py =  startY - j * (soundHeight + rowSpacing)

                var obj = soundComp.createObject(r, {"x": px, "y": py, "visible": false})
                objPool[i * __arrayRatio + j] = obj
            }
        }
    }
    Timer {
        interval: r.interval
        running: r.running
        repeat: true
        onTriggered: {
            map.push(getRandomInt(0, rowCount))
            map.shift()
            for (let i = 0; i < columnCount; ++i) {
                for (let j = 0; j < rowCount; ++j) {
                    objPool[i * __arrayRatio + j]["visible"] = j < map[i] ? true : false
                }
            }
        }
    }
    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min; //不含最大值，含最小值
    }
}
