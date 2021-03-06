//
//  ViewController.h
//  SocketIM
//
//  Created by loi on 3/30/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSStreamDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
@property (retain, nonatomic) IBOutlet UITextField *inputNameField;
@property (retain, nonatomic) IBOutlet UIView *joinView;
@property (retain, nonatomic) IBOutlet UITextField *inputMessageField;
@property (retain, nonatomic) IBOutlet UITableView *tView;
@property (retain, nonatomic) IBOutlet UIView *chatView;
@property (retain, nonatomic) NSMutableArray *messages;

- (IBAction)sendMessage:(UIButton *)sender;
- (IBAction)joinChat:(UIButton *)sender;

@end

