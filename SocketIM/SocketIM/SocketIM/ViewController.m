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
@synthesize joinView, chatView;
@synthesize inputStream, outputStream;
@synthesize inputNameField, inputMessageField;
@synthesize tView, messages;

- (void)initNetworkCommunication
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 80, &readStream, &writeStream);//192.168.1.104
    inputStream = (NSInputStream *)readStream;
    outputStream = (NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNetworkCommunication];
    
    messages = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [joinView release];
    [inputNameField release];
    [inputMessageField release];
    [tView release];
    [chatView release];
    [inputStream release];
    [outputStream release];
    [messages release];
    [super dealloc];
}
- (IBAction)sendMessage:(UIButton *)sender {
    
    NSString *response = [NSString stringWithFormat:@"msg:%@",inputMessageField.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    inputMessageField.text = @"";
}

- (IBAction)joinChat:(UIButton *)sender {
    
    [self.view sendSubviewToBack:joinView];
    NSString *response = [NSString stringWithFormat:@"iam:%@",inputNameField.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    NSString *s = (NSString *)[messages objectAtIndex:indexPath.row];
    cell.textLabel.text = s;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
//    NSLog(@"stream event %lu", eventCode);
    switch (eventCode) {
            
        case NSStreamEventNone:
            break;
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
            
            if (aStream == inputStream) {
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = (int)[inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len>0) {
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        if (nil!=output) {
                            NSLog(@"server said: %@", output);
                            [self messageReceived:output];
                        }
                    }
                }
            }
            
            break;
            
        case NSStreamEventHasSpaceAvailable:
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Fail to connect to the host");
            break;
            
        case NSStreamEventEndEncountered:
            NSLog(@"Event end");
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            break;
            
        default:
            break;
    }
}

- (void)messageReceived:(NSString *)message {
    [messages addObject:message];
    [self.tView reloadData];
    
    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:messages.count-1 inSection:0];
    [self.tView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

@end
