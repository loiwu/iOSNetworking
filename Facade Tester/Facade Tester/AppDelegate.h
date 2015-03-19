//
//  AppDelegate.h
//  Facade Tester
//
//  Created by loi on 3/19/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) NSURL *urlForWeatherVersion1;
@property (strong, nonatomic) NSURL *urlForWeatherVersion2;
@property (strong, nonatomic) NSURL *urlForStockVersion1;
@property (strong, nonatomic) NSURL *urlForStockVersion2;

@end

