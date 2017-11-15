//
//  MNCDetailController.m
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import "MNCDetailController.h"
#import <Lottie/Lottie.h>
#import "MNCUtilities.h"

@interface MNCDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LOTAnimationView *lottieLogo;
@property (nonatomic, strong) UIButton *lottieButton;
@property (nonatomic, strong) NSArray *tableViewItems;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MNCDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _buildDataSource];
    self.lottieLogo = [LOTAnimationView animationNamed:@"loading"];
    self.lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.lottieLogo];

    self.lottieButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lottieButton addTarget:self action:@selector(_playLottieAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lottieButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"customcell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [self.view addSubview:self.tableView];

    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect lottieRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.3);
    self.lottieLogo.frame = lottieRect;
    self.lottieButton.frame = lottieRect;
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(lottieRect), CGRectGetWidth(lottieRect), self.view.bounds.size.height - CGRectGetMaxY(lottieRect));

}

#pragma mark -- Internal Methods

- (void)_buildDataSource {
    self.tableViewItems = @[@{@"name" : @"DESC",
                              @"value" : self.client.desc},
                            @{@"name" : @"IP",
                              @"value" : self.client.ip},
                            @{@"name" : @"IS ONLINE",
                              @"value" : self.client.isOnline ? @"YES" : @"NO"},
                            @{@"name" : @"Total Usage",
                              @"value" : [MNCUtilities formatKiloBytesFromNumber:self.client.totalUsage]},
                            @{@"name" : @"Sent",
                              @"value" : [MNCUtilities formatKiloBytesFromNumber:self.client.sent]},
                            @{@"name" : @"Received",
                              @"value" : [MNCUtilities formatKiloBytesFromNumber:self.client.recv]},
                            @{@"name" : @"Apps Used",
                              @"value" : [MNCUtilities formatAppsUsedToString:[self.client.applicationUsage allKeys]]},
                            @{@"name" : @"Conected by",
                              @"value" : [MNCUtilities formatConnectedByString:self.client.connectedBy]}];
}

- (void)_playLottieAnimation {
    self.lottieLogo.animationProgress = 0;
    [self.lottieLogo play];
}

#pragma mark -- UITableViewDataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customcell" forIndexPath:indexPath];
    cell.textLabel.text = [self.tableViewItems[indexPath.row][@"name"]  stringByAppendingString:[NSString stringWithFormat:@": %@", self.tableViewItems[indexPath.row][@"value"]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

@end
