//
//  UIViewBlockAnimationCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "UIViewBlockAnimationCtrl.h"

@interface UIViewBlockAnimationCtrl ()

@property (strong,nonatomic) UIView *testView;

@end

@implementation UIViewBlockAnimationCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self initUI];
    
    
    
    
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    
    // 动画块
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.testView.transform = CGAffineTransformMakeScale(0.8, 1.5);
    } completion:^(BOOL finished) {
        DLog(@"frame动画--执行完毕!!");
        
        
        
        // 弹簧式动画块
        [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.testView.y = self.testView.y+100;
        } completion:^(BOOL finished) {
            DLog(@"弹簧式动画--执行完毕!!");
        }];
        
        
        
    }];
    
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



-(void)dealloc{
    DLog(@"%@释放了。。",[UIViewBlockAnimationCtrl class]);
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
