//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "C4QCatFactsDetailViewController.h"
#import "CatFactsTableViewCell.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *cats;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cats = [[NSMutableArray alloc] init];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *jsonReponseSerializer = [AFJSONResponseSerializer serializer];
    jsonReponseSerializer.acceptableContentTypes = nil;
    manager.responseSerializer = jsonReponseSerializer;
    
    [manager GET:@"http://catfacts-api.appspot.com/api/facts?number=100"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSArray *data = [responseObject objectForKey:@"facts"];
             
             
                 for (NSString *fact in data) {
                     [self.cats addObject:fact];
                 }
                 
                 [self.tableView reloadData];
             }
             
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"%@",error.userInfo);
             
             
         }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cats.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatFactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier" forIndexPath:indexPath];
    
    cell.catInfoLabel.text = self.cats[indexPath.row];
    cell.saveCatButton.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"catDetailView"]) {
        C4QCatFactsDetailViewController *dvc = segue.destinationViewController;
        dvc.catFact = self.cats[indexPath.row];
    }
}

- (IBAction)saveCatButton:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Your pussy fact has been saved!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"mmmmKay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"]) {
            NSMutableArray *savedCatFacts = [[NSMutableArray alloc] init];
            [savedCatFacts addObject:self.cats[sender.tag]];
            [[NSUserDefaults standardUserDefaults] setObject:savedCatFacts forKey:@"savedCatFacts"];
        } else {
            NSMutableArray *savedCatFactsCopy = [[NSMutableArray alloc] initWithArray:[[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"] mutableCopy]];
            [savedCatFactsCopy addObject:self.cats[sender.tag]];
            [[NSUserDefaults standardUserDefaults] setObject:savedCatFactsCopy forKey:@"savedCatFacts"];
        }

    }];
    
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
                               
@end
