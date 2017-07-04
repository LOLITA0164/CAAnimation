//
//  CATransitionCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CATransitionCtrl.h"

@interface CATransitionCtrl ()

{
    NSInteger currentIndex;
}

@property (strong,nonatomic) UIImageView *imageView;

@property (strong,nonatomic) NSArray *images;

@property (strong,nonatomic) NSArray *animations;

@end

@implementation CATransitionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
}





-(void)transitionAnimation:(NSInteger)direction{
    
    NSInteger type = getRandomNumberFromAtoB(0, self.animations.count-1);
    
    CATransition *transition = [CATransition new];
    // 设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = self.animations[type];
    
    BOOL nextPage = YES;
    
    // 设置子类型,方向
    if (direction == 1) {
        transition.subtype=kCATransitionFromRight;
        nextPage = YES;
    }else if (direction == 2) {
        transition.subtype=kCATransitionFromLeft;
        nextPage = NO;
    }else if (direction == 3) {
        transition.subtype=kCATransitionFromTop;
        nextPage = YES;
    }else{
        transition.subtype=kCATransitionFromBottom;
        nextPage = NO;
    }
    
    // 设置动画时间
    transition.duration = 1.0;
    
    // 添加新的视图
    if (nextPage) {
        currentIndex = (currentIndex+1)%self.images.count;
    }else{
        currentIndex = (currentIndex-1+self.images.count)%self.images.count;
    }
    
    
    NSString *imageName = self.images[currentIndex];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
    [self.imageView.layer addAnimation:transition forKey:@"KCATransitionAnimation"];
    
}





















-(void)initUI{
    
    [self.view addSubview:self.imageView];
    
    // 向左
    UISwipeGestureRecognizer *toLeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    toLeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:toLeftSwipe];
    // 向右
    UISwipeGestureRecognizer *toRightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    toRightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:toRightSwipe];
    // 向下
    UISwipeGestureRecognizer *toDownSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe:)];
    toDownSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:toDownSwipe];
    // 向上
    UISwipeGestureRecognizer *toUpSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipe:)];
    toUpSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:toUpSwipe];
    
}


-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:1];
}

-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:2];
}

-(void)upSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:3];
}

-(void)downSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:4];
}






-(NSArray *)animations{
    if (_animations == nil) {
        _animations = @[@"fade",                    // 淡出效果
                        @"movein",                  // 新视图移动到旧视图
                        @"push",                    // 新视图推出到旧视图
                        @"reveal",                  // 移开旧视图现实新视图
                        @"cube",                    // 立方体翻转效果
                        @"oglFlip",                 // 翻转效果
                        @"suckEffect",              // 吸收效果
                        @"rippleEffect",            // 水滴效果
                        @"pageCurl",                // 向上翻页
                        @"pageUnCurl",              // 向下翻页
                        @"cameralIrisHollowOpen",   // 摄像头打开
                        @"cameraIrisHollowClose",   // 摄像头关闭
                        ];
    }
    return _animations;
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
