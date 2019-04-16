//
//  SXPersonalInfoController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPersonalInfoController.h"
#import "SXNickNameUpdateController.h"
#import "SXMobileUpdateController.h"
#import "SXForgetConfirmController.h"
#import "SXUpdatePwdConfirmController.h"
#import "SXPersonalInfoHeaderView.h"
#import "SXAlertControllerTool.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <QiniuSDK.h>
#import "NSString+Hash.h"
#import "SXMineNetTool.h"
#import "SXNotificationCenterTool.h"

@interface SXPersonalInfoController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, weak) SXPersonalInfoHeaderView *headerView;//头部视图
@end

@implementation SXPersonalInfoController

#pragma mark -getter方法-
- (UIImagePickerController *)imagePickerController{
    if (!_imagePickerController){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;//允许用户编辑照片
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//转场动画
        _imagePickerController = imagePickerController;
    }
    return _imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self.headerView setUpData];
    
    //添加通知
    [self addNotification];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"个人信息";
    
    //2.头部视图
    WS(weakSelf);
    SXPersonalInfoHeaderView *headerView = [SXPersonalInfoHeaderView headerView];
    headerView.clickIconBgViewBlock = ^{
        [weakSelf clickIconBgView];
    };
    headerView.clickNickNameBgViewBlock = ^{
        [weakSelf jumpToNickNameVC];
    };
    headerView.clickMobileBgViewBlock = ^{
        [weakSelf jumpToMobileVC];
    };
    headerView.clickPasswordBgViewBlock = ^{
        [weakSelf jumpToPasswordVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

#pragma mark -添加移除通知-
- (void)addNotification{
    [SXNotificationCenterTool addObserverUdpateNickNameSuccess:self selector:@selector(udpateUserInfoSuccess)];
    [SXNotificationCenterTool addObserverUpdateMobileSuccess:self selector:@selector(udpateUserInfoSuccess)];
}

- (void)dealloc{
    [SXNotificationCenterTool removeObserverAll:self];
}

- (void)udpateUserInfoSuccess{
    [self.headerView setUpData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -从相册获取图片或视频-
- (void)selectImageFromAlbum{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark -从摄像头获取图片或视频-
- (void)selectImageFromCamera{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
    // 相机类型（拍照、录像...）字符串需要做相应的类型转换
    //self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
    // 录制视频时长，默认10s
    //self.imagePickerController.videoMaximumDuration = 15;
    // 视频上传质量
    //self.imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    // 设置摄像头模式（拍照，录制视频）为录像模式
    //self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark -Event-
- (void)clickIconBgView{
    WS(weakSelf);
    [SXAlertControllerTool actionSheetWithTitle:@"提示" message:nil confirm:^(UIAlertAction * _Nonnull action) {
        DLog(@"action:%@",action.title);
        if ([action.title isEqualToString:@"拍照"]) {
            [weakSelf selectImageFromCamera];
        } else if([action.title isEqualToString:@"从相册选择"]){
            [weakSelf selectImageFromAlbum];
        }
    } cancel:^(UIAlertAction * _Nonnull action) {
        DLog(@"action:%@",action.title);
    }];
}

- (void)jumpToNickNameVC{
    SXNickNameUpdateController *nickVC = [[SXNickNameUpdateController alloc] init];
    [self.navigationController pushViewController:nickVC animated:YES];
}

- (void)jumpToMobileVC{
    SXMobileUpdateController *mobileVC = [[SXMobileUpdateController alloc] init];
    [self.navigationController pushViewController:mobileVC animated:YES];
}

- (void)jumpToPasswordVC{
    SXUpdatePwdConfirmController *udpatePwdVC = [[SXUpdatePwdConfirmController alloc] init];
    [self.navigationController pushViewController:udpatePwdVC animated:YES];
    
    SXForgetConfirmController *forgetVC = [[SXForgetConfirmController alloc] init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

#pragma mark -上传文件-
- (void)uploadImageData:(NSData *)data{
    WS(weakSelf);
    NSString *key = [NSString stringWithFormat:@"xiaoki%@",[self getNowTimeTimestamp]];
    NSString *token = SXPersonInfoModel.sharedSXPersonInfoModel.qnToken;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    //NSData *data = [@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding];
    [upManager putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (info.ok) {
            DLog(@"%@", info);
            [weakSelf userInfoSetDataWith:key];
        } else {
            [MBProgressHUD showFailWithMessage:@"上传失败!" toView:SXKeyWindow];
        }
        DLog(@"%@", resp);
    } option:nil];
}

#pragma mark -用户信息修改-
- (void)userInfoSetDataWith:(NSString *)key{
    if ([NSString isEmpty:key]) {
        [MBProgressHUD showFailWithMessage:@"获取Key值为空" toView:SXKeyWindow];
        return;
    }
    
    WS(weakSelf);
    SXMineUserInfoParam *param = [SXMineUserInfoParam param];
    param.avatar = key;
    [SXMineNetTool userInfoSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"OK！" toView:SXKeyWindow];
        //1.更新用户信息
        [weakSelf getUserInfoData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -获取用户信息-
- (void)getUserInfoData{
    WS(weakSelf);
    [SXMineNetTool userInfoGetextDataWithFilter:@1 Success:^(SXMineUserInfoResult *result) {
        DLog(@"result:%@",result);
        SXPersonInfoModel.sharedSXPersonInfoModel.result = result;
        //1.更换头像
        [weakSelf.headerView setUpData];
        //2.通知上级页面更换头像
        if (weakSelf.updateAvatarImgBlock) {
            weakSelf.updateAvatarImgBlock();
        }
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -UIImagePickerControllerDelegate-
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSLog(@"选择完毕-----info:%@", info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断资源类型
    
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        
        // 先把图片转成NSData
        //UIImage *image = info[UIImagePickerControllerEditedImage];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [self uploadImageData:imageData];
        
//        self.headerView.image = image;
        
        /*
         // 设置image的尺寸
         CGSize imageSize = CGSizeMake(1000, 1000);
         //对图片大小进行压缩--
         image = [self imageWithImage:image scaledToSize:imageSize];
         
         UIImageOrientation *imageOrientation = image.imageOrientation;
         if (imageOrientation != UIImageOrientationUp) {
         // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转90度的现象。
         // 以下为调整图片角度的部分
         UIGraphicsBeginImageContext(image.size);
         [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
         image = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         // 调整图片角度完毕
         }
         */
        
        
        
        // 如果是图片
        //self.imageViewLogo.image = info[UIImagePickerControllerEditedImage];
        // 压缩图片
        //NSData *fileData = UIImageJPEGRepresentation(self.imageViewLogo.image, 1.0);
        // 保存图片至相册
        //UIImageWriteToSavedPhotosAlbum(self.imageViewLogo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }else{
        // 如果是视频
        [MBProgressHUD showFailWithMessage:@"暂时不支持视频文件上传哟!" toView:SXKeyWindow];
        
        /*
         NSURL *url = info[UIImagePickerControllerMediaURL];
         // 播放视频
         //_moviePlayer.contentURL = url;
         //[_moviePlayer play];
         // 保存视频至相册（异步线程）
         NSString *urlStr = [url path];
         
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
         UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
         }
         });
         NSData *videoData = [NSData dataWithContentsOfURL:url];
         //视频上传
         //[self uploadVideoWithData:videoData];
         */
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -图片保存完毕的回调-
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    
}

#pragma mark -视频保存完毕的回调-
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        DLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        DLog(@"视频保存成功!");
    }
}

@end
