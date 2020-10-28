class Account {
  final String accountId;
  final String name;
  final double price;

  Account({this.accountId, this.price, this.name});

  Map<String, dynamic> toMap() {
    return {'accountId': accountId, 'name': name, 'price': price};
  }

  Account.fromFirestore(Map<String, dynamic> firestore)
      : accountId = firestore['accountId'],
        name = firestore['name'],
        price = firestore['price'];
}
