//
//  DataModel.h
//  HybridQtApp
//
//  Created by Richard Moe Gustavsen on 08/01/14.
//  Copyright (c) 2014 Richard Moe Gustavsen. All rights reserved.
//

#ifndef __HybridQtApp__DataModel__
#define __HybridQtApp__DataModel__

#include <QtQuick/QtQuick>

class DataModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant ballCount READ ballCount WRITE setBallCount NOTIFY ballCountChanged)
    
public:
    static DataModel* instance() { return m_instance; }
    
    QVariant ballCount() { return m_ballCount; }
    void setBallCount(QVariant ballCount) {
        if (ballCount.toFloat() == m_ballCount)
            return;
        m_ballCount = ballCount;
        
        // Need to emit the signal async for now, since otherwise Object::deleteLater
        // calls will silently fail when Qt events are posted outside Qt's events dispatcher:
        QMetaObject::invokeMethod(this, "ballCountChanged", Qt::QueuedConnection);
    }
    
signals:
    void ballCountChanged();
    
private:
    explicit DataModel(QQuickItem *parent = 0) : QObject(parent), m_ballCount(5){}
    static DataModel *m_instance;
    QVariant m_ballCount;
};

#endif /* defined(__HybridQtApp__DataModel__) */
