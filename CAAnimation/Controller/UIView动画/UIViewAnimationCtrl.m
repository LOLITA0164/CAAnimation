//
//  UIViewAnimationCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "UIViewAnimationCtrl.h"

@interface UIViewAnimationCtrl ()

@property (strong,nonatomic) UIView *testView;

@end

@implementation UIViewAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
}





#pragma mark - 设置view的动画
-(void)setViewAnimation{
    
    // 说明需要执行动画
    [UIView beginAnimations:nil context:nil];
    // 设置动画时间
    [UIView setAnimationDuration:1.0];
    // 设置速度
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // 设置动画代理
    [UIView setAnimationDelegate:self];
    // 动画开始执行某个函数
    [UIView setAnimationWillStartSelector:@selector(aniStart)];
    // 动画结束执行某个函数
    [UIView setAnimationDidStopSelector:@selector(aniStop)];
    // 设置动画延迟执行
//    [UIView setAnimationDelay:1.0];
    // 重复次数
//    [UIView setAnimationRepeatCount:2.0];
    // 是否反方向执行动画
//    [UIView setAnimationRepeatAutoreverses:YES];
    // 相关属性设置                                                       注：view的某种改变需要在开始和动画提交之间
    self.testView.transform = CGAffineTransformMakeScale(1.2, 2.0);
    // 提交动画
    [UIView commitAnimations];
    
}


-(void)aniStart{
    DLog(@"动画开始了");
}

-(void)aniStop{
    DLog(@"动画结束了");
    DLog(@"testView改变后的frame为：%@",NSStringFromCGRect(self.testView.frame));
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setViewAnimation];
    
}










-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.testView];
    
    
}


-(UIView *)testView{
    if (_testView==nil) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        _testView.backgroundColor = RandColor;
        _testView.center = self.view.center;
    }
    return _testView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
