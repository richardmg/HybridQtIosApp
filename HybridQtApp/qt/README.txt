Steps you need to do before building
-------------------------------------------
- Go to build settings tab and change QTDIR in the user-defined section at the bottom
    to point to your local installation of Qt.
- You may need to update #include <QtGui/5.2.0/QtGui/qpa/qplatformnativeinterface.h> in QmlView.mm
    to the correct version (instead of 5.2.0)

Steps that has already been taken to enable Qt:
-------------------------------------------

- NOte: The following is a work-around for now, until hybrid case is officially supported!

- add $QTDIR/include folder to header search paths under settings tab
- change build architecture to only armv7 (not armv7s) under settings tab
- change c++ language dialiect to GNU++98 under build settings tab
- change c++ standard library to libstdc++ under build settings tab

- add build phases script:
    - from menubar, choose editor/add build phase/add run script build phase
    - in the script field, add "$PROJECT_NAME/qml/build_phases_script"
    - add a new script before compile step, and moc each file that needs it, e.g
        "moc $PROJECT_NAME/qt/DataModel.h -o $PROJECT_NAME/qt/moc_DataModel.cpp"

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

- Obj-c files that uses Qt must be renamed from .m to .mm
- Since we only added armv7 libs, you only build for device and not simulator! Add in the the same libs (with _simulator suffix) for supporting simulator as well.

- In the code (QmlView.mm), all plugins added above need to have a corresponding Q_IMPORT_PLUGIN line so they
    get registered in Qt.

