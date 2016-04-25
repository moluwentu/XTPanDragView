//
//  XTPanView.m
//  手势动
//
//  Created by 叶慧伟 on 16/4/20.
//  Copyright © 2016年 叶慧伟. All rights reserved.
//

#import "XTPanView.h"

#define MAX_OVER_MARGIN 80

#define SCALE_STRENGTH 4
#define ROTATION_STRENGTH 320
#define ROTATION_MAX 1
#define ROTATION_ANGLE M_PI/8
#define SCALE_MAX .93

@interface XTPanView ()

@property (nonatomic, assign)CGFloat xFromCenter;
@property (nonatomic, assign)CGFloat yFromCenter;
@property (nonatomic, assign)CGPoint originalPoint;

@end

@implementation XTPanView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [self randomColor];
        self.userInteractionEnabled = NO;
        UIPanGestureRecognizer *panGrs = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesed:)];
        [self addGestureRecognizer:panGrs];
    }
    return self;
}

- (void)panGesed:(UIPanGestureRecognizer *)sender{

    self.xFromCenter = [sender translationInView:self].x;
    self.yFromCenter = [sender translationInView:self].y;
    
    NSLog(@"X:%f*******************Y:%f",self.xFromCenter,self.yFromCenter);
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            
            self.originalPoint = self.center;
            
            break;
        case UIGestureRecognizerStateChanged:
            
            //改变中心位置
            self.center = CGPointMake(self.xFromCenter + self.originalPoint.x, self.yFromCenter + self.originalPoint.y);
            //转转转！
            CGFloat rotationStrength = MIN(self.xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            CGFloat rotationAngel = (CGFloat)(ROTATION_ANGLE * rotationStrength);
            
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            // 缩放
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            self.transform = scaleTransform;
            
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(dragging:)]) {
                    [self.delegate dragging:MIN(1.0, fabs(self.xFromCenter) / MAX_OVER_MARGIN)];
                }                                   
            }
            
            break;
        case UIGestureRecognizerStateEnded:
            
            [self panned];
            
            break;
        default:
            break;
    }
}

- (void)panned{
    
    if (self.xFromCenter > MAX_OVER_MARGIN) {
        
        CGPoint finishPoint = CGPointMake(500, 2 * self.yFromCenter + self.originalPoint.y);
        
        [UIView animateWithDuration:0.3 animations:^{
            self.center = finishPoint;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(didDragRight:)]) {
                    [self.delegate didDragRight:self];
                }
            }
        }];
    }else if(self.xFromCenter < -MAX_OVER_MARGIN){
        
        CGPoint finishPoint = CGPointMake(-500, 2 * self.yFromCenter + self.originalPoint.y);
        
        [UIView animateWithDuration:0.3 animations:^{
            self.center = finishPoint;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(didDragLeft:)]) {
                    [self.delegate didDragLeft:self];
                }
            }
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.center = self.originalPoint;
            self.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(willBackCenter:)]) {
                    [self.delegate willBackCenter:MIN(1.0, fabs(self.xFromCenter) / MAX_OVER_MARGIN)];
                }
            }
        }];
        
    }
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
