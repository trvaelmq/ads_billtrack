Pod::Spec.new do |s|
  s.name             = 'MangoAds'
  s.version          = '2.8.8'
  s.summary          = '芒果聚合广告 SDK (Mediatom) 本地包 + GDT 渠道'
  s.description      = 'MSaas 聚合主包 + GDT 联盟 SDK + SFAdGdtAdapter 桥接包，本地 vendored 引入'
  s.homepage         = 'https://www.mediatom.cn'
  s.license          = { :type => 'Commercial', :text => 'Commercial SDK' }
  s.author           = { 'Mediatom' => 'sdk@mediatom.cn' }
  s.source           = { :path => '.' }
  s.platform         = :ios, '12.0'
  s.static_framework = true

  s.vendored_frameworks = [
    'MSaas.xcframework',
    'SFAdGdtAdapter.xcframework',
    'GDTMobSDK.xcframework',
    'Tquic.xcframework',
  ]

  s.frameworks = %w[
    UIKit Foundation WebKit StoreKit MobileCoreServices MediaPlayer
    CoreMedia AVFoundation CoreLocation CoreTelephony SystemConfiguration
    AdSupport CoreMotion Security QuartzCore CoreGraphics SafariServices
    JavaScriptCore DeviceCheck AppTrackingTransparency
  ]
  s.libraries = %w[c++ resolv sqlite3 z xml2 iconv bz2]

  s.pod_target_xcconfig  = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
  s.user_target_xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
end
