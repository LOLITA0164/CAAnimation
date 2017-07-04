//
//  CAAnimationGroupCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CAAnimationGroupCtrl.h"

@interface CAAnimationGroupCtrl ()

@property (strong,nonatomic) CASpringAnimation *springAni;

@property (strong,nonatomic) CABasicAnimation *basicAniZ;

@property (strong,nonatomic) CAAnimationGroup *aniGroup;

@property (strong,nonatomic) UILabel *ballLabel;



@end

@implementation CAAnimationGroupCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];

}



-(CASpringAnimation *)springAni{
    if (_springAni==nil) {
        _springAni = [CASpringAnimation animationWithKeyPath:@"position.y"];
        _springAni.damping = 5;                 // 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        _springAni.stiffness = 100;             // 刚度系数，刚度系数越大，形变产生的力就越大，运动越快
        _springAni.mass = 1;                    // 质量，影响惯性、拉伸幅度
        _springAni.initialVelocity = 0;         // 初始速率，动画视图的初始速度大小,区分正负
        _springAni.duration = _springAni.settlingDuration;
        _springAni.fromValue = @(self.ballLabel.y);
        _springAni.toValue = @(kScreenHeight/2.0);
        _springAni.removedOnCompletion = NO;
        _springAni.fillMode = kCAFillModeForwards;
    }
    return _springAni;
}


-(CABasicAnimation *)basicAniZ{
    if (_basicAniZ==nil) {
        _basicAniZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _basicAniZ.duration = self.springAni.settlingDuration;
        _basicAniZ.toValue = @(M_PI*10.0);
        _basicAniZ.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    return _basicAniZ;
}



-(CAAnimationGroup *)aniGroup{
    if (_aniGroup==nil) {
        _aniGroup = [CAAnimationGroup animation];
        _aniGroup.animations = @[self.springAni,self.basicAniZ];
    }
    return _aniGroup;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    /*
     1、动画组中的动画不会被压缩，超出动画时长的部分将会被剪掉 
     2、动画组中的动画的delegate与removedOnCompletion属性将会被忽略 由于忽略了removedOnCompletion属性，动画结束layer会恢复到动画前的状态 
     3、animations（NSArray *）存放并发执行的所有动画数组元素为CAAnimation的子类
     */
    
//    [self.ballLabel.layer addAnimation:self.aniGroup forKey:@"ballDrop"];
    
    
    [self.ballLabel.layer addAnimation:self.basicAniZ forKey:@"basicAniZ"];
    [self.ballLabel.layer addAnimation:self.springAni forKey:@"springAni"];
    
}


















-(void)initUI{
    
    [self.view addSubview:self.ballLabel];
    
}


-(UILabel *)ballLabel{
    if (_ballLabel==nil) {
        _ballLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, 20, 20)];
        _ballLabel.centerX = self.view.centerX;
        _ballLabel.text = @"🏀";
        [_ballLabel sizeToFit];
    }
    return _ballLabel;
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
