//
//  ViewController.m
//  SocketIM
//
//  Created by loi on 3/30/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) launchThreadByNSObject_performSelectorInBackground_withObject
{
    [self performSelectorInBackground:@selector(doWork) withObject:nil];
}

- (void)doWork
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [self performSelectorOnMainThread:@selector(doneWork) withObject:nil waitUntilDone:NO];
    [pool drain];
}

- (void)doneWork
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_joinView release];
    [_inputNameField release];
    [super dealloc];
}
- (IBAction)joinChat:(UIButton *)sender {
}
@end
