//
//  Qt.h
//  NativeWithQt
//
//  Created by Richard Moe Gustavsen on 07/01/14.
//  Copyright (c) 2014 Richard Moe Gustavsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QmlView : UIView {
    void *m_engine;
    void *m_window;
}

- (id) initWithUrl:(NSString *) url;
- (void *) qwindow;

@end

