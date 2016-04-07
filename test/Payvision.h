//
//  Payvision.h
//  test
//
//  Created by Home on 7/4/16.
//  Copyright © 2016年 sure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payvision : NSObject
@property (nonatomic,copy)NSString *memberId;
@property (nonatomic,copy)NSString *memberGuid;
@property (nonatomic,copy)NSString *countryId;
@property (nonatomic,copy)NSString *amount;
@property (nonatomic,copy)NSString *currencyId;
@property (nonatomic,copy)NSString *trackingMemberCode;
@property (nonatomic,copy)NSString *cardNumber;
@property (nonatomic,copy)NSString *cardHolder;
@property (nonatomic,copy)NSString *cardExpiryMonth;
@property (nonatomic,copy)NSString *cardExpiryYear;
@property (nonatomic,copy)NSString *cardCvv;
@property (nonatomic,copy)NSString *cardType;
@property (nonatomic,copy)NSString *issueNumber;
@property (nonatomic,copy)NSString *merchantAccountType;
@property (nonatomic,copy)NSString *dynamicDescriptor;
@property (nonatomic,copy)NSString *avsAddress;
@property (nonatomic,copy)NSString *avsZip;
@property (nonatomic,copy)NSDictionary *duc;
- (NSDictionary *)getDic;
@end
