//
//  ImagesViewController.m
//  testApp
//
//  Created by Abhinay Natraj on 2016-11-01.
//  Copyright © 2016 Abhinay Natraj. All rights reserved.
//

#import "ImagesViewController.h"
#import "TestRestClient.h"
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
    TestRestClient *testRestClient = [[TestRestClient alloc] init];
    TestUtils *testUtils = [[TestUtils alloc] init];
    NSURL *getUrl = [NSURL URLWithString:@"https://api-server.essenceprototyping.com:999/photos/search/?searchString"];
    [testUtils addActivityIndicatorToCurrentView:self.view];

    [testRestClient testRetrieveAllImages:getUrl WithCallback:^(NSArray *images) {
        self.imagesFromBackend = [images mutableCopy];
        [self.imagesTableView reloadData];
        [testUtils remvoveActivityIndicatorFromView:self.view];
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
    TestUtils *testUtils = [[TestUtils alloc] init];
    NSString *selectedImagePath = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"path"];
    NSString *selectedImageId = [[selectedImagePath componentsSeparatedByString:@"/"] lastObject];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api-server.essenceprototyping.com:999/photos/get/%@",selectedImageId]];
    
    [testUtils addActivityIndicatorToCurrentView:self.view];
    
    TestRestClient *testRestClient = [[TestRestClient alloc] init];
    [testRestClient testRetrieveImage:url WithCallback:^(NSString *imageData) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        DetailImageViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailImageViewController"];
        detailVC.selectedImageId = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"_id"];
        detailVC.title = [[self.imagesFromBackend objectAtIndex:indexPath.row] valueForKey:@"name"];
        detailVC.selectedImageString = [[NSString alloc] initWithString:imageData];
        
        [testUtils remvoveActivityIndicatorFromView:self.view];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }];
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
