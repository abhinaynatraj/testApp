//
//  UploadViewController.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "UploadViewController.h"
#import "TestRestClient.h"
#import "TestUtils.h"

@interface UploadViewController ()
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *selectedImage;
@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PickImageButtonTapped:(id)sender {

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //check if there is pending photo
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self pickFromGallery];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)pickFromGallery {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.imagePicker = info[UIImagePickerControllerEditedImage];
    self.pickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.uploadImage.hidden = NO;
    //upload to backend
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)uploadSelectedImage:(id)sender {
    TestRestClient *testRestClient = [[TestRestClient alloc] init];
    TestUtils *testUtils = [[TestUtils alloc] init];

    NSURL *postUrl = [NSURL URLWithString:@"https://api-server.essenceprototyping.com:999/photos/upload"];
    [testUtils addActivityIndicatorToCurrentView:self.view];
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setValue:@"logo" forKey:@"name"];
    [postDict setValue:[testUtils imageToNSString:self.pickedImage.image] forKey:@"data"];
    [testRestClient testUploadImage:postDict WithCallback:^(NSDictionary *response) {
        if(response) {
            [testUtils remvoveActivityIndicatorFromView:self.view];
        }
        
    }];
    
}



@end
