import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecApp/models/account.dart';
import '../providers/account_provider.dart';

class EditProduct extends StatefulWidget {
  final Account account;

  EditProduct([this.account]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.account == null) {
      //New Record
      nameController.text = "";
      priceController.text = "";
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<AccountProvider>(context, listen: false);
        productProvider.loadValues(Account());
      });
    } else {
      //Controller Update
      nameController.text = widget.account.name;
      priceController.text = widget.account.price.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<AccountProvider>(context, listen: false);
        productProvider.loadValues(widget.account);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AccountProvider>(context);

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
          title: Center(
              child: (widget.account != null)
                  ? Text("add transaction")
                  : Text('Add Account'))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Account Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'Deposit'),
              onChanged: (value) => productProvider.changePrice(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.saveAccount();
                Navigator.of(context).pop();
              },
            ),
            (widget.account != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {
                      productProvider.removeAccount(widget.account.accountId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
