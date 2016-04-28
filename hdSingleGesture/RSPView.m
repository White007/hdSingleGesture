//
//  RSPView.m
//  hdSingleGesture
//
//  Created by zhumingke on 16/4/27.
//  Copyright © 2016年 zhumingke. All rights reserved.
//

#import "RSPView.h"
#import "hdSingleGestureRecognizer.h"
@interface RSPView()<UITextViewDelegate>

@end
@implementation RSPView
-(void)setTextView:(UITextView *)textView{
    textView.delegate = self;
    textView.layer.borderWidth = 2.0;
    textView.layer.borderColor = [[UIColor blackColor]CGColor];
}
- (IBAction)deleteClick:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)rotationClick:(UIButton *)sender {
    sender.superview.tag = rotationGesture;
}
-(void)setButtonShow:(BOOL)buttonShow{
    if (buttonShow) {
        self.deleteBtn.hidden = NO;
        self.rotationBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
        self.rotationBtn.hidden = YES;
    }
}
#pragma mark - textView
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.delegate showButton:self];
    self.tag = panGesture;
    self.buttonShow = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0]} context:nil].size;
    CGRect frame = self.textView.frame;
    frame.size.height = textSize.height;
    self.textView.frame = frame;
}
@end
