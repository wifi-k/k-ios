//
//  SXHomeMainHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainHeaderView.h"
#import "SXImaginaryLineView.h"
#import "SXHomeMainGotoUserInfoButton.h"
#import "SXHomeMainSettingButton.h"
#import "SXHomeMainMemberButton.h"
#import "SXXiaoKiOptionResult.h"
#import "LMJScrollTextView2.h"

@interface SXHomeMainHeaderView ()<LMJScrollTextView2Delegate>
@property (weak, nonatomic) IBOutlet SXImaginaryLineView *horizonDivideView;
@property (weak, nonatomic) IBOutlet UIView *verticalDivideView;
@property (weak, nonatomic) IBOutlet UIImageView *topCardBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeL;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet SXHomeMainMemberButton *managerBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainMemberButton *inviteMemberBtn;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageL;
@property (weak, nonatomic) IBOutlet UIView *noticeBgView;
@property (nonatomic, weak) LMJScrollTextView2 *scrollTextView;

@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *parentControlBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *healthyModeBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *switchBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *wifiSettingBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@end

@implementation SXHomeMainHeaderView

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
    
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.topBgView.backgroundColor = [UIColor whiteColor];
    self.topBgView.layer.cornerRadius = 8;
    self.topBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.topBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.topBgView.layer.shadowOpacity = 0.5;
    self.topBgView.layer.shadowRadius = 5;
    
    [self.iconImageView roundViewWithRadius:25.0f borderColor:SXColorWhite borderWidth:1.0f];
    
    [self.topCardBgImageView roundViewWithRadius:8.0f];
    
    self.horizonDivideView.backgroundColor = SXColorClear;
    self.verticalDivideView.backgroundColor = SXColorTextDisabled;
    self.verticalDivideView.width = 0.5f;
    
    self.noticeBgView.backgroundColor = [UIColor colorWithColor:SXColorF1F5FF alpha:0.5];
    [self.noticeBgView roundViewWithRadius:8.0f];
    self.messageL.textColor = SXColor7383A2;
    self.messageL.text = @"";
    
    LMJScrollTextView2 *scrollTextView = [[LMJScrollTextView2 alloc] init];
    scrollTextView.delegate = self;
    scrollTextView.backgroundColor = [UIColor clearColor];
    scrollTextView.textColor = SXColor7383A2;
    scrollTextView.textFont = [UIFont systemFontOfSize:12.0f];
    scrollTextView.frame = self.messageL.bounds;
    [self.messageL addSubview:scrollTextView];
    self.scrollTextView = scrollTextView;
    [self.scrollTextView startScrollBottomToTopWithNoSpace];
    self.scrollTextView.textDataArr = @[@"测试数据001",@"测试数据002",@"测试数据sdfghgfdsadfgf003",@"sdfghgfdsadf测试数据gf005",@"sdfghgf测试数据dsadfgf006"];
    
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    //欢迎提示
    self.welcomeL.textColor = SXColorWhite;
    self.welcomeL.font = SXFontBold20;
    
    //状态标签
    [self.statusBtn roundViewWithRadius:10.0f borderColor:SXColorWhite borderWidth:0.5f];
    [self.statusBtn setTitle:@"状态" forState:UIControlStateNormal];
    
    //开启交互
    self.nameL.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNameLabel)];
    [self.nameL addGestureRecognizer:tap0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMessageBgView)];
    [self.noticeBgView addGestureRecognizer:tap];
    
    //添加标签
    UILabel *managerL = [[UILabel alloc] init];
    managerL.backgroundColor = SXColorEFB925;
    managerL.textColor = SXColorWhite;
    managerL.textAlignment = NSTextAlignmentCenter;
    managerL.font = SXFont10;
    managerL.text = @"管理员";
    [managerL roundViewWithRadius:10.0f];
    [self.managerBtn addSubview:managerL];
    [managerL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.centerX.mas_equalTo(self.managerBtn).mas_offset(25);
        make.centerY.mas_equalTo(self.managerBtn).mas_offset(-20);
    }];
}

- (void)setUpData{
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    self.nameL.text = model.name;
    switch (model.status.integerValue) {
        case 0:
            [self.statusBtn setTitle:@"离线" forState:UIControlStateNormal];
            break;
        case 1:
            [self.statusBtn setTitle:@"在线" forState:UIControlStateNormal];
            break;
        case 2:
            [self.statusBtn setTitle:@"警告" forState:UIControlStateNormal];
            break;
        case 3:
            [self.statusBtn setTitle:@"错误" forState:UIControlStateNormal];
            break;
        default:
            [self.statusBtn setTitle:@"状态" forState:UIControlStateNormal];
            break;
    }
}

#pragma mark -事件监听-
- (void)clickNameLabel{
    if (self.clickNameLabelBlock) {
        self.clickNameLabelBlock();
    }
}

- (void)clickMessageBgView{
    if (self.clickMessageBgViewBlock) {
        self.clickMessageBgViewBlock();
    }
}

- (IBAction)clickManagerBtn:(SXHomeMainMemberButton *)sender {
    if (self.clickMangerBtnBlock) {
        self.clickMangerBtnBlock();
    }
}

- (IBAction)shareBtn:(SXHomeMainMemberButton *)sender {
    if (self.clickShareBtnBlock) {
        self.clickShareBtnBlock();
    }
}

- (IBAction)clickUserInfoBtn:(SXHomeMainGotoUserInfoButton *)sender {
    if (self.clickUserInfoBtnBlock) {
        self.clickUserInfoBtnBlock();
    }
}

- (IBAction)clickSettingBtn:(SXHomeMainSettingButton *)sender {
    if (self.clickSettingBtnBlock) {
        self.clickSettingBtnBlock(sender.tag);
    }
}

#pragma mark -LMJScrollTextView2Delegate-
- (void)scrollTextView2:(LMJScrollTextView2 *)scrollTextView currentTextIndex:(NSInteger)index{
    //    DLog(@"当前是信息%ld",index);
}

- (void)setUpMsgArray:(NSArray *)msgArray{
    self.scrollTextView.textDataArr = msgArray;
}

@end
