//
//  VscRTModel.h
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>

static BOOL showLog = YES;
void DBLog(NSString *format, ...);
BOOL charsIsEquil(const char *_char1,const char *_char2);
NSString *typeEncoding(const char *encoding);

@interface VscRTModel : NSObject
@property (nonatomic,copy) NSString *modelName;
@property (nonatomic,copy) NSString *modelType;
@property (nonatomic,copy) NSDictionary *dictionary;
+(void)closeLogForVscRuntime:(BOOL)close;
@end
