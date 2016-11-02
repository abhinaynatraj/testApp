//
//  TestUtils.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "TestUtils.h"

@implementation TestUtils


- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)stringToUIImage:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
}

-(UIActivityIndicatorView*)addActivityIndicatorToCurrentView:(UIView *)currentView {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.color = [UIColor grayColor];
    activityIndicator.center = currentView.center;
    activityIndicator.hidesWhenStopped = YES;
    [currentView addSubview:activityIndicator];
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    return activityIndicator;
}


-(void)remvoveActivityIndicatorFromView:(UIView *)currentView {
    for (UIView *subview in currentView.subviews) {
        if([subview isKindOfClass:[UIActivityIndicatorView class]]) {
            [subview removeFromSuperview];
        }
    }
}


@end
