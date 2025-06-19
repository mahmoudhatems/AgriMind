import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';

abstract class GreenhouseRepo {
  Future<GreenhouseEntity> fetchGreenhouseData();
  Future<void> updateFan(bool isOn);
  Future<void> updatePump(bool isOn);

  // ❌ تم حذف updateLight لأنه لم يعد مطلوباً
}
