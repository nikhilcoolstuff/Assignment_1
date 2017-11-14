//
//  MNCDetailController.m
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import "MNCDetailController.h"

@interface MNCDetailController ()

@end

@implementation MNCDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        CGRect frame = self.view.frame;
        float yComponent = [UIScreen mainScreen].bounds.size.height -200;
        self.view.frame = CGRectMake(0, yComponent, frame.size.width,frame.size.height);
    } completion:^(BOOL finished) {
        //code for completion
    }];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell_id" forIndexPath:indexPath];
//
//    // Configure the cell...
//
//    return cell;
//}

@end
