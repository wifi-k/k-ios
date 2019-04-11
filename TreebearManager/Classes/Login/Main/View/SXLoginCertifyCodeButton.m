//
//  SXLoginCertifyCodeButton.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginCertifyCodeButton.h"

@interface SXLoginCertifyCodeButton ()

@end

@implementation SXLoginCertifyCodeButton

- (void)addTarget:(id)target action:(SEL)action{
    [super addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.timeOut = 59;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = SXFont14;
    [self setTitleColor:SXColorBlue2 forState:UIControlStateNormal];
    [self setTitleColor:SXColor9B9B9B forState:UIControlStateHighlighted];
    [self setTitleColor:SXColor9B9B9B forState:UIControlStateDisabled];
    
    [self roundViewWithRadius:4.0f borderColor:SXColorDivideLine borderWidth:0.5f];
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (enabled) {
        [self borderColor:SXColorBlue2 borderWidth:1.0f];
    } else{
        [self borderColor:SXColorDivideLine borderWidth:0.5f];
    }
}

- (instancetype)init{
    
    if (self = [super init]) {
        self.timeOut = 59;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self setTitleColor:SXColorBlue2 forState:UIControlStateNormal];
        [self setTitleColor:SXColor9B9B9B forState:UIControlStateHighlighted];
        [self setTitleColor:SXColor9B9B9B forState:UIControlStateDisabled];
        
        [self roundViewWithRadius:4.0f borderColor:SXColorDivideLine borderWidth:0.5f];
    }
    return self;
}

- (void)start{
    
    WS(weakSelf);
    __block int timeout = self.timeOut; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置
                [weakSelf setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.enabled = YES;
                weakSelf.isCounting = NO;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示根据自己需求设置
                [weakSelf setTitle:[NSString stringWithFormat:@"%@S后重新获取",strTime] forState:UIControlStateNormal];
                weakSelf.enabled = NO;
                weakSelf.isCounting = YES;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


@end
