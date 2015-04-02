//
//  ViewController.h
//  SocketIM
//
//  Created by loi on 3/30/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSStreamDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

@property (retain, nonatomic) IBOutlet UITextField *inputNameField;
@property (retain, nonatomic) IBOutlet UIView *joinView;
@property (retain, nonatomic) IBOutlet UITextField *inputMessageField;
@property (retain, nonatomic) IBOutlet UITableView *tView;
@property (retain, nonatomic) IBOutlet UIView *chatView;
- (IBAction)sendMessage:(UIButton *)sender;
- (IBAction)joinChat:(UIButton *)sender;

@end

