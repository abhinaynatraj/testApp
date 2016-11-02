//
//  ViewController.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "ViewController.h"
#import "UploadViewController.h"
#import "ImagesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadImageButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UploadViewController *uploadVC = [storyboard instantiateViewControllerWithIdentifier:@"UploadViewController"];
    [self.navigationController pushViewController:uploadVC animated:YES];
}

- (IBAction)retrieveImagesButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ImagesViewController *imagesVC = [storyboard instantiateViewControllerWithIdentifier:@"ImagesViewController"];
    [self.navigationController pushViewController:imagesVC animated:YES];
}

@end
