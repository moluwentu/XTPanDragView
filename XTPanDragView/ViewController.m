//
//  ViewController.m
//  XTPanDragView
//
//  Created by 叶慧伟 on 16/4/25.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "ViewController.h"
#import "XTPanView.h"
#import "Masonry.h"

#define secondViewTransForm 0.97

@interface ViewController ()<XTPanViewDragDelegate>

@property (nonatomic, strong)XTPanView *firstPanView;
@property (nonatomic, strong)XTPanView *secondPanView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatPanView];
    [self creatPanView];
    
    //    XTPanView *panView = [[XTPanView alloc]init];
    //    [self.view addSubview:panView];
    //
    //    panView.delegate = self;
    
    //    [panView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(self.view);
    //        make.height.equalTo(@300);
    //        make.width.equalTo(@300);
    //    }];
}

- (void)creatPanView{
    
    XTPanView *panView = [[XTPanView alloc]init];
    panView.delegate = self;
    
    if (!self.firstPanView) {
        self.firstPanView = panView;
        self.firstPanView.userInteractionEnabled = YES;
        [self.view addSubview:self.firstPanView];
    }else{
        if (self.secondPanView) {
            self.firstPanView = self.secondPanView;
            self.firstPanView.userInteractionEnabled = YES;
            self.secondPanView = panView;
        }
        
        self.secondPanView = panView;
        panView.transform = CGAffineTransformScale(CGAffineTransformIdentity, secondViewTransForm, secondViewTransForm);
        [self.view insertSubview:panView belowSubview:self.firstPanView];
    }
    
    [panView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@300);
        make.width.equalTo(@300);
    }];
}

- (void)didDragLeft:(UIView *)panView{
    [self creatPanView];
}

- (void)didDragRight:(UIView *)panView{
    [self creatPanView];
}

- (void)dragging:(CGFloat)factor{
    CGFloat scale = secondViewTransForm + (1 - secondViewTransForm) *factor;
    self.secondPanView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
}

- (void)willBackToCenter:(CGFloat)factor{
    [UIView animateWithDuration:0.3 animations:^{
        self.secondPanView.transform = CGAffineTransformScale(CGAffineTransformIdentity, secondViewTransForm, secondViewTransForm);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
