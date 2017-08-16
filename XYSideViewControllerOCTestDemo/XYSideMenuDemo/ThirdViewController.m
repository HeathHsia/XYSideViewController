//
//  ThirdViewController.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "ThirdViewController.h"
#import "OtherViewController.h"
#import "XYSideViewController.h"
#import "UIViewController+XYSideCategory.h"

@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地球";
    
    _imageArray = @[@"01", @"06", @"10", @"11", @"13"];
    _titleArray = @[@"地图", @"森林", @"赛场", @"游水", @"山间"];
    
    [self setUpCustomViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)setUpCustomViews
{
    [self.view addSubview:self.rootTableView];
}

#pragma mark --- tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _titleArray[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _imageArray[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    otherVC.title = [NSString stringWithFormat:@"%@", _titleArray[indexPath.row]];
    [self.navigationController pushViewController:otherVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark lazyLoadView
-(UITableView *)rootTableView
{
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _rootTableView.backgroundColor = [UIColor whiteColor];
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        [_rootTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
    }
    return _rootTableView;
}
@end
