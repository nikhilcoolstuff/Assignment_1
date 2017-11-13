//
//  MNCClient.m
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/11/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import "MNCClient.h"

@implementation MNCClient

-(id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        _desc = dictionary[@"clientInfo"][@"description"];
        _ip = dictionary[@"clientInfo"][@"ip"];
        _isOnline = dictionary[@"clientInfo"][@"isOnline"];
        _firstSeen = dictionary[@"onlineStatus"][@"firstSeen"];
        _lastSeen = dictionary[@"onlineStatus"][@"lastSeen"];
        _connectedBy = dictionary[@"onlineStatus"][@"connectedBy"];
        _sent = dictionary[@"rawTraffic"][@"sent"];
        _recv = dictionary[@"rawTraffic"][@"recv"];
        _applicationUsage = dictionary[@"rawTraffic"][@"applicationUsage"];
        _timeSeriesUsage = dictionary[@"rawTraffic"][@"timeSeriesUsage"];
    }
    return self;
}

@end
