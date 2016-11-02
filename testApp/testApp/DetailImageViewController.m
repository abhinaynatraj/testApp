//
//  DetailImageViewController.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "DetailImageViewController.h"
#import "TestUtils.h"

@interface DetailImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation DetailImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSelectedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadSelectedImage {
    TestUtils *testUtils = [[TestUtils alloc] init];
    if(self.selectedImageId && self.selectedImageString) {
        UIImage *image = [testUtils stringToUIImage:self.selectedImageString];
        self.selectedImageView.image = image;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
