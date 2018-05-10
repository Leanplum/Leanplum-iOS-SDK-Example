//
//  Notification.m
//  LeanplumNotificationReceiver
//
//  Created by Sayaan on 5/8/18.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import "LPNotification.h"

@implementation LPNotification

- (instancetype)initWithAction:(NSString *)action
                  messageTitle:(NSString *)messageTitle
                openActionType:(NSString *)openActionType
                 openActionUrl:(NSString *)openActionUrl;
{
    self = [super init];
    if (self) {
        self.date = [NSDate date];
        self.action = action;
        self.messageTitle = messageTitle;
        self.openActionType = openActionType;
        self.openActionUrl = openActionUrl;
        self.deliveryReceiptSubmitted = kReceiptDeliveredTypeSending;
    }
    return self;
}

@end
