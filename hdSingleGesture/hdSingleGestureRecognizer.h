//
//  hdSingleGestureRecognizer.h
//  hdSingleGesture
//
//  Created by zhumingke on 16/4/27.
//  Copyright © 2016年 zhumingke. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    panGesture,
    rotationGesture,
}typeOfGesture;
@interface hdSingleGestureRecognizer : UIGestureRecognizer
@property(nonatomic)BOOL isRotation;
@property(nonatomic)BOOL isPan;
@property(nonatomic)CGFloat rotation;
@property(nonatomic)CGFloat scale;
@end
