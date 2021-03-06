//
//  Qt.m
//  NativeWithQt
//
//  Created by Richard Moe Gustavsen on 07/01/14.
//  Copyright (c) 2014 Richard Moe Gustavsen. All rights reserved.
//

#import "QmlView.h"

#include <QtCore/QtCore>
#include <QtGui/QtGui>
#include <QtQuick/QtQuick>
#include <QtGui/5.2.1/QtGui/qpa/qplatformnativeinterface.h>

#include "DataModel.h"

// Manually register all static plugins. if you use other
// qml modules you would need to do the same for them:
Q_IMPORT_PLUGIN(QtQuick2Plugin)
Q_IMPORT_PLUGIN(QtQuick2WindowPlugin)

Q_IMPORT_PLUGIN(QIOSIntegrationPlugin)
Q_IMPORT_PLUGIN(QtSensorsDeclarativeModule)
Q_IMPORT_PLUGIN(IOSSensorPlugin)

static QQmlEngine *engine = 0;

@implementation QmlView

- (id) initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        if (!qApp) {
            int count = 0;
            char **argv = 0;
            new QGuiApplication(count, argv);
            
            engine = new QQmlEngine();
            engine->rootContext()->setContextProperty(QLatin1String("DataModel"), DataModel::instance());
            
            // no need to call qApp::exec()!
        }
        
        QQmlComponent component(engine);
        component.loadUrl(QUrl(QString::fromNSString(url)));
        
        if (!component.isReady() ) {
            m_window = 0;
            qWarning("%s", qPrintable(component.errorString()));
        } else {
            QQuickWindow *window = qobject_cast<QQuickWindow *>(component.create());
            m_window = window;
            // We create a dummy parent for now until QWindow::fromWinId() is supported:
            QWindow *dummyParent = new QWindow();
            window->setParent(dummyParent);
            window->setVisible(true);
            UIView *subView = (__bridge UIView *) QGuiApplication::platformNativeInterface()->nativeResourceForWindow("uiview", window);
            [self addSubview: subView];
        }
    }
    return self;
}

- (void) dealloc
{
    if (m_window)
        delete static_cast<QWindow *>(m_window)->parent();
}

-(void) setHidden:(BOOL)hidden
{
    if (m_window)
        static_cast<QWindow *>(m_window)->setVisible(!hidden);
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (m_window)
        static_cast<QWindow *>(m_window)->setGeometry(0, 0, frame.size.width, frame.size.height);
}

- (void *)qwindow
{
    return m_window;
}

@end
