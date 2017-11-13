//
//  MNCViewController.m
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/11/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import "MNCViewController.h"
#import "MNCApiManager.h"
#import "MNCClient.h"
#import "MNCClientViewCell.h"

static NSString * const CELL_ID = @"clientViewCellID";
#define ROW_HEIGHT 120;

@interface MNCViewController () {
    BOOL renderingCompleted;
}
@property (nonatomic, strong) MNCApiManager *apiManager;
@property (nonatomic, strong) NSArray *clients;
@end

@implementation MNCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    renderingCompleted = NO;
    self.apiManager = [[MNCApiManager alloc] init];
    self.clients = [self.apiManager getClients];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!renderingCompleted) {
        renderingCompleted = true;
        [self.tableView reloadData];
    }
}

#pragma mark table view data source and delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.clients.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MNCClientViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.onlineStatusView.layer.cornerRadius = cell.onlineStatusView.bounds.size.width/2;
    
    MNCClient *client = self.clients[indexPath.row];
    cell.descLabel.text = client.desc;
    cell.usageLabel.text = [NSString stringWithFormat:@"Received: %ld Sent %ld (in KB)", [client.recv integerValue], [client.sent integerValue]];
    cell.connectedByLabel.text = client.connectedBy;
    cell.alertLabel.text = @"test";
    if (client.isOnline)
        cell.onlineStatusView.backgroundColor = [UIColor greenColor];
    else
        cell.onlineStatusView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
    
    return cell;
}

#pragma mark local methods

-(void) configureViews {
    self.navigationItem.title = @"M E R A K I     C L I E N T S";
}

@end
