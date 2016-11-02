//
//  TestServices.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "TestServices.h"

@implementation TestServices


- (void)servicePostRequest:(NSString *)postData url:(NSURL *)url withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.connectionProxyDictionary = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
#ifdef DEBUG
    NSLog(@"Request URL: %@", url);
    NSLog(@"Request Data: %@", postData);
#endif
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:completionHandler];
    [dataTask resume];
}

- (void)serviceGETRequestUrl:(NSURL *)url withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.connectionProxyDictionary = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
#ifdef DEBUG
    NSLog(@"Request URL: %@", url);
   // NSLog(@"Request Data: %@", requestData);
#endif
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    //[urlRequest setHTTPBody:[requestData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:completionHandler];
    [dataTask resume];
}

@end
