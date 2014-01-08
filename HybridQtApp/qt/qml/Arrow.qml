import QtQuick 2.1
import QtSensors 5.2

Image {
    source: "qt.png"
    
    
    
    Gyroscope {
        id: gyroscope
        active: Qt.application.state === Qt.ApplicationActive
    }
}
