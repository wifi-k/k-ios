platform :ios, '9.0'

target 'TreebearManager' do #工程名称
    pod 'AFNetworking', '~> 3.1.0'
    pod 'SDWebImage', '~> 4.1.0'
    pod 'FMDB', '~> 2.7.2'
    pod 'Masonry'
    pod 'MJExtension', '~> 3.0.13'
    pod 'JSONModel'
    pod 'MJRefresh', '~> 3.1.12'
    pod 'SAMKeychain'
    pod 'MBProgressHUD', '~> 1.0.0'
    pod 'SVProgressHUD','2.0.3'
    pod 'MarqueeLabel', '~> 2.2.0'
    pod 'Aspects', '~> 1.4.1'
    pod 'DZNEmptyDataSet'
    pod 'SDCycleScrollView'
    pod 'TZImagePickerController'
    pod 'CocoaAsyncSocket'
    pod 'KeyboardToolBar'
    pod 'RKNotificationHub'
    pod 'WYChart'
    pod 'Qiniu', '~> 7.1'
    pod 'YYModel'
    pod 'UMCCommon'
    pod 'UMCSecurityPlugins'
    pod 'UMCAnalytics'
    pod 'UMCPush'
    pod 'UMCErrorCatch'
    pod 'UMengUShare/Social/ReducedWeChat'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
            end
        end
    end
end
