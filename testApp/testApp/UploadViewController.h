//
//  UploadViewController.h
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadViewController : UIViewController<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pickedImage;
@property (weak, nonatomic) IBOutlet UIButton *uploadImage;

@end
