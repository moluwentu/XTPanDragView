//
//  ViewController.m
//  XTPanDragView
//
//  Created by 叶慧伟 on 16/4/25.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "ViewController.h"
#import "XTPanDragView.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XTPanDragView *panDragView = [[XTPanDragView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) andDragViewSize:CGSizeMake(300, 300)];
    [self.view addSubview:panDragView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
