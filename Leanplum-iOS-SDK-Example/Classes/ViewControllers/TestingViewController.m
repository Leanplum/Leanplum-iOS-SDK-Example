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

@property (weak, nonatomic) IBOutlet UIButton *loadTestButton;

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)crash_app:(UIButton *)sender {
    exit(0);
}

- (IBAction)load_test:(UIButton *)sender {
    [_loadTestButton setTitle:@"Load Testing ..." forState:UIControlStateNormal];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        for (unsigned int i = 0; i < 10300; i++) {
            [Leanplum track:[NSString stringWithFormat:@"%@%i", @"load_test", i]];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [_loadTestButton setTitle:@"Load Test" forState:UIControlStateNormal];
        });
    });
}

- (IBAction)track_event:(UIButton *)sender {
    [Leanplum track:@"track_event"];
}

@end
