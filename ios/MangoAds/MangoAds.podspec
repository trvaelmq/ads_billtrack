Pod::Spec.new do |s|
  s.name             = 'MangoAds'
  s.version          = '2.8.8'
  s.summary          = '芒果聚合广告 SDK (Mediatom) 本地包 + 多联盟渠道'
  s.description      = 'MSaas 聚合主包 + 各联盟 SDK + SFAd*Adapter 桥接包，本地 vendored 引入。联盟：GDT/CSJ/KS/Baidu/Sigmob/Taku(TopOn)/MS(美数)/DM(多盟)/KDXF(讯飞)。'
  s.homepage         = 'https://www.mediatom.cn'
  s.license          = { :type => 'Commercial', :text => 'Commercial SDK' }
  s.author           = { 'Mediatom' => 'sdk@mediatom.cn' }
  s.source           = { :path => '.' }
  s.platform         = :ios, '12.0'
  s.static_framework = true

  s.vendored_frameworks = [
    # ── 聚合主包 ──
    'MSaas.xcframework',
    'Tquic.xcframework',
    # ── GDT 优量汇 ──
    'SFAdGdtAdapter.xcframework',
    'GDTMobSDK.xcframework',
    # ── CSJ 穿山甲 ──
    'SFAdCsjAdapter.xcframework',
    'BUAdSDK.xcframework',
    'CSJMediation.xcframework',
    # ── KS 快手 ──
    'SFAdKsAdapter.xcframework',
    'KSAdSDK.xcframework',
    # ── Baidu 百度(老式 fat .framework) ──
    'SFAdBaiduAdapter.xcframework',
    'BaiduMobAdSDK.framework',
    'BaiduMobAdToolsSDK.framework',
    # ── Sigmob ──
    'SFAdSigmobAdapter.xcframework',
    'WindFoundation.xcframework',
    'WindSDK.xcframework',
    # ── Taku(TopOn/AnyThink) ──
    'SFAdTakuAdapter.xcframework',
    'AnyThinkSDK.xcframework',
    'AnyThinkBanner.xcframework',
    'AnyThinkInterstitial.xcframework',
    'AnyThinkMediaVideo.xcframework',
    'AnyThinkNative.xcframework',
    'AnyThinkRewardedVideo.xcframework',
    'AnyThinkSplash.xcframework',
    # ── MS 美数 ──
    'SFAdMsAdapter.xcframework',
    'MSAdMotion.xcframework',
    'MSAdSDK.xcframework',
    # ── DM 多盟 ──
    'SFAdDmAdapter.xcframework',
    'DMAdSDK.xcframework',
    # ── KDXF 科大讯飞(adapter 为 framework，底层为静态库见下) ──
    'SFAdKdxfAdapter.xcframework',
  ]

  # KDXF 讯飞底层是静态库 libIFLYAdLib.a（无 framework）
  s.vendored_libraries = ['libIFLYAdLib.a']

  # 联盟 SDK 依赖的开源三方库（多盟 DM 依赖 Protobuf/Masonry/SDWebImage，
  # 远端 pod 方式为传递依赖，本地 vendored 需显式声明，从 CocoaPods 拉取）
  s.dependency 'Protobuf'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'

  # 各联盟独立资源 bundle（framework 内置的 bundle 随框架，不列此处）
  s.resources = [
    'CSJAdSDK.bundle',        # 穿山甲
    'baidumobadsdk.bundle',   # 百度
    'AnyThinkSDK.bundle',     # Taku
    'MSAdSDK.bundle',         # 美数
    'DMAdSDK_Bundle.bundle',  # 多盟
    'IFLYPlayer.bundle',      # 讯飞
  ]

  # 系统库：文档「已整合所有联盟广告主所需依赖库」超集
  s.frameworks = %w[
    UIKit Foundation WebKit StoreKit MobileCoreServices MediaPlayer
    CoreMedia AVFoundation CoreLocation CoreTelephony SystemConfiguration
    AdSupport CoreMotion Security QuartzCore CoreGraphics SafariServices
    JavaScriptCore DeviceCheck AppTrackingTransparency
    MapKit AssetsLibrary MessageUI CoreML
    CoreHaptics Accelerate CoreImage Photos AudioToolbox VideoToolbox
    CoreVideo GLKit MetalKit Metal
  ]
  s.libraries = %w[c++ c++abi resolv sqlite3 z xml2 iconv bz2]

  s.pod_target_xcconfig  = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
  s.user_target_xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
end
