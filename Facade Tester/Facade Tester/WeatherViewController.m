//
//  FirstViewController.m
//  Facade Tester
//
//  Created by loi on 3/19/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@property (strong, nonatomic) UISegmentedControl *versionSelector;

@property (strong, nonatomic) NSString *v1_city;
@property (strong, nonatomic) NSString *v1_state;
@property (assign, nonatomic) NSInteger *v1_temperature;

@property (strong, nonatomic) NSString *v2_city;
@property (strong, nonatomic) NSString *v2_state;
@property (assign, nonatomic) NSInteger *v2_temperature;
@property (strong, nonatomic) NSString *v2_conditions;

- (void)versionChanged:(id)sender;
- (void)loadVersion1Weather;
- (void)loadVersion2Weather;

@end

@implementation WeatherViewController
@synthesize versionSelector;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"Weather", "Weather");
        self.tabBarItem.image = [UIImage imageNamed:@"weather"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // configure the version selector
    versionSelector = [[UISegmentedControl alloc] initWithItems:
                       [NSArray arrayWithObjects:
                        NSLocalizedString(@"Version 1", @"Version 1"),
                        NSLocalizedString(@"Version 2", @"Version 2"),
                        nil]];
    versionSelector.selectedSegmentIndex = 0;
    
//    [versionSelector addTarget:self
//                        action:@selector(versionChanged:)
//              forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = versionSelector;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
