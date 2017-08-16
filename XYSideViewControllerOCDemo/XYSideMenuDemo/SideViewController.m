//
//  SideViewController.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "SideViewController.h"
#import "OtherViewController.h"
#import "XYSideViewController.h"
#import "UIViewController+XYSideCategory.h"

@interface SideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation SideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageArray = @[@"02", @"04", @"07", @"05"];
    _titleArray = @[@"骑行", @"旅游", @"摄影", @"Steam"];
    
    [self setUpCustomViews];
}

- (void)setUpCustomViews
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"image.jpeg"];
    imageV.frame = self.view.bounds;
    imageV.alpha = 0.85;
    [self.view addSubview:imageV];
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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _titleArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _imageArray[indexPath.row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    otherVC.title = [NSString stringWithFormat:@"%@", _titleArray[indexPath.row]];
    [self XYSidePushViewController:otherVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    header.alpha = 1;
    
    UILabel *author = [[UILabel alloc] init];
    author.frame = CGRectMake(10, 30, 300, 100);
    author.font = [UIFont systemFontOfSize:20];
    author.textAlignment = NSTextAlignmentLeft;
    author.text = @"Author: FireHsia\nE-mail: firehsia1204@gmail.com\n欢迎邮件  欢迎Star";
    author.numberOfLines = 0;
    author.textColor = [UIColor whiteColor];
    author.backgroundColor = [UIColor clearColor];
    [header addSubview:author];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

#pragma mark ---- lazyLoad View
- (UITableView *)rootTableView
{
    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kScreenHeight = [UIScreen mainScreen].bounds.size.height;
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        _rootTableView.backgroundColor = [UIColor clearColor];
        _rootTableView.scrollEnabled = NO;
        [_rootTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _rootTableView;
}

@end
