//
//  FirstViewController.m
//  HybridQtApp
//
//  Created by Richard Moe Gustavsen on 08/01/14.
//  Copyright (c) 2014 Richard Moe Gustavsen. All rights reserved.
//

#import "FirstViewController.h"
#import "QmlView.h"
#include "DataModel.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *qmlView = [[QmlView alloc] initWithUrl:@"qml/main.qml"];
    CGRect rect = self.view.frame;
    rect.size.height -= 100;
    qmlView.frame = rect;
    [self.view addSubview:qmlView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    DataModel::instance()->setBallCount(int(slider.value));
}
@end
