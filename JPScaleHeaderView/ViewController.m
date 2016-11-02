//
//  ViewController.m
//  JPScaleHeaderView
//
//  Created by 哇咔咔 on 2016/10/31.
//  Copyright © 2016年 itcast.com.cn. All rights reserved.
//

#import "ViewController.h"
#import "JPHeaderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)clickToPush:(id)sender {
    
    [self.navigationController setNavigationBarHidden:YES];
    JPHeaderViewController *vc = [[JPHeaderViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
