//
//  ARAViewController.m
//  ARAppUpdater
//
//  Created by Alex M Reynolds on 12/07/2015.
//  Copyright (c) 2015 Alex M Reynolds. All rights reserved.
//

#import "ARAViewController.h"
#import <ARAppUpdater/ARAppUpdater.h>
@interface ARAViewController ()

@end

@implementation ARAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ARAppUpdater *updater = [[ARAppUpdater alloc] initWithOptions:@{kAPAUpdateRequired : @YES, kAPACustomVersionKeyPath : @"data.minimum_release.version", kAPACustomVersionURL : @"http://api-stage.vacasait.com/clients/validation/ios-housekeeper-app"}];
    [updater checkForUpdate:^{
        
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
