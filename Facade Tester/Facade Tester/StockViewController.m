//
//  SecondViewController.m
//  Facade Tester
//
//  Created by loi on 3/19/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import "StockViewController.h"

@interface StockViewController ()

@property (strong, nonatomic) UISegmentedControl *versionSelector;

@property (strong, nonatomic) NSString *v1_symbol;
@property (strong, nonatomic) NSString *v1_name;
@property (strong, nonatomic) NSNumber *v1_surrentPrice;

@property (strong, nonatomic) NSString *v2_symbol;
@property (strong, nonatomic) NSString *v2_name;
@property (strong, nonatomic) NSNumber *v2_surrentPrice;
@property (strong, nonatomic) NSNumber *v2_openingPrice;
@property (strong, nonatomic) NSString *v2_percentageChange;

- (void)versionChanged:(id)sender;
- (void)loadVersion1Stock;
- (void)loadVersion2Stock;

@end

@implementation StockViewController
@synthesize versionSelector;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"Stock Quote", "Stock Quote");
        self.tabBarItem.image = [UIImage imageNamed:@"stock"];
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
