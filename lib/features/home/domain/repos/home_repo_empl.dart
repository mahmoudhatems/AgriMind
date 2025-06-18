// lib/features/home/data/repos/home_repo_impl.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:happyfarm/features/home/data/models/home_model.dart';
import 'package:happyfarm/features/home/domain/entites/home_entity.dart';
import '../../domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final _ref = FirebaseDatabase.instance.ref("home");

  @override
  Future<HomeEntity> fetchHomeData() async {
    final snapshot = await _ref.get();
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return HomeModel.fromJson(data);
  }

  @override
  Future<void> toggleGate(bool isOpen) async {
    await _ref.update({'gate_status': isOpen});
  }
}
