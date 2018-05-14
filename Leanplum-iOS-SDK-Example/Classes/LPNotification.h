//
//  Notification.h
//  LeanplumNotificationReceiver
//
//  Created by Sayaan on 5/8/18.
//  Copyright © 2016 Leanplum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPNotification : NSObject

typedef NS_ENUM(NSUInteger, ReceiptDeliveredType) {
    kReceiptDeliveredTypeSending,
    kReceiptDeliveredTypeSent,
    kReceiptDeliveredTypeError
};

@property NSDate *date;
@property NSString *action;
@property NSString *messageTitle;
@property NSString *os;
@property NSString *uuid;
@property NSString *openActionType;
@property NSString *openActionUrl;
@property NSInteger deliveryReceiptSubmitted;
@property NSError *error;

-(instancetype)initWithAction:(NSString *)action
                  messageTitle:(NSString *)messageTitle
                           os:(NSString *)os
                         uuid:(NSString *)uuid
                openActionType:(NSString *)openActionType
                 openActionUrl:(NSString *)openActionUrl;

@end
