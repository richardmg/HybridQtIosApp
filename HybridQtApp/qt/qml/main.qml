import QtQuick 2.1
import QtQuick.Window 2.0
import QtSensors 5.2

Window {
    id: mainWindow
    color: "white"
    property alias sensor: sensor
    
    Accelerometer {
        id: sensor
        active: Qt.application.state === Qt.ApplicationActive
    }

    Ball {}
    Ball {}
    Ball {}
    Ball {}

}
