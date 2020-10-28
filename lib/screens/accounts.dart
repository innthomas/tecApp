import 'package:f_db/models/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

import 'edit_account.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Account>>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Search people',
          onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<Account>(
              items: products,
              searchLabel: 'Search people',
              suggestion: Center(
                child: Text('Filter people by name, surname or age'),
              ),
              failure: Center(
                child: Text('No person found :('),
              ),
              filter: (person) => [
                person.name,
                person.price.toString(),
              ],
              builder: (person) => ListTile(
                title: Text(person.name),
                trailing: Text('${person.price} yo'),
              ),
            ),
          ),
          child: Icon(Icons.search),
        ),
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProduct()));
              },
            )
          ],
        ),
        body: (products != null)
            ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text(products[index].price.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProduct(products[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
