import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_be_wedd/infrastructure/models/admin_model.dart';
import 'package:two_be_wedd/infrastructure/models/hall_model.dart';
import 'package:two_be_wedd/utils/backend_configs.dart';

class SystemServices {
  Stream<HallModel> fetchCurrentAdminHall() {
    return BackEndConfigs.hallsCollectionsRef
        .where("adminId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs
            .map((e) => HallModel.fromJson(e.data() as Map<String, dynamic>))
            .first);
  }

  Stream<AdminModel> fetchCurrentAdmin() {
    return BackEndConfigs.adminsCollectionsRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) =>
            AdminModel.fromJson(event.data() as Map<String, dynamic>));
  }
}
