import 'package:cloud_firestore/cloud_firestore.dart';

class BackEndConfigs {
  static final CollectionReference adminsCollectionsRef =
      FirebaseFirestore.instance.collection('Admins');
  static final CollectionReference usersCollectionsRef =
      FirebaseFirestore.instance.collection('Users');
  static final CollectionReference hallsCollectionsRef =
      FirebaseFirestore.instance.collection('WeddingHalls');
  static final CollectionReference hallBookingsCollectionRef =
      FirebaseFirestore.instance.collection('HallBookings');
}
