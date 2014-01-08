The following steps was taken to enable Qt:

- change build architecture to only armv7 (not armv7s) under settings tab
- add qtbase/include folder (full path) to header search paths under settings tab
- change c++ language dialiect to GNU++98 under build settings tab
- change c++ standard library to libstdc++ under build settings tab

- add build phases script:
    - from menubar, choose editor/add build phase/add run script build phase
    - in the script field, add "$PROJECT_NAME/qml/build_phases_script"

- add standard libs to project:
    libZ.dylib
    CoreMotion.framework
    CoreLocation.framework

- add libs from qtbase/lib:
    libQt5Core.a
    libQt5Gui.a
    libQt5Network.a
    libQt5PlatformSupport.a
    libQt5Qml.a
    libQt5Quick.a
    libQt5Sensors.a

- add libs from qtbase/qml:
    libqtquick2plugin.a
    libwindowplugin.a
    libdeclarative_sensors.a

- add libs from qtbase/plugins
    libqios.a
    libqtsensors_ios.a

- Since we only added armv7 libs, you only build for device and not simulator! Add in the the same libs (with _simulator suffix) for supporting simulator as well.

- In the code (QmlView.mm), all plugins added above need to have a corresponding Q_IMPORT_PLUGIN line so they
    get registered in Qt.

