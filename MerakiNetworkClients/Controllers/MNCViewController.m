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
#import <Lottie/Lottie.h>

static NSString * const CELL_ID = @"clientViewCellID";
static NSString * const TITLE = @"M E R A K I";

#define ROW_HEIGHT 125;

@interface MNCViewController () {
    BOOL renderingCompleted;
    NSArray *NETWORK_ABUSE_KEYS;
    MNCClient *selectedClient;
}

@property (nonatomic, strong) MNCApiManager *apiManager;
@property (nonatomic, strong) NSArray *clients;
@property (nonatomic, strong) LOTAnimationView *lottieLogo;

@end

@implementation MNCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    renderingCompleted = NO;
    NETWORK_ABUSE_KEYS = @[@"Netflix", @"YouTube"]; // add restricted apps here
    self.apiManager = [[MNCApiManager alloc] init];
    self.clients = [[self.apiManager getClients] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"totalUsage" ascending:NO]]];
    
    [self configureViews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.lottieLogo.loopAnimation = YES;
    [self.lottieLogo play];
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
    cell.usageLabel.text = [NSString stringWithFormat:@"Total usage %@",[MNCUtilities formatKiloBytesFromNumber:client.totalUsage]];
    cell.connectedByLabel.text = [MNCUtilities formatConnectedByString:client.connectedBy];
    cell.alertLabel.text = [self highUsageClientStringForClient:client];
    
    if (client.isOnline)
        cell.onlineStatusView.backgroundColor = [UIColor greenColor];
    else
        cell.onlineStatusView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedClient = self.clients[indexPath.row];
    [self performSegueWithIdentifier:@"segue_to_detail" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MNCDetailController *detailVC = (MNCDetailController *)segue.destinationViewController;
    detailVC.client = selectedClient;
}

#pragma mark local methods

-(void) configureViews {
    self.navigationItem.title = TITLE;
    self.lottieLogo = [LOTAnimationView animationNamed:@"pulse_loader"];
    self.lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = self.lottieLogo;
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

@end
