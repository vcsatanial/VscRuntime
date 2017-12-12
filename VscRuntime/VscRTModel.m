//
//  VscRTModel.m
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "VscRTModel.h"

void DBLog(NSString *format, ...){
#ifdef DEBUG
    if (showLog && format) {
        va_list argumentList;
        va_start(argumentList, format);
		NSString *finalFormat = [[NSString alloc] initWithFormat:format arguments:argumentList];
		NSLog(@"%@", finalFormat);
    }
#endif
}
BOOL charsIsEquil(const char *_char1,const char *_char2){
    if (strcmp(_char1, _char2) == 0) {
        return YES;
    }else{
        return NO;
    }
}
NSString *typeEncoding(const char *encoding){
    NSString *type ;
    if (charsIsEquil(encoding, "c")) {
    }else if (charsIsEquil(encoding, "i")) {
        type = @"int";
    }else if (charsIsEquil(encoding, "I")) {
        type = @"unsigned int";
    }else if (charsIsEquil(encoding, "s")) {
        type = @"short";
    }else if (charsIsEquil(encoding, "l")) {
        type = @"long";
    }else if (charsIsEquil(encoding, "q")) {
        type = @"long long/NSInteger";
    }else if (charsIsEquil(encoding, "C")) {
        type = @"unsigned char";
    }else if (charsIsEquil(encoding, "L")) {
        type = @"unsigned long";
    }else if (charsIsEquil(encoding, "Q")) {
        type = @"unsigned long long/NSUInteger";
    }else if (charsIsEquil(encoding, "B")) {
        type = @"BOOL";
    }else if (charsIsEquil(encoding, "v")) {
        type = @"void";
    }else if (charsIsEquil(encoding, "*")) {
        type = @"char *";
    }else if (charsIsEquil(encoding, "@")) {
        type = @"object(NSType or id)";
    }else if (charsIsEquil(encoding, ":")) {
        type = @"SEL";
    }else if (charsIsEquil(encoding, "#")) {
        type = @"Class";
    }else if (charsIsEquil(encoding, "?")) {
        type = @"unknown";
    }else if (charsIsEquil(encoding, "@?")) {
        type = @"block";
    }else if (charsIsEquil(encoding, "^type")) {
        type = @"pointer to type";
    }else if (charsIsEquil(encoding, "?")) {
        type = @"unknown";
    }else{
        type = [NSString stringWithCString:encoding encoding:NSUTF8StringEncoding];;
    }
    
    return type;
}

@implementation VscRTModel
@synthesize modelName;
@synthesize modelType = _modelType;
-(void)setModelType:(NSString *)modelType{
    _modelType = typeEncoding([modelType UTF8String]);
//    if ([modelType isEqualToString:@"i"]) {
//        _modelType = @"int";
//    }else if ([modelType isEqualToString:@"q"]) {
//        _modelType = @"NSInteger";
//    }else if ([modelType isEqualToString:@"d"]) {
//        _modelType = @"double/CGFloat";
//    }else if ([modelType isEqualToString:@"f"]) {
//        _modelType = @"float";
//    }else if ([modelType isEqualToString:@"*"]) {
//        _modelType = @"char";
//    }else{
//        _modelType = modelType;
//    }
}
-(NSString *)modelType{
    return _modelType;
}
+(void)closeLogForVscRuntime:(BOOL)close{
    showLog = !close;
}
-(NSString *)description{
    NSString *descriptionStr = [NSString stringWithFormat:@"VscRTModel\nmodelName = %@\nmodelType = %@",self.modelName,self.modelType];
    if (self.dictionary) {
        descriptionStr = [NSString stringWithFormat:@"VscRTModel\nmodelName = %@\nmodelType = %@\nmodelAbout = %@",self.modelName,self.modelType,self.dictionary];
    }
    return descriptionStr;
}
@end
