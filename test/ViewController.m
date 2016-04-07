//
//  ViewController.m
//  test
//
//  Created by Home on 28/8/15.
//  Copyright (c) 2015年 sure. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import "Payvision.h"
#import "STModel.h"
@interface ViewController (){
    NSDictionary *dic;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Payvision *pay = [[Payvision alloc]init];
    pay.memberId=@"4554";
    pay.memberGuid = @"454345";
    pay.countryId = @"545";
    pay.amount=@"54543";
    pay.currencyId=@"543543";
    pay.trackingMemberCode=@"543534";
    pay.cardNumber = @"5345435";
    pay.cardHolder=@"";
    pay.cardExpiryMonth=@"12";
    pay.cardExpiryYear=@"2017";
//    pay.cardCvv=@"029";
    pay.cardType = @"";//VisaElectron
    pay.issueNumber=@"";//Switch
    pay.merchantAccountType=@"1";
    pay.dynamicDescriptor=@"";
    pay.avsAddress=@"Street address";
    pay.duc=@{};
    pay.avsZip=@"Zip Code ";
    dic = [STModel getDic:pay];
    // Do any additional setup after loading the view, typically from a nib.
}
@end
