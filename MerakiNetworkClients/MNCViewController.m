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
#import "MNCDetailController.h"
#import "MNCUtilities.h"

static NSString * const CELL_ID = @"clientViewCellID";
static NSString * const TITLE = @"M E R A K I     C L I E N T";

#define ROW_HEIGHT 120;

@interface MNCViewController () {
    BOOL renderingCompleted;
    NSArray *NETWORK_ABUSE_KEYS;
}

@property (nonatomic, strong) MNCApiManager *apiManager;
@property (nonatomic, strong) NSArray *clients;
@end

@implementation MNCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    renderingCompleted = NO;
    NETWORK_ABUSE_KEYS = @[@"Netflix", @"YouTube"];
    self.apiManager = [[MNCApiManager alloc] init];
    self.clients = [self.apiManager getClients];
    
    [self configureViews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//     [self addDetailViewController];
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
    cell.usageLabel.text = [NSString stringWithFormat:@"Sent: %@ Received: %@", [MNCUtilities formatKiloBytesFromNumber:client.sent], [MNCUtilities formatKiloBytesFromNumber: client.recv]];
    cell.connectedByLabel.text = client.connectedBy;
    cell.alertLabel.text = [self highUsageClientStringForClient:client];
    if (client.isOnline)
        cell.onlineStatusView.backgroundColor = [UIColor greenColor];
    else
        cell.onlineStatusView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"segue_to_detail" sender:nil];
}

#pragma mark local methods

-(void) configureViews {
    self.navigationItem.title = TITLE;
}

// Check if client is abusing network
-(NSString *) highUsageClientStringForClient: (MNCClient *) client {
    __block NSString *displayString = @"Restricted: ";
    __block BOOL highUsage = NO;
    [NETWORK_ABUSE_KEYS enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (client.applicationUsage[obj]) {
            highUsage = YES;
            displayString = [displayString stringByAppendingString:[NSString stringWithFormat:@"%@, ", obj]];
        }
    }];
    if (highUsage)
        return [displayString substringToIndex:(displayString.length - 2)];
    
    return nil;
}

-(void) addDetailViewController {
    
    MNCDetailController  *detailVC = [[MNCDetailController alloc] init];
    [self addChildViewController:detailVC];
    [self.view addSubview:detailVC.view];
    [detailVC didMoveToParentViewController:self];
    
    // 3- Adjust bottomSheet frame and initial position.
    float height = self.view.frame.size.height;
    float width  = self.view.frame.size.width;
    detailVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), width, height);
}
@end
