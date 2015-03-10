//
//  connectionManager.m
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "connectionManager.h"
#import <AFNetworking/AFNetworking.h>

@interface connectionManager()

@property (strong, nonatomic) NSString* urlString;

@end

@implementation connectionManager

+ (instancetype)sharedManager
{
    static connectionManager *connectionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connectionManager = [[self alloc] init];
    });
    return connectionManager;
}

- (void)connectWithIpAddress:(NSString *)ip andUserName:(NSString *)userName andPassword:(NSString *)password inBackgroundWithBlock:(boolBlock)block
{
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    _urlString = [NSString stringWithFormat:@"http://%@:8888/connectServer.php?username=%@&password=%@",ip,userName,password];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:requst];
    //operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"%@",responseObject);
            NSDictionary *dict = responseObject;
            if ([[dict objectForKey:@"success"] boolValue])
            {
                block(YES,@"no error");
            }
            else
            {
                block(NO,@"netWork failure");
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        block(NO,@"Network Error");
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}

@end
