//
//  STModel.m
//  test
//
//  Created by Home on 7/4/16.
//  Copyright © 2016年 sure. All rights reserved.
//

#import "STModel.h"
#import <objc/objc-runtime.h>
@implementation STModel
+(NSDictionary *)getDic:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *ivars = class_copyPropertyList([obj class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t ivar = ivars[i];
        const char *name = property_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [obj valueForKey:key];
        if(value == nil)
        {
            value = @"";
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:key];
    }
    free(ivars);
    return dic;
}
+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getDic:obj];
}
+ (void) ObjectSetValue:(NSObject *)objinstance : (NSString *)propertyname  :(NSString *)value{
    const NSSet *boolTypes = [NSSet setWithObjects: @"Tc", nil];
    const NSSet *intTypes  = [NSSet setWithObjects: @"Ti", nil];
    const NSSet *floatTypes = [NSSet setWithObjects: @"Tf", nil];
    const NSSet *doubleTypes = [NSSet setWithObjects: @"Td", nil];
    const NSSet *stringTypes = [NSSet setWithObjects: @"T@\"NSString\"", nil];
    
    objc_property_t otype=class_getProperty([objinstance class], [propertyname UTF8String]);
    NSString *dataType = [NSString stringWithUTF8String: property_getAttributes(otype)];
    dataType=([dataType componentsSeparatedByString:@","])[0];
    
    if ([stringTypes containsObject: dataType]) {
        [objinstance setValue:value forKey:propertyname];
    }if ([boolTypes containsObject: dataType]) {
        BOOL blnvalue=[value isEqualToString:@"false"] ? NO : YES;
        [objinstance setValue: [NSNumber numberWithBool:blnvalue] forKey:propertyname];
    }else if ([intTypes containsObject: dataType]) {
        int intvalue=[value integerValue];
        [objinstance setValue: [NSNumber numberWithInt:intvalue] forKey:propertyname];
    }else if ([floatTypes containsObject: dataType]) {
        float floatvalue=[value floatValue];
        [objinstance setValue: [NSNumber numberWithFloat:floatvalue] forKey:propertyname];
    }else if ([doubleTypes containsObject: dataType]) {
        double doublevalue=[value doubleValue];
        [objinstance setValue: [NSNumber numberWithDouble:doublevalue] forKey:propertyname];
    }else{
        [objinstance setValue:value forKey:propertyname];
    }
}
+ (id)initWithDic:(NSDictionary *)dic :(id)obj{
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([obj class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t key = propertys[i];
        const char *name = property_getName(key);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [NSString stringWithFormat:@"%@",dic[propertyName]];
        if(value == nil){
            value = @"";
        }else{
            value = [self getObjectInternal:value];
        }
        [self ObjectSetValue:obj :propertyName :value];
//        SEL selector =[self creatSetterWithPropertyName:propertyName];
//        IMP imp = [obj methodForSelector:selector];
//        void (*func)(id,SEL,NSString *)= (void *)imp;
//        func(obj,selector,value);
    }
    free(propertys);
    return obj;
}
+(id)getObject:(id)obj{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObject:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObject:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return obj;
}
+(SEL)creatSetterWithPropertyName: (NSString *) propertyName{
    propertyName = propertyName.capitalizedString;
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    return NSSelectorFromString(propertyName);
}

+(NSArray *)GetWithArr:(NSArray *)list :(id)obj
{
    NSMutableArray *arr = [NSMutableArray array];
    if (list) {
        for (int i=0; i<list.count; i++) {
            NSDictionary *dic = list[i];
            [arr addObject:[self initWithDic:dic :obj]];
        }
    }
    return arr;
}
@end
