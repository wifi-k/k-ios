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
#import "SXPersonalInfoHeaderView.h"
#import "SXAlertControllerTool.h"
#import "SXPersonInfoModel.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <QiniuSDK.h>
#import "NSString+Hash.h"

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
    SXForgetConfirmController *forgetVC = [[SXForgetConfirmController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark -上传文件-
- (void)uploadImageData:(NSData *)data{
    WS(weakSelf);
    NSString *key = @"user_avatar";
    NSString *token = [SXPersonInfoModel sharedSXPersonInfoModel].qnToken;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    //NSData *data = [@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding];
    [upManager putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (info.ok) {
            DLog(@"请求成功");
            DLog(@"%@", info);
        } else {
            DLog(@"请求失败");
        }
        DLog(@"%@", resp);
//        NSString *hostStr = @"http://test.user.famwifi.com/api";
        NSString *hostStr2 = @"https://test.developer.qiniu.famwifi.com";
        NSString *urlStr = [hostStr2 stringByAppendingPathComponent:key];
        weakSelf.headerView.urlStr = urlStr;
        
        //回调
        if (weakSelf.updateAvatarImgBlock) {
            weakSelf.updateAvatarImgBlock();
        }
    } option:nil];
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
