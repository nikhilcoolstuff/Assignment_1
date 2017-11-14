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

+(NSString *) formatConnectedByString: (NSString *) input {
    
    NSDictionary *lookUpDict =[NSDictionary dictionaryWithObjectsAndKeys:
                               @"Radio", @"r",
                               @"Switch", @"s",
                               @"Appliance", @"x", 
                               nil];
    NSString *displayString = @"Client => ";
    
    for (int i = 0; i < input.length; i++) {
        NSString *value = lookUpDict[[NSString stringWithFormat:@"%c",[input characterAtIndex:i]]];
        if (value)
            displayString = [displayString stringByAppendingString:[NSString stringWithFormat:@"%@ => ", value]];
    }
    return [displayString stringByAppendingString:@"Internet"];
}

@end
