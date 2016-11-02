//
//  JPHeaderViewController.m
//  JPScaleHeaderView
//
//  Created by 哇咔咔 on 2016/10/31.
//  Copyright © 2016年 itcast.com.cn. All rights reserved.
//


#define kHeaderViewWidth self.view.frame.size.width
#define kHeaderViewHeigth 200

#import "JPHeaderViewController.h"
#import "YYWebImage.h"

static NSString *cellID = @"cellID";

@interface JPHeaderViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *headerView;

@property (weak, nonatomic) UIImageView *imageV;

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation JPHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self perpareTableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self perpareHeaderView];
}

#pragma mark - 设置头视图
- (void)perpareHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kHeaderViewWidth, kHeaderViewHeigth)];
    headerView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:headerView];
    
    _headerView = headerView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/141205/193ZI234-2.jpg"];
    [imageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    _imageV = imageView;
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.clipsToBounds = YES;
    
    [self.headerView addSubview:_imageV];
}

#pragma mark - 设置tableView
- (void)perpareTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeigth, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kHeaderViewHeigth, 0, 0, 0);
    [self.view addSubview:tableView];
    
    _tableView = tableView;
}

#pragma mark - UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentInset.top + scrollView.contentOffset.y;
    CGRect rect = _headerView.frame;
    
    if (offset > 0) {
        CGFloat min = (kHeaderViewHeigth - 64);
         rect.origin.y = -MIN(min, offset);
        _headerView.frame = rect;
        
//        NSLog(@"%lf,%lf",offset, min);
        CGFloat progress = 1 - offset / min;
        _imageV.alpha = progress;
        
    }else {
        rect.size.height = kHeaderViewHeigth - offset;
        //  图片等比例填充的时候，图片方法，origin也会发生变化，所以要保证origin还在原来的位置
        rect.origin.y = 0;
        _headerView.frame = rect;
        
        _imageV.alpha = 1;
    }
    
    _imageV.frame = _headerView.bounds;
    
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
