//
//  SXMineHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineHeaderView.h"
#import "SXRootTool.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface SXMineHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *mobileL;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@end

@implementation SXMineHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//xib唤醒转代码
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColor2E2E2E;
    
    self.nameL.font = SXFontBold22;
    self.mobileL.textColor = SXColorWhite;
    
    //1.1添加点击手势
    self.mobileL.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMobile)];
    [self.mobileL addGestureRecognizer:tap];
    
    [self.iconBtn roundViewWithRadius:30.0f borderColor:SXColorWhite borderWidth:1.0f];
}

#pragma mark -setData-
- (void)setUpData{
    SXMineUserInfoModel *userInfo = SXPersonInfoModel.sharedSXPersonInfoModel.result.user;
    NSString *nameStr = @"";
    if ([NSString isNotEmpty:userInfo.mobile] && userInfo.mobile.length > 4) {
        NSRange range = NSMakeRange(userInfo.mobile.length-4, 4);
        NSString *subMobile = [userInfo.mobile substringWithRange:range];
        nameStr = [NSString isEmpty:userInfo.name] ? [NSString stringWithFormat:@"用户%@",subMobile] : userInfo.name;
    }
    self.nameL.text = nameStr;
    self.mobileL.text = userInfo.mobile;
    NSString *avatar = userInfo.avatar;
    NSURL *avatarUrl = [NSURL URLWithString:avatar];
    [self.iconBtn sd_setBackgroundImageWithURL:avatarUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"mine_xioaki_default2"] options:SDWebImageRetryFailed];
}

#pragma mark -Event-
- (void)clickMobile{
    if (self.clickMobileBlock) {
        self.clickMobileBlock();
    }
}

- (IBAction)clickIconBtn:(UIButton *)sender {
//    if (self.clickIconBtnBlock) {
//        self.clickIconBtnBlock();
//    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        DLog(@"photos->assets:",photos,assets);
    }];
    [[SXRootTool topViewController] presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
