//
//  XTPanView.h
//  手势动
//
//  Created by 叶慧伟 on 16/4/20.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTPanViewDragDelegate <NSObject>

- (void)didDragLeft:(UIView *)panView;
- (void)didDragRight:(UIView *)panView;

@optional
- (void)dragging:(CGFloat)factor;
- (void)willBackCenter:(CGFloat)factor;

@end

@interface XTPanView : UIView

@property (nonatomic, weak)id<XTPanViewDragDelegate>delegate;

@end
