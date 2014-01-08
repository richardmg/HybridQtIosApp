import QtQuick 2.1

Image {
    id: img
    source: "qt.png"
    x: Math.random() * (parent.width - width)
    y: Math.random() * (parent.height - height)

    property real speedX: 0
    property real speedY: 0
    property real friction: 0.20 + (Math.random() * 0.1)
    property real bounce: 0.3 + (Math.random() * 0.3)
    property real gravity: 0.2

    function tick()
    {
        // adjust icon speed:
        speedX -= sensor.reading.x * gravity;
        speedY += sensor.reading.y * gravity

        // Calculate where the icon should be:
        x += (speedX > 0) ? Math.max(0, speedX - friction) : Math.min(0, speedX + friction);
        y += (speedY > 0) ? Math.max(0, speedY - friction) : Math.min(0, speedY + friction)

        // Bounce icon back in if outside screen:
        if (x < 0) {
            x = 0
            speedX = speedX * -1 * bounce
        } else  if (x > mainWindow.width - paintedWidth) {
            x = mainWindow.width - paintedWidth
            speedX = speedX * -1 * bounce
        }
        if (y < 0) {
            y = 0
            speedY = speedY * -1 * bounce
        }
        if (y > mainWindow.height - paintedHeight) {
            y = mainWindow.height - paintedHeight
            speedY = speedY * -1 * bounce
        }
    }

    opacity: 0.01
    Component.onCompleted: opacity = 1
    Behavior on opacity { NumberAnimation {} }
    onOpacityChanged: if (opacity === 0) img.destroy()
}
