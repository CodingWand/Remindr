import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebb/models/rappel.dart';

class DatabaseService {
  static String uid; //User ID
  final CollectionReference remCollection =
      Firestore.instance.collection("reminders");

  Map<String, dynamic> _remToDocument(Reminder R) {
    return {
      "uid": uid,
      "name": R.name,
      "remID": R.remID,
      "maxRem": R.maxRem,
      "nextRem": R.nextRem.toString()
    };
  }

  Future add(Reminder R) async {
    return await remCollection.add(_remToDocument(R));
  }

  List<Reminder> _snapshotToRappelList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Reminder(doc.data['name'], DateTime.parse(doc.data['nextRem']),
          doc.data['remID'], doc.data['maxRem'],
          docRef: doc.documentID);
    }).toList();
  }

  Stream<List<Reminder>> get reminders {
    return remCollection
        .where("uid", isEqualTo: uid)
        .orderBy("nextRem")
        .snapshots()
        .map((snapshot) => _snapshotToRappelList(snapshot));
  }

  Future deleteDocument(String docRef) async {
    return await remCollection.document(docRef).delete();
  }

  Future updateReminder(Reminder rem) async {
    return await remCollection
        .document(rem.docRef)
        .setData(_remToDocument(rem));
  }
}
