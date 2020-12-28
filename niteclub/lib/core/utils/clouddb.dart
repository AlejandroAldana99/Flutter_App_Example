import 'package:cloud_firestore/cloud_firestore.dart';

class API {
  final Firestore cloud = Firestore.instance;
  final String path;
  CollectionReference ref;

  API(this.path) {
    ref = cloud.collection("customers").document("mexico")
        .collection("guanajuato").document("leon").collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

}