//
//  TestServices.h
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestServices : NSObject

- (void)servicePostRequest:(NSString *)postData url:(NSURL *)url withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (void)serviceGETRequestUrl:(NSURL *)url withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

    
@end
