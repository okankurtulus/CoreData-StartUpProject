//
//  ViewController.m
//  StartUpProject
//
//  Created by Okan Kurtulus on 02/09/15.
//  Copyright (c) 2015 Okan Kurtulus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Make a temp save and fetch
    [ItemModel createTempItemObject];
    [ItemModel logSavedItemObjects];
}

-(IBAction)addNewItemPressed:(id)sender {
    [ItemModel createTempItemObject];
    [ItemModel logSavedItemObjects];
}

@end
