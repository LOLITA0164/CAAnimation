//
//  IndexCtrl.m
//  CAAnimation
//
//  Created by LOLITA on 17/7/3.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "IndexCtrl.h"
#import "CABasicAnimationCtrl.h"            // 基础动画
#import "CAKeyframeAnimationCtrl.h"         // 关键帧动画
#import "CASpringAnimationCtrl.h"           // 弹簧动画
#import "CAAnimationGroupCtrl.h"            // 动画组
#import "CATransitionCtrl.h"                // 转场动画
#import "UIViewAnimationCtrl.h"             // UIView动画
#import "UIViewBlockAnimationCtrl.h"        // UIViewBlock块动画
#import "UIViewTransitionAnimationCtrl.h"   // 转场动画

@interface IndexCtrl () <UITableViewDelegate,UITableViewDataSource>


/**
 数据类
 */
@property (strong,nonatomic) NSArray *datas;

/**
 View类
 */
@property (strong,nonatomic) UITableView *table;

@end

@implementation IndexCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}



#pragma mark - 初始化UI
-(void)initUI
{
    self.title = @"动画篇";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.table];
    
}




-(UITableView *)table{
    if (_table==nil) {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableFooterView = [UIView new];
    }
    return _table;
}

#pragma mark - 列表代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = self.datas[section];
    return items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray *items = self.datas[indexPath.section];
    cell.textLabel.text = items[indexPath.row][0];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"CAAnimation核心动画",@"UIView动画"][section];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSArray *items = self.datas[indexPath.section];
    UIViewController *ctrl = [[[items objectAtIndex:indexPath.row] lastObject] new];
    [self.navigationController pushViewController:ctrl animated:YES];
}



-(NSArray *)datas{
    if (_datas==nil) {
        _datas = @[@[@[@"CABasicAnimation － 基础动画",[CABasicAnimationCtrl class]],
                     @[@"CAKeyframeAnimation － 关键帧动画",[CAKeyframeAnimationCtrl class]],
                     @[@"CASpringAnimation － 弹簧动画",[CASpringAnimationCtrl class]],
                     @[@"CAAnimationGroup － 动画组",[CAAnimationGroupCtrl class]],
                     @[@"CATransition － 转场动画",[CATransitionCtrl class]]],
                   @[@[@"View属性动画",[UIViewAnimationCtrl class]],
                     @[@"ViewBlock块动画",[UIViewBlockAnimationCtrl class]],
                     @[@"View转场动画",[UIViewTransitionAnimationCtrl class]]]
                   ];
    }
    return _datas;
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
