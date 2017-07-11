//
//  TestModel.m
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
@dynamic testProperty1;
@synthesize testProperty2 = rewritePropertyIvar2;
@synthesize testProperty3;
-(void)mySetter:(NSString *)mySetter{
    
}
-(NSString *)myGetter{
    return nil;
}
+(void)classMethod1{
    NSLog(@"文字打印 classMethod1");
    NSLog(@"CMD打印 %@",NSStringFromSelector(_cmd));
}
+(void)classMethod2{
    NSLog(@"文字打印 classMethod2");
    NSLog(@"CMD打印 %@",NSStringFromSelector(_cmd));
}
+(NSInteger)classMethod3{
    return 0;
}
+(void)classMethod4:(NSString *)method4{
    
}
+(float)classMethod5:(NSArray *)method5{
    return 0.f;
}
+(NSArray *)classMethod6:(int)method6{
    return nil;
}
+(unsigned int)classMethod7:(int)method7 method7:(NSString *)_method7{
    return 1;
}
-(void)instanceMethod1{
    NSLog(@"文字打印 instanceMethod1");
    NSLog(@"CMD打印 %@",NSStringFromSelector(_cmd));
}
-(void)instanceMethod2{
    NSLog(@"文字打印 instanceMethod2");
    NSLog(@"CMD打印 %@",NSStringFromSelector(_cmd));
}
-(NSString *)instanceMethod3{
    NSLog(@"文字打印 instanceMethod3");
    NSLog(@"CMD打印 %@",NSStringFromSelector(_cmd));
    NSString *string = @"\n文字打印 instanceMethod3\nCMD打印 ";
    string = [string stringByAppendingString:NSStringFromSelector(_cmd)];
    return string;
}
-(NSString *)instanceMethod4{
    NSLog(@"文字打印 instanceMethod4");
    NSLog(@"CMD打印 %@",NSStringFromSelector(_cmd));
    NSString *string = @"\n文字打印 instanceMethod4\nCMD打印 ";
    string = [string stringByAppendingString:NSStringFromSelector(_cmd)];
    return string;
}
@end
