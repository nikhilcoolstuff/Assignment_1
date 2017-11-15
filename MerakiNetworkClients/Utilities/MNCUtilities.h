//
//  MNCUtilities.h
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNCUtilities : NSObject
+(NSString *) formatKiloBytesFromNumber: (NSNumber *) kiloBytes;
+(NSString *) formatConnectedByString: (NSString *) input;
+(NSString *) formatAppsUsedToString: (NSArray *) apps;
@end
