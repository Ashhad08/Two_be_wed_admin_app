import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_be_wedd/utils/backend_configs.dart';

class SplashServices {
  static Future<bool> isAdminCreatedHall() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      return await BackEndConfigs.hallsCollectionsRef
          .where("adminId", isEqualTo: uid)
          .get()
          .then((value) => value.size != 0);
    } catch (e) {
      return false;
    }
  }
}
