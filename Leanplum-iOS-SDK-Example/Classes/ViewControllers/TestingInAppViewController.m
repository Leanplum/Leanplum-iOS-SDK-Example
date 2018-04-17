//
//  TestingInAppViewController.m
//  Leanplum-iOS-SDK-Example
//
//  Created by Ben Marten on 4/4/18.
//  Copyright © 2018 Leanplum. All rights reserved.
//

#import "TestingInAppViewController.h"
#import <Leanplum/Leanplum.h>


@interface TestingInAppViewController ()

@end

@implementation TestingInAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alertClicked:(id)sender {
    [Leanplum track:@"alert"];
}

- (IBAction)centerPopupClicked:(id)sender {
    [Leanplum track:@"center_popup"];
}

- (IBAction)confirmClicked:(id)sender {
    [Leanplum track:@"confirm"];
}

- (IBAction)interstitialClicked:(id)sender {
    [Leanplum track:@"interstitial"];
}

- (IBAction)webInterstitialClicked:(id)sender {
    [Leanplum track:@"web_interstitial"];
}

- (IBAction)openUrlClicked:(id)sender {
    [Leanplum track:@"open_url"];
}

- (IBAction)bannerClicked:(id)sender {
    [Leanplum track:@"banner"];
}

- (IBAction)richInterstitialClicked:(id)sender {
    [Leanplum track:@"rich_interstitial"];
}

- (IBAction)starRatingClicked:(id)sender {
    [Leanplum track:@"star_rating"];
}

- (IBAction)chainToExistingClicked:(id)sender {
    [Leanplum track:@"chain_to_existing"];
}

- (IBAction)chainToNewClicked:(id)sender {
    [Leanplum track:@"chain_to_new"];
}

- (IBAction)limitSessionClicked:(id)sender {
    [Leanplum track:@"limit_session"];
}

- (IBAction)limitLifetimeClicked:(id)sender {
    [Leanplum track:@"limit_lifetime"];
}

@end
