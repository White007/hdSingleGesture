//
//  ViewController.m
//  hdSingleGesture
//
//  Created by zhumingke on 16/4/27.
//  Copyright © 2016年 zhumingke. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<RSPViewDelegate>
@property(nonatomic)RSPView *rview;
@property(nonatomic)hdSingleGestureRecognizer *rspGesture;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.rview = [[[NSBundle mainBundle]loadNibNamed:@"RSPView" owner:self options:nil]lastObject];
    _rview.frame = CGRectMake(50, 100, 310, 60);
    _rview.delegate = self;
    [self addGesture:_rview];
    [self.view addSubview:_rview];
    _rview.buttonShow = NO;
}
-(void)addGesture:(UIView *)view{
    self.rspGesture = [[hdSingleGestureRecognizer alloc]initWithTarget:self action:@selector(signalHandler:)];
    [view addGestureRecognizer:_rspGesture];
}
-(void)signalHandler:(hdSingleGestureRecognizer *)handler{
    handler.view.transform = CGAffineTransformRotate(handler.view.transform, handler.rotation);
    handler.rotation = 0;
    handler.view.transform = CGAffineTransformScale(handler.view.transform, handler.scale, handler.scale);
    [self resetButtonStates:handler.scale];
}
-(void)resetButtonStates:(CGFloat)scale{
    _rview.deleteBtn.transform = CGAffineTransformScale(_rview.deleteBtn.transform, 1.0f/scale, 1.0f/scale);
    _rview.rotationBtn.transform = CGAffineTransformScale(_rview.rotationBtn.transform, 1.0f/scale, 1.0f/scale);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    _rview.buttonShow = NO;
}
#pragma mark - delegate
-(void)showButton:(RSPView *)view{
    self.rview.buttonShow = NO;
    self.rview = view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
