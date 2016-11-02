//
//  TestRestClient.h
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-02.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestRestClient : NSObject


- (void)testRetrieveAllImages:(NSURL *)url WithCallback:(void (^)(NSArray *))callback;
- (void)testRetrieveImage:(NSURL *)url WithCallback:(void (^)(NSString *))callback;
- (void)testUploadImage:(NSDictionary *)imageData WithCallback:(void (^)(NSDictionary *))callback;

    
@end
