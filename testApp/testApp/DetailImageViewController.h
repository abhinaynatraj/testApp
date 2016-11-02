//
//  DetailImageViewController.h
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImageViewController : UIViewController
@property (weak, nonatomic) NSString *selectedImageId;
@property (weak, nonatomic) UIImage *selectedImage;

@end
