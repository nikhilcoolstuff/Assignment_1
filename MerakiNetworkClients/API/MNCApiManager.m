//
//  MNCApiManager.m
//  MerakiNetworkClients
//
//  Created by Nikhil Lele on 11/11/17.
//  Copyright © 2017 Meraki. All rights reserved.
//

#import "MNCApiManager.h"
#import "MNCClient.h"

@implementation MNCApiManager

-(NSArray *) getClients {
    
    NSString *clientsDataString = [self loadJSONContents];
    NSData *data = [clientsDataString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *clientArrayJson = jsonOutput[@"clients"];
    NSMutableArray *clients = [NSMutableArray new];
    [clientArrayJson enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [clients addObject:[[MNCClient alloc] initWithDictionary:obj]];
    }];
    return clients;
}

-(NSString *) loadJSONContents {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"clients" ofType:@"json"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
        return nil;
    }
    return fileContents;
}

@end
