//
//  UIViewTransitionAnimationCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "UIViewTransitionAnimationCtrl.h"

@interface UIViewTransitionAnimationCtrl ()

{
    NSInteger currentIndex;
}

@property (strong,nonatomic) UIImageView *imageView;

@property (strong,nonatomic) NSArray *images;

@end

@implementation UIViewTransitionAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
}





-(void)transitionAnimation:(BOOL)isNext{
    
    UIViewAnimationOptions option;
    if (isNext) {
        option = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionCrossDissolve;
    }else{
        option = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionCrossDissolve;
    }
    [UIView transitionWithView:self.imageView duration:1.0 options:option animations:^{
        self.imageView.image = [self getImage:isNext];
    } completion:^(BOOL finished) {
        DLog(@"完成更换");
    }];
}




-(UIImage*)getImage:(BOOL)isNext{
    if (isNext) {
        currentIndex = (currentIndex+1)%self.images.count;
    }else{
        currentIndex = (currentIndex-1+self.images.count)%self.images.count;
    }
    NSString *imageName = self.images[currentIndex];
    return [UIImage imageNamed:imageName];
}


















-(void)initUI{
    
    [self.view addSubview:self.imageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 向左
    UISwipeGestureRecognizer *toLeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    toLeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:toLeftSwipe];
    // 向右
    UISwipeGestureRecognizer *toRightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    toRightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:toRightSwipe];
    
}


-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}





-(NSArray *)images{
    if (_images==nil) {
        _images = @[@"0.jpg",
                    @"1.jpg",
                    @"2.jpg",
                    @"3.jpg",
                    @"4.jpg",
                    @"5.jpg"];
    }
    return _images;
}


-(UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
        _imageView.image = [UIImage imageNamed:self.images[currentIndex]];
    }
    return _imageView;
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
