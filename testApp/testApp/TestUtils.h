//
//  TestUtils.h
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestUtils : NSObject
- (NSString *)imageToNSString:(UIImage *)image;
- (UIImage *)stringToUIImage:(NSString *)string;
-(UIActivityIndicatorView*)addActivityIndicatorToCurrentView:(UIView *)currentView;
-(void)remvoveActivityIndicatorFromView:(UIView *)currentView;


@end
