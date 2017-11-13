//
//  MNCClientViewCell.h
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/11/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNCClientViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *usageLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectedByLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end
