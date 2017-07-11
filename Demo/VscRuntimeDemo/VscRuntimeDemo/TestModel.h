//
//  TestModel.h
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef BOOL(^testPropertyBlock)(int test);
@interface TestModel : NSObject{
    NSString *testIvar1;
    NSArray *testIvar2;
    testPropertyBlock testIvar3;
    long long testIvar4;
    NSInteger testIvar5;
    char *testIvar6;
    unsigned char *testIvar7;
    unsigned int testIvar8;
    unsigned long long testIvar9;
    NSUInteger testIvarA;
    SEL testIvarB;
    TestModel *testIvarC;
}
@property (nonatomic,copy,readonly) NSString *testProperty1;
@property (atomic,copy) NSArray *testProperty2;
@property (nonatomic,copy,getter=myGetter,setter=mySetter:) NSString *testProperty3;
@property (nonatomic,assign) int testProperty4;
@property (nonatomic,assign) NSInteger testProperty5;
@property (nonatomic,assign) float testProperty6;
@property (nonatomic,assign) CGFloat testProperty7;
@property (nonatomic,assign) double testProperty8;
@property (nonatomic,assign) char *testProperty9;
@property (nonatomic,strong) NSNumber *testPropertyA;
@property (atomic,assign) BOOL testPropertyB;
@property (atomic,assign) bool testPropertyC;
@property (nonatomic,assign) testPropertyBlock testPropertyD;
@property (nonatomic,copy) testPropertyBlock testPropertyE;

+(void)classMethod1;
+(void)classMethod2;
+(NSInteger)classMethod3;
+(void)classMethod4:(NSString *)method4;
+(float)classMethod5:(NSArray *)method5;
+(NSArray *)classMethod6:(int)method6;
+(unsigned int)classMethod7:(int)method7 method7:(NSString *)_method7;


-(void)instanceMethod1;
-(void)instanceMethod2;
-(NSString *)instanceMethod3;
-(NSString *)instanceMethod4;
@end
