//
//  ViewController.m
//  VscRuntimeDemo
//
//  Created by VincentChou on 2017/6/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+VscRuntime.h"
#import "TestModel.h"

@interface ViewController (){
    TestModel *myModel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self showLabel];
//    [VscRTModel closeLogForVscRuntime:YES];
//    [TestModel vsc_showIvars];
//    [self showClass];
    myModel = [[TestModel alloc] init];
    [self showInstance];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)loadView{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.x += 20;
    frame.size.height -= 20;
    frame.origin.y += 10;
    frame.size.width -= 20;
    self.view = [[UIScrollView alloc] initWithFrame:frame];
}
-(void)showLabel{
    label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.numberOfLines = 0;
    label.text = @"";
    label.textColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label];
}
-(void)showClass{
//    self.array = [TestModel vsc_showIvars];
//    self.array = [TestModel vsc_showProperies];
//    self.array = [TestModel vsc_showClassMethods];
//    self.array = [TestModel vsc_showInstanceMethods];
    [TestModel classMethod1];
    [TestModel classMethod2];
    NSLog(@"change IMP");
    vsc_exchangeIMP_class([TestModel class], @selector(classMethod1), @selector(classMethod2));
    [TestModel classMethod1];
    [TestModel classMethod2];
}
-(void)showInstance{
//    self.array = [myModel vsc_showIvars];
//    self.array = [myModel vsc_showProperies];
//    self.array = [myModel vsc_showClassMethods];
//    self.array = [myModel vsc_showInstanceMethods];
    [myModel instanceMethod1];
    [myModel instanceMethod2];
    NSLog(@"change IMP");
    vsc_exchangeIMP_instance([myModel class], @selector(instanceMethod1), @selector(instanceMethod2));
    [myModel instanceMethod1];
    [myModel instanceMethod2];
}
-(void)setArray:(NSArray *)array{
    NSMutableString *showString = [[NSMutableString alloc] initWithCapacity:0];
    for (VscRTModel *model in array) {
        [showString appendFormat:@"%@ \t %@",model.modelName,model.modelType];
        if (model.dictionary) {
            NSDictionary *dic = model.dictionary;
            [showString appendFormat:@"%@\n",model.dictionary];
            [showString appendFormat:@"@property (%@, %@, %@",dic[@"nonatomic/atomic"],dic[@"counting"],dic[@"readwrite"]];
            if (dic[@"setter"]) {
                [showString appendFormat:@", setter=%@",dic[@"setter"]];
            }
            if (dic[@"getter"]) {
                [showString appendFormat:@", getter=%@",dic[@"getter"]];
            }
            [showString appendFormat:@") %@ (*)%@;",dic[@"type"],model.modelName];
            if ([dic[@"synthesize/dynamic"] isEqualToString:@"dynamic"]) {
                [showString appendFormat:@"\n@dynamic %@;",model.modelName];
            }else{
                if (dic[@"ivar"]) {
                    [showString appendFormat:@"\n@synthesize %@ = %@;",model.modelName,dic[@"ivar"]];
                }else{
                    [showString appendFormat:@"\n@synthesize %@;",model.modelName];
                }
            }
            [showString appendFormat:@"\n"];
        }
        [showString appendFormat:@"\n"];
    }
    label.text = [label.text stringByAppendingString:[showString copy]];
    CGSize size = CGSizeMake(self.view.frame.size.width - 20, MAXFLOAT);
    CGSize labelSize = [label sizeThatFits:size];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, labelSize.width, labelSize.height);
    ((UIScrollView *)self.view).contentSize = labelSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
