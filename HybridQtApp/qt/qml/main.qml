import QtQuick 2.1
import QtQuick.Window 2.0
import QtSensors 5.2

Window {
    id: mainWindow
    color: "white"
    property alias sensor: sensor
    property var balls: new Array()
    
    Component.onCompleted: updateBalls();

    property real tick: 0
    NumberAnimation on tick { to: 1; duration: Number.MAX_VALUE; paused: !sensor.active }
    onTickChanged: {
        for (var i=0; i<balls.length; ++i)
            balls[i].tick();
    }

    Accelerometer {
        id: sensor
        active: Qt.application.state === Qt.ApplicationActive
    }

    Connections {
        target: DataModel
        onBallCountChanged: updateBalls()
    }
    
    function updateBalls()
    {
        var diff = DataModel.ballCount - balls.length;
        if (diff > 0) {
            var ballComponent = Qt.createComponent("Ball.qml")
            for (var i=0; i<diff; ++i)
                balls.push(ballComponent.createObject(mainWindow));
        } else if (diff < 0){
            for (var i=diff; i<0; ++i)
                balls.pop().opacity = 0;
        }
    }

}
