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

- (void)serviceGETRequest:(NSString *)requestData url:(NSURL *)url withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.connectionProxyDictionary = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
#ifdef DEBUG
    NSLog(@"Request URL: %@", url);
    NSLog(@"Request Data: %@", requestData);
#endif
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[requestData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:completionHandler];
    [dataTask resume];
}

- (void)serviceResponseHandleData:(NSData *)data urlResponse:(NSURLResponse *)response error:(NSError *)error withCallback:(void (^)(NSArray *))callback {
    if (error == nil && data != nil) {
#ifdef DEBUG
        // Log response
        NSLog(@"Response Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
        NSError* error;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        if(!error) {
            callback(json);
        } else {
            callback(nil);
            //return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
}

@end
