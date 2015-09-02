//
//  Entity.h
//  StartUpProject
//
//  Created by Okan Kurtulus on 02/09/15.
//  Copyright (c) 2015 Okan Kurtulus. All rights reserved.
//

#ifndef StartUpProject_Entity_h
#define StartUpProject_Entity_h

//Import AppDelegate that will be used to create repository
#import "AppDelegate.h"

//Import entity headers
#import "Item.h"

//All Entities should be listed below
typedef enum {
    Entity_Item,    //Item entity
    //... add new entities here
} EntityType;

#define EntityTypes @"Item", nil

#endif
