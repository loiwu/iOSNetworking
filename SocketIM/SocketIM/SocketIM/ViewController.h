//
//  ViewController.h
//  SocketIM
//
//  Created by loi on 3/30/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *inputNameField;
@property (retain, nonatomic) IBOutlet UIView *joinView;
- (IBAction)joinChat:(UIButton *)sender;

@end

