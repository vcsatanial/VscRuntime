//
//  NSObject+VscRuntime.m
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "NSObject+VscRuntime.h"
#import <objc/runtime.h>

void vsc_exchangeIMP_class(Class exClass,SEL selector1,SEL selector2){
    if (!exClass) {
        DBLog(@"class不存在 无法交换方法",nil);
        return;
    }
    Method method1 = class_getClassMethod(exClass, selector1);
    Method method2 = class_getClassMethod(exClass, selector2);
    method_exchangeImplementations(method1, method2);
}
void vsc_exchangeIMP_instance(Class exClass,SEL selector1,SEL selector2){
    if (!exClass) {
        DBLog(@"class不存在 无法交换方法",nil);
        return;
    }
    Method method1 = class_getInstanceMethod(exClass, selector1);
    Method method2 = class_getInstanceMethod(exClass, selector2);
    method_exchangeImplementations(method1, method2);
}

@implementation NSObject (VscRuntime)
#pragma mark - 类方法
+(NSArray<VscRTModel *> *)vsc_showIvars{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    unsigned int count ;
    Ivar *ivars= class_copyIvarList([self class], &count);
    for (int index = 0; index < count ; index ++) {
        Ivar var = ivars[index];
        NSString *ivarName = @(ivar_getName(var));
        NSString *ivarType = @(ivar_getTypeEncoding(var));
        VscRTModel *model = [[VscRTModel alloc] init];
        model.modelName = ivarName;
        model.modelType = ivarType;
        [array addObject:model];
        DBLog(@"Ivar.Name = %@ \t Type = %@",ivarName,model.modelType,nil);
    }
    free(ivars);
    return [array copy];
}
+(NSArray<VscRTModel *> *)vsc_showProperies{
    NSMutableArray *showArray = [NSMutableArray arrayWithCapacity:0];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int index = 0; index < count ; index ++) {
        objc_property_t property = properties[index];
        NSString *propertyName = @(property_getName(property));
        unsigned int attributesCount ;
        objc_property_attribute_t *attributes = property_copyAttributeList(property, &attributesCount);
        NSDictionary *dictionary = [VscRTModel dictionaryFromAttribute:attributes count:attributesCount];
        VscRTModel *model = [[VscRTModel alloc] init];
        model.modelName = propertyName;
        model.modelType = dictionary[@"type"];
        model.dictionary = dictionary;
        DBLog(@"Property.Name = %@ \t Type = %@ \nothers = %@",propertyName,model.modelType,dictionary,nil);
        [showArray addObject:model];
    }
    free(properties);
    return [showArray copy];
}
+(NSArray<VscRTModel *> *)vsc_showClassMethods{
    NSMutableArray *showArray = [NSMutableArray arrayWithCapacity:0];
    unsigned int count;
    Method *methods = class_copyMethodList(objc_getMetaClass(class_getName([self class])), &count);
    for (int index = 0; index < count; index ++) {
        Method oneMethod = methods[index];
        SEL selector = method_getName(oneMethod);
        NSString *typeEncoding = @(method_getTypeEncoding(oneMethod));
        NSString *methodName = @(sel_getName(selector));
        
        DBLog(@"Method.Name = %@ \t TypeEncoing = %@",methodName,typeEncoding,nil);

        VscRTModel *model = [[VscRTModel alloc] init];
        model.modelName = methodName;
        model.modelType = [NSString stringWithFormat:@"Method %@",typeEncoding];
        [showArray addObject:model];
    }
    DBLog(@"%@",@"第一个字母表示返回值 数字表示offset :之后是参数 都会默认偏移8(待多次考证) offset之后是参数的类型 具体类型含义可以参考VscRTModel中的typeEncoding()方法",nil);
    free(methods);
    return [showArray copy];
}
+(NSArray<VscRTModel *> *)vsc_showInstanceMethods{
    NSMutableArray *showArray = [NSMutableArray arrayWithCapacity:0];
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int index = 0; index < count; index ++) {
        Method oneMethod = methods[index];
        SEL selector = method_getName(oneMethod);
        NSString *typeEncoding = @(method_getTypeEncoding(oneMethod));
        NSString *methodName = @(sel_getName(selector));
        
        DBLog(@"Method.Name = %@ \t TypeEncoing = %@",methodName,typeEncoding,nil);
        
        VscRTModel *model = [[VscRTModel alloc] init];
        model.modelName = methodName;
        model.modelType = [NSString stringWithFormat:@"Method %@",typeEncoding];
        [showArray addObject:model];
    }
    DBLog(@"%@",@"第一个字母表示返回值 数字表示offset :之后是参数 都会默认偏移8(待多次考证) offset之后是参数的类型 具体类型含义可以参考VscRTModel中的typeEncoding()方法",nil);
    free(methods);
    return [showArray copy];
}
#pragma mark 将Attribute属性转换成可读
+(NSDictionary *)dictionaryFromAttribute:(objc_property_attribute_t *)attributes count:(unsigned int)count{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *counting = @"assign";
    [dictionary setObject:counting forKey:@"counting"];
    [dictionary setObject:@"readwrite" forKey:@"readwrite"];
    [dictionary setObject:@"atomic" forKey:@"nonatomic/atomic"];
    [dictionary setObject:@"synthesize" forKey:@"synthesize/dynamic"];
    for (int index = 0; index < count; index ++) {
        objc_property_attribute_t attribute = attributes[index];
        if (charsIsEquil(attribute.name, "T")) {
            NSString *type = @(attribute.value);
            if (charsIsEquil(attribute.value, "i")) {
                type = @"int";
            }else if (charsIsEquil(attribute.value, "q")) {
                type = @"NSInteger";
            }else if (charsIsEquil(attribute.value, "d")) {
                type = @"double/CGFloat";
            }else if (charsIsEquil(attribute.value, "f")) {
                type = @"float";
            }else if (charsIsEquil(attribute.value, "*")) {
                type = @"char";
            }else if (charsIsEquil(attribute.value, "B")) {
                type = @"BOOL";
            }else if (charsIsEquil(attribute.value, "@?")) {
                type = @"block";
            }
            [dictionary setObject:type forKey:@"type"];
        }
        
        if (charsIsEquil(attribute.name, "N")) {
            [dictionary setObject:@"nonatomic" forKey:@"nonatomic/atomic"];
        }
        
        if (charsIsEquil(attribute.name, "&")) {
            counting = @"strong/retain";
        }else if (charsIsEquil(attribute.name, "W")) {
            counting = @"weak";
        }else if (charsIsEquil(attribute.name, "C")) {
            counting = @"copy";
        }
        
        [dictionary setObject:counting forKey:@"counting"];
        
        if (charsIsEquil(attribute.name, "R")) {
            [dictionary setObject:@"readonly" forKey:@"readwrite"];
        }
        
        if (charsIsEquil(attribute.name, "V")) {
            NSString *_ivar = attribute.value ? @(attribute.value) : @"null";
            [dictionary setObject:_ivar forKey:@"ivar"];
        }
        
        if (charsIsEquil(attribute.name, "D")) {
            [dictionary setObject:@"dynamic" forKey:@"synthesize/dynamic"];
        }
        
        if (charsIsEquil(attribute.name, "S")) {
            [dictionary setObject:@(attribute.value) forKey:@"setter"];
        }
        
        if (charsIsEquil(attribute.name, "G")) {
            [dictionary setObject:@(attribute.value) forKey:@"getter"];
        }
    }
    return [dictionary copy];
}
#pragma mark - 实例方法
-(NSArray<VscRTModel *> *)vsc_showIvars{
    return [[self class] vsc_showIvars];
}
-(NSArray<VscRTModel *> *)vsc_showProperies{
    return [[self class] vsc_showProperies];
}
-(NSArray<VscRTModel *> *)vsc_showClassMethods{
    return [[self class] vsc_showClassMethods];
}
-(NSArray<VscRTModel *> *)vsc_showInstanceMethods{
    return [[self class] vsc_showInstanceMethods];
}

@end
