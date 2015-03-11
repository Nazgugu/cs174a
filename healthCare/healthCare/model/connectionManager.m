//
//  connectionManager.m
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "connectionManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ProgressHUD.h"

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
    [ProgressHUD show:@"Connecting" Interaction:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    _urlString = [NSString stringWithFormat:@"http://%@:8888/connectServer.php?username=%@&password=%@",ip,userName,password];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2];
    
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
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
            else
            {
                block(NO,[dict objectForKey:@"error"]);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        block(NO,@"Network Error");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [ProgressHUD dismiss];
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}

- (void)fetchInBackgroundWithPatientId:(NSString *)patientId andBlock:(objectBlock)block
{
    [ProgressHUD show:@"Fetching" Interaction:NO];
    //NSLog(@"patient = %@",patientId);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    _urlString = [NSString stringWithFormat:@"http://%@:8888/patientLogin.php",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverKey"]];
    //NSLog(@"url = %@",_urlString);
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2];
    [requst setHTTPMethod:@"POST"];
    [requst setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSString *postingString = [NSString stringWithFormat:@"patientId=%@",patientId];
    [requst setHTTPBody:[postingString dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:requst];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *patientResponse = responseObject;
            if ([[patientResponse objectForKey:@"success"] boolValue])
            {
                if ([[patientResponse objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
                {
                    //NSLog(@"result = %@",[patientResponse objectForKey:@"result"]);
                    block([patientResponse objectForKey:@"result"],@"success");
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ProgressHUD dismiss];
                }
            }
            else
            {
                block(nil,@"no such patient");
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"not good");
        NSLog(@"%@",[error description]);
        block(nil,@"Network Error");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [ProgressHUD dismiss];
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}

- (void)loginInBackgroundWithDoctorId:(NSString *)doctorId andBlock:(boolBlock)block
{
    [ProgressHUD show:@"Fetching" Interaction:NO];
    //NSLog(@"patient = %@",patientId);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    _urlString = [NSString stringWithFormat:@"http://%@:8888/authorLogin.php",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverKey"]];
    //NSLog(@"url = %@",_urlString);
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2];
    [requst setHTTPMethod:@"POST"];
    [requst setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSString *postingString = [NSString stringWithFormat:@"AuthorId=%@",doctorId];
    [requst setHTTPBody:[postingString dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:requst];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *patientResponse = responseObject;
            if ([[patientResponse objectForKey:@"success"] boolValue])
            {
                block(YES,@"success");
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
            else
            {
                block(NO,[patientResponse objectForKey:@"error"]);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"not good");
        NSLog(@"%@",[error description]);
        block(NO,@"Network Error");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [ProgressHUD dismiss];
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}

- (void)updatePatientInfoWithPatient:(patient *)patient inBackgroundWithBlock:(boolBlock)block
{
    [ProgressHUD show:@"Fetching" Interaction:NO];
    //NSLog(@"patient = %@",patient.patientId);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    _urlString = [NSString stringWithFormat:@"http://%@:8888/modifyPatient.php",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverKey"]];
    NSLog(@"url = %@",_urlString);
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [requst setHTTPMethod:@"POST"];
    [requst setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSString *postingString = [NSString stringWithFormat:@"patientId=%@&GivenName=%@&FamilyName=%@&Suffix=%@&Gender=%@&BirthTime=%@&providerId=%@&guardianNo=%@&Relationship=%@&FirstName=%@&LastName=%@&phone=%@&address=%@&city=%@&state=%@&zip=%@",patient.patientId,patient.GivenName,patient.FamilyName,patient.Suffix,patient.Gender,patient.BirthTime,patient.providerId,patient.GuardianNo,patient.Relationship,patient.FirstName,patient.LastName,patient.phone,patient.address,patient.city,patient.state,patient.zip];
    //NSLog(@"body = %@",postingString);
    [requst setHTTPBody:[postingString dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:requst];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            //NSLog(@"%@",responseObject);
            NSDictionary *dict = responseObject;
            if ([[dict objectForKey:@"success"] boolValue])
            {
                block(YES,@"Update Success");
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
            else
            {
                block(NO,[dict objectForKey:@"error"]);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ProgressHUD dismiss];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        block(NO,@"Network Error");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [ProgressHUD dismiss];
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}


@end
