//
//  CABasicAnimationCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CABasicAnimationCtrl.h"

@interface CABasicAnimationCtrl ()<CAAnimationDelegate>
{
    NSInteger selectedIndex;    // 选择的动画index
}

@property (strong,nonatomic) CABasicAnimation *animation1, *animation2, *animation3, *animation4, *animation5;

@property (strong,nonatomic) UIView *testView;

@property (strong,nonatomic) CAShapeLayer *layer;

@property (strong,nonatomic) NSArray *animations;


@end

@implementation CABasicAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];

}


/*
 常用的KeyPath
 key                       说明                   使用样例
 transform.scale        比例转化                   @(0.5)
 transform.scale.x      宽的比例                   @(0.5)
 transform.scale.y      高的比例                   @(0.5)
 opacity                透明度                     @(0.5)
 cornerRadius           圆角的设置                  @(50)
 transform.rotation.x	围绕x轴旋转                 @(M_PI)
 transform.rotation.y	围绕y轴旋转                 @(M_PI)
 transform.rotation.z	围绕z轴旋转                 @(M_PI)
 strokeStart            结合CAShapeLayer使用        赋值多变
 strokeEnd              结合CAShapeLayer使用        赋值都变
 bounds                 大小，中心不变              [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
 position               位置(中心点的改变)           [NSValue valueWithCGPoint:CGPointMake(100, 100)];
 contents               内容，                     比如UIImageView的图片	imageAnima.toValue = (id)[UIImage imageNamed:@”imageName”].CGImage;
 */


// 缩放
-(CABasicAnimation *)animation1{
    if (_animation1==nil) {
        _animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _animation1.duration = 0.5f;
        _animation1.fromValue = @(1);
        _animation1.toValue = @(0.5);
        _animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  // 速度
        _animation1.beginTime = CACurrentMediaTime() + 0 ;   // 延迟
        _animation1.autoreverses = YES; // 动画结束时是否执行逆动画
        _animation1.repeatCount = HUGE_VALF;    // 无限大
        _animation1.removedOnCompletion = NO;
        _animation1.fillMode = kCAFillModeForwards;
    }
    return _animation1;
}
// 透明度
-(CABasicAnimation *)animation2{
    if (_animation2==nil) {
        _animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _animation2.duration = 1.0f;
        _animation2.beginTime = CACurrentMediaTime() + 0 ;   // 延迟
        _animation2.fromValue = @(1);
        _animation2.toValue = @(0.0);
        _animation2.autoreverses = YES; // 动画结束时是否执行逆动画
        _animation2.repeatCount = HUGE_VALF;    // 无限大
    }
    return _animation2;
}
// 旋转
-(CABasicAnimation *)animation3{
    if (_animation3==nil) {
        _animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        _animation3.duration = 1.0f;
        _animation3.toValue = @(M_PI);
        _animation3.beginTime = CACurrentMediaTime() + 0;   // 延迟
        _animation3.autoreverses = YES; // 动画结束时是否执行逆动画
        _animation3.repeatCount = HUGE_VALF;    // 无限大
    }
    return _animation3;
}
// 位置
-(CABasicAnimation *)animation4{
    if (_animation4==nil) {
        _animation4 = [CABasicAnimation animationWithKeyPath:@"position"];
        _animation4.duration = 1.0f;
        _animation4.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        _animation4.beginTime = CACurrentMediaTime() + 0 ;   // 延迟
        _animation4.autoreverses = YES; // 动画结束时是否执行逆动画
        _animation4.repeatCount = HUGE_VALF;    // 无限大
    }
    return _animation4;
}
// strokeStart
-(CABasicAnimation *)animation5{
    if (_animation5==nil) {
        _animation5 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation5.duration = 2.0f;
        _animation5.fromValue = @(0.0);
        _animation5.toValue = @(1.0);
//        _animation5.repeatCount = HUGE_VALF;
    }
    return _animation5;
}



#pragma mark - CAAnimation代理方法
//动画开始时
- (void)animationDidStart:(CAAnimation *)anim{
    DLog(@"开始了");
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //方法中的flag参数表明了动画是自然结束还是被打断,比如调用了removeAnimationForKey:方法或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES。
    DLog(@"%@",flag?@"自然结束":@"被人为结束");
    DLog(@"结束了");
}






















-(void)initUI{
    
    [self.view addSubview:self.testView];
    
    [self.view.layer addSublayer:self.layer];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 清除掉所有的动画
    [self.testView.layer removeAllAnimations];
    //    [self.testView.layer removeAnimationForKey:@""];  // 清除某一个动画
    
    selectedIndex = getRandomNumberFromAtoB(0, 4);
    CABasicAnimation *ani = self.animations[selectedIndex];
    ani.delegate = self;    // 在全局变量如下设置时会产生循环引用的情况
    [self.testView.layer addAnimation:ani forKey:@"animation"];
    
}


-(CAShapeLayer *)layer{
    if (_layer==nil) {
        _layer = [CAShapeLayer layer];
        _layer.lineWidth = 5;
        _layer.strokeColor = RandColor.CGColor;
        _layer.fillColor = [UIColor clearColor].CGColor;
        _layer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, (kScreenHeight-300)/2.0, kScreenWidth-10*2.0, 300)].CGPath;
        [_layer addAnimation:self.animation5 forKey:@"strokeEnd"];
    }
    return _layer;
}




-(NSArray *)animations{
    if (_animations==nil) {
        _animations = [NSArray arrayWithObjects:self.animation1,self.animation2,self.animation3,self.animation4,self.animation5, nil];
    }
    return _animations;
}



-(UIView *)testView{
    if (_testView==nil) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
        _testView.center = self.view.center;
        _testView.backgroundColor = RandColor;
    }
    return _testView;
}



-(void)dealloc
{
    DLog(@"%@释放了",[CABasicAnimationCtrl class]);
}



-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    CABasicAnimation *ani = self.animations[selectedIndex];
    ani.delegate = nil;
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
