//
//  hdSingleGestureRecognizer.m
//  hdSingleGesture
//
//  Created by zhumingke on 16/4/27.
//  Copyright © 2016年 zhumingke. All rights reserved.
//

#import "hdSingleGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
@implementation hdSingleGestureRecognizer
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //判断是不是单手操作
    if ([[event touchesForGestureRecognizer:self]count] > 1) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
    }else{
        [self setState:UIGestureRecognizerStateChanged];
    }
    UITouch *touch = [touches anyObject];
    //是旋转状态
    if (self.view.tag == rotationGesture) {
        UIView *view = [self view];
        //当前view的位置
        CGPoint center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
        //获取当前手势位置
        CGPoint currentPoint = [touch locationInView:view];
        //获取之前手势位置
        CGPoint previousPoint = [touch previousLocationInView:view];
        //用tan反函数计算当前角度和手势作用之前角度
        CGFloat currentRotation = atan2f((currentPoint.y - center.y), (currentPoint.x - center.x));
        CGFloat previousRotation = atan2f((previousPoint.y - center.y), (previousPoint.x - center.x));
        //计算出手势前后旋转的角度
        self.rotation = currentRotation - previousRotation;
        //缩放
        [self viewScaleWithPre:previousPoint andCurrentPoint:currentPoint];
        
        return;
    }
    //拖拽状态
    //获取拖动的view所在的controller
    CGPoint panPreviousPoint = [touch previousLocationInView:[self getPresentedViewController].view];
    CGPoint panCurrentPoint = [touch locationInView:[self getPresentedViewController].view];
    [self viewPanWithPre:panPreviousPoint andCurrentPoint:panCurrentPoint];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStateChanged) {
        [self setState:UIGestureRecognizerStateEnded];
    }else {
        [self setState:UIGestureRecognizerStateFailed];
    }
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setState:UIGestureRecognizerStateFailed];
}
//缩放
-(void)viewScaleWithPre:(CGPoint)previousPoint andCurrentPoint:(CGPoint)currentPoint{
    UIView *view = [self view];
    CGPoint center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    
    //三角函数计算缩放的大小
    double previousSize = sqrt((previousPoint.x - center.x)*(previousPoint.x - center.x)+(previousPoint.y - center.y)*(previousPoint.y - center.y));
    double currentSize = sqrt((currentPoint.x - center.x)*(currentPoint.x - center.x)+(currentPoint.y - center.y)*(currentPoint.y - center.y));
    
    double scaleSize = previousSize/currentSize;
    self.scale = scaleSize;
}
//获取手势view的控制器
-(UIViewController *)getPresentedViewController{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *presentController = rootViewController;
    if (presentController.presentedViewController) {
        presentController = presentController.presentedViewController;
    }
    return presentController;
}
//拖拽
-(void)viewPanWithPre:(CGPoint)previousPoint andCurrentPoint:(CGPoint)currentPoint{
    //拖拽的时候，禁止缩放和旋转
    self.rotation = 0;
    self.scale = 1;
    //计算拖拽前后的位移差
    double panX = currentPoint.x - previousPoint.x;
    double panY = currentPoint.y - previousPoint.y;
    self.view.center = CGPointMake(self.view.center.x + panX, self.view.center.y + panY);
}

@end
