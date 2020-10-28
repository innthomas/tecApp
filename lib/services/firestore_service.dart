import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_db/models/account.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveAccount(Account account) {
    return _db
        .collection('accounts')
        .document(account.accountId)
        .setData(account.toMap());
  }

  Stream<List<Account>> getAccounts() {
    return _db.collection('accounts').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Account.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeAccount(String accountId) {
    return _db.collection('accounts').document(accountId).delete();
  }
}
