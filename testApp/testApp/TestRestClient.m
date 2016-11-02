//
//  TestRestClient.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-02.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "TestRestClient.h"
#import "TestServices.h"
#import "TestUtils.h"

@implementation TestRestClient


- (void)testRetrieveAllImages:(NSURL *)url WithCallback:(void (^)(NSArray *))callback {
    
    TestServices *testServices = [[TestServices alloc] init];
    [testServices serviceGETRequestUrl:url withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil && data != nil) {
#ifdef DEBUG
            // Log response
            NSLog(@"Response Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
            NSError* error;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error];
            if(!error) {
                callback(json);
            } else {
                callback(nil);
            }
        }
    }];
}

- (void)testRetrieveImage:(NSURL *)url WithCallback:(void (^)(NSString *))callback {
    
    TestServices *testServices = [[TestServices alloc] init];
    [testServices serviceGETRequestUrl:url withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil && data != nil) {
#ifdef DEBUG
            // Log response
            NSLog(@"Response Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
            NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
            if(responseData) {
                callback(responseData);
            } else {
                callback(nil);
            }
        }
    }];
}

- (void)testUploadImage:(NSDictionary *)imageData WithCallback:(void (^)(NSDictionary *))callback {
    
    TestServices *testServices = [[TestServices alloc] init];
    //TODO: convert imageId to url
    NSURL *url = [NSURL URLWithString:@"https://api-server.essenceprototyping.com:999/photos/upload"];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:imageData options:0 error:&err];
    NSString * postStringData = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    
    
    [testServices servicePostRequest:postStringData url:url withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
            }
        }
 
    }];
}


@end
