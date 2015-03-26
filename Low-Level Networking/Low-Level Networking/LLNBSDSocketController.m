//
//  LLNBSDSocketController.m
//  Low-Level Networking
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "LLNBSDSocketController.h"
#import <arpa/inet.h>
#import <netdb.h>

@implementation LLNBSDSocketController {
	int socketFileDescriptor;
}

- (void)loadCurrentStatus:(NSURL*)url {
	if ([self.delegate respondsToSelector:@selector(networkingResultsDidStart)]) {
		[self.delegate networkingResultsDidStart];
	}
	
	// create a new Internet stream socket
    // 第一步：使用socket()创建一个新的网络流套接字。
	socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0);
	
    // 创建网络流socket失败
	if (socketFileDescriptor == -1) {
		if ([self.delegate respondsToSelector:@selector(networkingResultsDidFail:)]) {
			[self.delegate networkingResultsDidFail:@"Unable to allocate networking resources."];
		}
		
		return;
	}
	
	
	// convert the hostname to an IP address
    // 第二步：取得服务器主机名，使用gethostbyname()通过主机名称得到IP地址（DNS）
	struct hostent *remoteHostEnt = gethostbyname([[url host] UTF8String]);
	
    // 获取服务器IP失败
	if (remoteHostEnt == NULL) {
		if ([self.delegate respondsToSelector:@selector(networkingResultsDidFail:)]) {
			[self.delegate networkingResultsDidFail:@"Unable to resolve the hostname of the warehouse server."];
		}
		
		return;
	}
	
	struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
	
	// set the socket parameters to open that IP address
    // 第三步：设置socket必要参数，包括服务器IP和使用端口（port），以便连接服务器
	struct sockaddr_in socketParameters;
	socketParameters.sin_family = AF_INET; // AF_INET - IPv4; AF_INET6 - IPv6
	socketParameters.sin_addr = *remoteInAddr;
	socketParameters.sin_port = htons([[url port] intValue]);
	
	// connect the socket; a return code of -1 indicates an error
    // 调用connect()，返回-1连接失败。
	if (connect(socketFileDescriptor, (struct sockaddr *) &socketParameters, sizeof(socketParameters)) == -1) {
		NSLog(@"Failed to connect to %@", url);
		
		if ([self.delegate respondsToSelector:@selector(networkingResultsDidFail:)]) {
			[self.delegate networkingResultsDidFail:@"Unable to connect to the warehouse server."];
		}
		
		return;
	}
	
	NSLog(@"Successfully connected to %@", url);

    // NSMutableData以读取数据
	NSMutableData *data = [[NSMutableData alloc] init];
	BOOL waitingForData = YES;
	
	// continually receive data until we reach the end of the data
    // 连续接收数据
	while (waitingForData){
		const char *buffer[1024];
		int length = sizeof(buffer);
		
		// read a buffer's amount of data from the socket; the number of bytes read is returned
		int result = recv(socketFileDescriptor, &buffer, length, 0);
		
		// if we got data, append it to the buffer and keep looping
		if (result > 0){
			[data appendBytes:buffer length:result];
			
		// if we didn't get any data, stop the receive loop
		} else {
			waitingForData = NO;
		}
	}
	
	// close the stream since we're done reading
    // 调用close()，关闭socket
	close(socketFileDescriptor);
	
	// 将读取的所有数据转换成字符串，解析成一个个需要的值，传给UI以便显示。
	NSString *resultsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"Received string: '%@'", resultsString);
	
	LLNNetworkingResult *result = [self parseResultString:resultsString];
	
	if (result != nil) {
		if ([self.delegate respondsToSelector:@selector(networkingResultsDidLoad:)]) {
			[self.delegate networkingResultsDidLoad:result];
		}
		
	} else {
		if ([self.delegate respondsToSelector:@selector(networkingResultsDidFail:)]) {
			[self.delegate networkingResultsDidFail:@"Unable to parse the response from the warehouse server."];
		}
	}
}

@end