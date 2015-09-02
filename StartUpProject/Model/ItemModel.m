//
//  ItemModel.m
//  StartUpProject
//
//  Created by Okan Kurtulus on 02/09/15.
//  Copyright (c) 2015 Okan Kurtulus. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+(void) createTempItemObject {
    dispatch_async(dispatch_get_main_queue(), ^() {
        Repository *repository = [Repository beginTransaction];
        Item *item = (Item*)[repository createEntity:Entity_Item];
        item.createDate = [NSDate new];
        item.name = @"entity";
        [repository endTransaction];
    });
}

+(void) logSavedItemObjects
{
    dispatch_async(dispatch_get_main_queue(), ^() {
        Repository *repository = [Repository beginTransaction];
        NSArray *items = [repository getResultsFromEntity:Entity_Item];
        for(Item *item in items)
            NSLog(@"I'm a %@, i was created at %@", item.name, item.createDate);
        [repository endTransaction];
    });
}

@end
