import 'package:hive/hive.dart';

part 'ad_record.g.dart';

@HiveType(typeId: 1)
class AdRecord extends HiveObject {
  @HiveField(0) late String   id;
  @HiveField(1) late String   adType;     // 'rewarded'|'splash'|'banner'|'interstitial'
  @HiveField(2) late int      coinsEarned;
  @HiveField(3) late DateTime watchedAt;

  String get adTypeLabel {
    switch (adType) {
      case 'rewarded':     return '激励视频';
      case 'splash':       return '开屏广告';
      case 'banner':       return 'Banner广告';
      case 'interstitial': return '插屏广告';
      default:             return '广告';
    }
  }

  String get adTypeEmoji {
    switch (adType) {
      case 'rewarded':     return '🎬';
      case 'splash':       return '🚀';
      case 'banner':       return '📢';
      case 'interstitial': return '📱';
      default:             return '📺';
    }
  }
}
