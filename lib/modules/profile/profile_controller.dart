import 'package:get/get.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/storage_service.dart';

class ProfileController extends GetxController {
  final ad = AdService.to;
  String get joinDate => StorageService.joinDate;
}
