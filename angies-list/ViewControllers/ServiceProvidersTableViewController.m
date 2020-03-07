//
//  ServiceProvidersTableViewController.m
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

#import "ServiceProvidersTableViewController.h"
#import "angies_list-Swift.h"

@interface ServiceProvidersTableViewController ()

@end

@implementation ServiceProvidersTableViewController

NSArray<ServiceProvider *> *serviceProviders;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [serviceProviders count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceProviderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceProviderCell" forIndexPath:indexPath];
    
    cell.ratingLabel.text = @"A";
    cell.reviewsLabel.text = @"309 Recent Reviews";
    cell.nameLabel.text = @"William J Ciriello Plublimg Co Inc";
    cell.addressLabel.text = @"Beech Grove, Indiana 46107";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"ServiceProviderDetail" bundle:NSBundle.mainBundle] instantiateInitialViewController];
    [self showViewController:viewController sender:self];
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
