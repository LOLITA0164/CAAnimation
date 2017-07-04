//
//  CASpringAnimationCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CASpringAnimationCtrl.h"

@interface CASpringAnimationCtrl ()

@property (strong,nonatomic) CALayer *layer;

@property (strong,nonatomic) CALayer *layer2;

@property (strong,nonatomic) CASpringAnimation *animation;

@property (strong,nonatomic) CASpringAnimation *animation2;

@end

@implementation CASpringAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}



-(CASpringAnimation *)animation{
    if (_animation==nil) {
        _animation = [CASpringAnimation animationWithKeyPath:@"position.y"];
        _animation.damping = 5;                 // 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        _animation.stiffness = 100;             // 刚度系数，刚度系数越大，形变产生的力就越大，运动越快
        _animation.mass = 1;                    // 质量，影响惯性、拉伸幅度
        _animation.initialVelocity = 0;         // 初始速率，动画视图的初始速度大小,区分正负
        _animation.duration = _animation.settlingDuration;  // 根据当前的动画参数估算弹簧动画到停止时的估算时间  结算时间
        _animation.fromValue = @(self.layer.position.y);
        _animation.toValue = @(self.layer.position.y+100);
        _animation.removedOnCompletion = NO;
        _animation.fillMode = kCAFillModeForwards;
    }
    return _animation;
}
-(CASpringAnimation *)animation2{
    if (_animation2==nil) {
        _animation2 = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
        _animation2.damping = 1;
        _animation2.duration = _animation2.settlingDuration;  // 根据当前的动画参数估算弹簧动画到停止时的估算时间  结算时间
        _animation2.toValue = @(2);
    }
    return _animation2;
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.layer addAnimation:self.animation forKey:@"position.y"];
    
    [self.layer2 addAnimation:self.animation2 forKey:@"transform.scale"];
    
}














-(void)initUI{
    
    [self.view.layer addSublayer:self.layer];
    
    [self.view.layer addSublayer:self.layer2];
    
}


-(CALayer *)layer{
    if (_layer==nil) {
        _layer = [CALayer layer];
        _layer.frame = CGRectMake(0, 0, 30, 30);
        _layer.cornerRadius = _layer.frame.size.height/2.0;
        _layer.masksToBounds = YES;
        _layer.backgroundColor = RandColor.CGColor;
        _layer.position = self.view.center;
    }
    return _layer;
}

-(CALayer *)layer2{
    if (_layer2==nil) {
        _layer2 = [CALayer layer];
        _layer2.frame = CGRectMake(self.view.centerX-30/2.0, 200, 30, 30);
        _layer2.cornerRadius = _layer.frame.size.height/2.0;
        _layer2.masksToBounds = YES;
        _layer2.backgroundColor = RandColor.CGColor;
    }
    return _layer2;
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
