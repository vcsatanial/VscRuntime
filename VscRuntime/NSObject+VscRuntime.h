//
//  NSObject+VscRuntime.h
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VscRTModel.h"

void vsc_exchangeIMP_class(Class exClass,SEL selector1,SEL selector2);
void vsc_exchangeIMP_instance(Class exClass,SEL selector1,SEL selector2);

@interface NSObject (VscRuntime)
#pragma mark - 类方法
+(NSArray <VscRTModel *> *)vsc_showIvars;
+(NSArray <VscRTModel *> *)vsc_showProperies;
+(NSArray <VscRTModel *> *)vsc_showInstanceMethods;
+(NSArray <VscRTModel *> *)vsc_showClassMethods;
#pragma mark - 实例方法
-(NSArray <VscRTModel *> *)vsc_showIvars;
-(NSArray <VscRTModel *> *)vsc_showProperies;
-(NSArray <VscRTModel *> *)vsc_showInstanceMethods;
-(NSArray <VscRTModel *> *)vsc_showClassMethods;
@end
