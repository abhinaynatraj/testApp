//
//  ImagesViewController.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "ImagesViewController.h"
#import "TestServices.h"
#import "DetailImageViewController.h"
#import "TestUtils.h"

@interface ImagesViewController ()
@property (strong, nonatomic) IBOutlet UITableView *imagesTableView;
@property (strong, nonatomic) NSMutableArray *imagesFromBackend;
@end

@implementation ImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    self.imagesTableView.estimatedRowHeight = 45.0f;
    self.imagesTableView.rowHeight = UITableViewAutomaticDimension;
    self.imagesTableView.tableFooterView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectZero];
    self.title = @"Images";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData {
    TestServices *testServices = [[TestServices alloc] init];
    NSURL *getUrl = [NSURL URLWithString:@"https://api-server.essenceprototyping.com:999/photos/search/?searchString"];
    //    [testServices servicePostRequest:[self imageToNSString:self.pickedImage.image] url:postUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [testServices serviceGETRequest:nil url:getUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [testServices serviceResponseHandleData:data urlResponse:response error:error withCallback:^(NSArray *responseDictionary) {
            //
            self.imagesFromBackend = [responseDictionary mutableCopy];
            [self.imagesTableView reloadData];
        }];
        
        NSLog(@"response is : %@", data);
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imagesFromBackend.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"imageTitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailImageViewController *detailImageViewController = [[DetailImageViewController alloc] init];
    TestUtils *testUtils = [[TestUtils alloc] init];
    detailImageViewController.selectedImageId = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"id"];
    NSString *selectedImagePath = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"path"];
    NSString *selectedImageId = [[selectedImagePath componentsSeparatedByString:@"/"] lastObject];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api-server.essenceprototyping.com:999/photos/get/%@",selectedImageId]];
    
    
    TestServices *testServices = [[TestServices alloc] init];
    NSURL *getUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api-server.essenceprototyping.com:999/photos/get/%@", selectedImageId]];
    [testServices serviceGETRequest:nil url:getUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        
        detailImageViewController.selectedImage = image;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        DetailImageViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailImageViewController"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    
    
    
    //detailImageViewController.selectedImage = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"id"];
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
