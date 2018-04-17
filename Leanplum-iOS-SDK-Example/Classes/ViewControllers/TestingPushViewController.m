//
//  TestingPushViewController.m
//  Leanplum-iOS-SDK-Example
//
//  Created by Ben Marten on 4/4/18.
//  Copyright © 2018 Leanplum. All rights reserved.
//

#import "TestingPushViewController.h"
#import <Leanplum/Leanplum.h>

@interface TestingPushViewController ()

@end

@implementation TestingPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushClicked:(id)sender {
    [Leanplum track:@"Send_push"];
}

- (IBAction)pushConfirmClicked:(id)sender {
    [Leanplum track:@"Send_push_confirm"];
}

- (IBAction)pushAlertClicked:(id)sender {
    [Leanplum track:@"Send_push_alert"];
}

- (IBAction)pushCenterClicked:(id)sender {
    [Leanplum track:@"Send_push_center"];
}

- (IBAction)pushInterstitialClicked:(id)sender {
    [Leanplum track:@"Send_push_interstitial"];
}

- (IBAction)pushMuteClicked:(id)sender {
    [Leanplum track:@"Send_push_mute"];
}

- (IBAction)pushMuteConfirmClicked:(id)sender {
    [Leanplum track:@"Send_push_mute_confirm"];
}

- (IBAction)pushMuteAlertClicked:(id)sender {
    [Leanplum track:@"Send_push_mute_alert"];
}

- (IBAction)pushMuteCenterClicked:(id)sender {
    [Leanplum track:@"Send_push_mute_center"];
}

- (IBAction)pushMuteInterstitialClicked:(id)sender {
    [Leanplum track:@"Send_push_mute_interstitial"];
}

- (IBAction)sendPushTriggeredClicked:(id)sender {
    [Leanplum track:@"Send_push_triggered"];
}

- (IBAction)cancelPushTriggeredClicked:(id)sender {
    [Leanplum track:@"Cancel_push_triggered"];
}

@end
