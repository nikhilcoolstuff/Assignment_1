//
//  MNCClient.h
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/11/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNCClient : NSObject

// Client Info
@property (readonly, nonatomic, copy) NSString *desc;
@property (readonly, nonatomic, copy) NSString *ip;
@property (readonly, nonatomic, assign) BOOL isOnline;

// Online Status
@property (readonly, nonatomic, strong) NSNumber *firstSeen;
@property (readonly, nonatomic, strong) NSNumber *lastSeen;
@property (readonly, nonatomic, copy) NSString *connectedBy;

// Raw Traffic
@property (readonly, nonatomic, strong) NSNumber *sent;
@property (readonly, nonatomic, strong) NSNumber *recv;
@property (readonly, nonatomic, strong) NSNumber *totalUsage;
@property (readonly, nonatomic, strong) NSDictionary *applicationUsage;
@property (readonly, nonatomic, strong) NSArray *timeSeriesUsage;

-(id) initWithDictionary: (NSDictionary *) dictionary;

@end
