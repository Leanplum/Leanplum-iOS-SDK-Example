//
//  TestingViewController.m
//  Leanplum-iOS-SDK-Example
//
//  Created by Sayaan Saha  on 7/10/17.
//  Copyright © 2017 Leanplum. All rights reserved.
//

#import "TestingViewController.h"
#import <Leanplum/Leanplum.h>

@interface TestingViewController()

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)crash_app:(UIButton *)sender {
    exit(0);
}

- (IBAction)load_test:(UIButton *)sender {
    for (unsigned int i = 0; i < 10300; i++) {
        [Leanplum track:[NSString stringWithFormat:@"%@%i", @"load_test", i]];
    }
}

- (IBAction)track_event:(UIButton *)sender {
    [Leanplum track:@"track_event"];
}

@end
