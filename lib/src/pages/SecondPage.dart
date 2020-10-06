import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:bloc_validate_forms/src/models/product_model.dart';
import 'package:bloc_validate_forms/src/providers/products_provider.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: _renderList(),
      floatingActionButton: _renderFloatingButton(context),
    );
  }

  Widget _renderFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, '/product'),
    );
  }

  Widget _renderList() {
    return FutureBuilder(
      future: productsProvider.loadProducts(),
      builder: (context, snapshot) {
        final products = snapshot.data;

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _renderItem(context,products[i]),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _renderItem(BuildContext context,ProductoModel product) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
        productsProvider.deleteProduct(product.id);
      },
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text('${product.titulo} - ${product.valor}'),
        subtitle: Text(product.id),
        onTap: ()=> Navigator.pushNamed(context, '/product',arguments: product),
      ),
    );
  }
}
