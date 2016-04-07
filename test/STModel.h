//
//  STModel.h
//  test
//
//  Created by Home on 7/4/16.
//  Copyright © 2016年 sure. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface STModel : NSObject
+(NSDictionary *)getDic:(id)obj;
+(id)initWithDic:(NSDictionary *)dic :(id)obj;
+(NSArray *)GetWithArr:(NSArray *)list :(id)obj;
@end
