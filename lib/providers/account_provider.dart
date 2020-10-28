import 'package:flutter/material.dart';
import 'package:tecApp/models/account.dart';
import 'package:tecApp/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AccountProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _price;
  String _accountId;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get price => _price;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  loadValues(Account account) {
    _name = account.name;
    _price = account.price;
    _accountId = account.accountId;
  }

  saveAccount() {
    print(_accountId);
    if (_accountId == null) {
      var newAccount = Account(name: name, price: price, accountId: uuid.v4());
      firestoreService.saveAccount(newAccount);
    } else {
      //Update
      var updatedAccount =
          Account(name: name, price: _price, accountId: _accountId);
      firestoreService.saveAccount(updatedAccount);
    }
  }

  removeAccount(String accountId) {
    firestoreService.removeAccount(accountId);
  }
}
