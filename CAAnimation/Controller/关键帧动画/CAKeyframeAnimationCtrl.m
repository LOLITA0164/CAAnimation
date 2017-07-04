//
//  CAKeyframeAnimationCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CAKeyframeAnimationCtrl.h"

@interface CAKeyframeAnimationCtrl ()

@property (strong,nonatomic) UILabel *testLabel;

@property (strong,nonatomic) CALayer *testLayer;

@property (strong,nonatomic) UIBezierPath *path;

@property (strong,nonatomic) CAKeyframeAnimation *aniByPath;

@property (strong,nonatomic) CAKeyframeAnimation *aniByValues;



@end

@implementation CAKeyframeAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}



-(CAKeyframeAnimation *)aniByPath{
    if (_aniByPath==nil) {
        _aniByPath = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        _aniByPath.duration = 3.0f;
        _aniByPath.path = self.path.CGPath;
//        _aniByPath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _aniByPath.calculationMode = kCAAnimationLinear;        // 线性运动
        _aniByPath.autoreverses = NO;  // 反向运动
        _aniByPath.repeatCount = HUGE_VALF;
    }
    return _aniByPath;
}


-(CAKeyframeAnimation *)aniByValues{
    if (_aniByValues==nil) {
        _aniByValues = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        _aniByValues.duration = 3.0f;
        _aniByValues.repeatCount = HUGE_VALF;
        // 设置关键帧位置
        _aniByValues.values = @[
                              [NSValue valueWithCGPoint:self.testLayer.position],
                              [NSValue valueWithCGPoint:CGPointMake(kScreenWidth-30, self.testLayer.frame.origin.y)],
                              [NSValue valueWithCGPoint:CGPointMake(kScreenWidth-30, self.testLayer.frame.origin.y+100)],
                              [NSValue valueWithCGPoint:CGPointMake(30, self.testLayer.frame.origin.y+100)],
                              [NSValue valueWithCGPoint:self.testLayer.position],
                              ];
        _aniByValues.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
                                         ];
        _aniByValues.calculationMode = kCAAnimationLinear;
    }
    return _aniByValues;
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.testLabel.layer addAnimation:self.aniByPath forKey:@"position1"];
    
    [self.testLayer addAnimation:self.aniByValues forKey:@"position2"];
    
}
















-(void)initUI{
    
    [self.view addSubview:self.testLabel];
    
    [self.view.layer addSublayer:self.testLayer];
 
}



-(UIBezierPath *)path{
    if (_path==nil) {
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:self.testLabel.layer.position];
        [_path addLineToPoint:CGPointMake(self.view.viewWidth-20, self.view.middleY-100)];
        [_path addLineToPoint:CGPointMake(self.view.viewWidth-20, self.view.middleY+100)];
        [_path addLineToPoint:CGPointMake(20, self.view.middleY+100)];
        [_path addLineToPoint:CGPointMake(20, self.view.middleY-100)];
        [_path closePath];
    }
    return _path;
}



-(UILabel *)testLabel{
    if (_testLabel==nil) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        _testLabel.center = self.view.center;
        _testLabel.text = @"🚲";
        [_testLabel sizeToFit];
    }
    return _testLabel;
}

-(CALayer *)testLayer{
    if (_testLayer==nil) {
        _testLayer = [CALayer layer];
        _testLayer.frame =  CGRectMake(15, 200, 30, 30);
        _testLayer.cornerRadius = _testLayer.frame.size.height/2.0;
        _testLayer.backgroundColor = RandColor.CGColor;
    }
    return _testLayer;
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
