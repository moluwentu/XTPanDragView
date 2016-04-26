//
//  XTPanDragView.m
//  XTPanDragView
//
//  Created by 叶慧伟 on 16/4/26.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTPanDragView.h"
#import "XTPanView.h"
#import "Masonry.h"

#define secondViewTransForm 0.97

@interface XTPanDragView ()<XTPanViewDragDelegate>

@property (nonatomic, strong)XTPanView *firstPanView;
@property (nonatomic, strong)XTPanView *secondPanView;

@property (nonatomic, assign)CGSize dragSize;

@end

@implementation XTPanDragView

- (instancetype)initWithFrame:(CGRect)frame andDragViewSize:(CGSize)dragViewSize{
    if (self == [super initWithFrame:frame]) {
        
        self.dragSize = dragViewSize;
        
        [self creatPanView];
        [self creatPanView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self == [super initWithFrame:frame]) {
//        
//        [self creatPanView];
//        [self creatPanView];
//    }
//    return self;
//}

- (void)creatPanView{
    
    XTPanView *panView = [[XTPanView alloc]init];
    panView.delegate = self;
    
    if (!self.firstPanView) {
        self.firstPanView = panView;
        self.firstPanView.userInteractionEnabled = YES;
        [self addSubview:self.firstPanView];
    }else{
        if (self.secondPanView) {
            self.firstPanView = self.secondPanView;
            self.firstPanView.userInteractionEnabled = YES;
            self.secondPanView = panView;
        }
        
        self.secondPanView = panView;
        panView.transform = CGAffineTransformScale(CGAffineTransformIdentity, secondViewTransForm, secondViewTransForm);
        [self insertSubview:panView belowSubview:self.firstPanView];
    }
    
    [panView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(@(self.dragSize.height));
        make.width.equalTo(@(self.dragSize.width));
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
