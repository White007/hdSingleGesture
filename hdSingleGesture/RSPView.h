//
//  RSPView.h
//  hdSingleGesture
//
//  Created by zhumingke on 16/4/27.
//  Copyright © 2016年 zhumingke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSPView;
@protocol RSPViewDelegate 
-(void)showButton:(RSPView *)view;
@end
@interface RSPView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *rotationBtn;
@property(nonatomic)BOOL buttonShow;
@property(nonatomic,weak)id delegate;
@end
