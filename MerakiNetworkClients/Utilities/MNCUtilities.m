//
//  MNCUtilities.m
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import "MNCUtilities.h"

@implementation MNCUtilities

+(NSString *) formatKiloBytesFromNumber: (NSNumber *) kiloBytes {
    return [NSByteCountFormatter stringFromByteCount:[kiloBytes longLongValue] countStyle:NSByteCountFormatterCountStyleFile];
}

@end
