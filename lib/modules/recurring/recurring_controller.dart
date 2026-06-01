import 'package:get/get.dart';
import '../../core/services/recurring_service.dart';
import '../../data/models/recurring_rule.dart';

class RecurringController extends GetxController {
  final service = RecurringService.to;

  List<RecurringRule> get rules => service.rules;

  void deleteRule(String id) => service.deleteRule(id);
}
