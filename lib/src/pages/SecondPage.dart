import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:bloc_validate_forms/src/models/product_model.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);

    productsBloc.loadProducts();

    return Scaffold(
      body: _renderList(productsBloc),
      floatingActionButton: _renderFloatingButton(context),
    );
  }

  Widget _renderFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, '/product'),
    );
  }

  Widget _renderList(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder: (context, snapshot) {
        final products = snapshot.data;

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _renderItem(context, products[i],productsBloc),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _renderItem(BuildContext context, ProductoModel product, ProductsBloc productsBloc) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          productsBloc.deleteProduct(product.id);
        },
        background: Container(
          color: Colors.red,
        ),
        child: Card(
          child: Column(
            children: [
              (product.fotoUrl == null)
                  ? Image(
                      image: AssetImage('assets/images/no-image.png'),
                    )
                  : FadeInImage(
                      image: NetworkImage(product.fotoUrl),
                      placeholder: AssetImage('assets/images/jar-loading.gif'),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${product.titulo} - ${product.valor}'),
                subtitle: Text(product.id),
                onTap: () => Navigator.pushNamed(context, '/product',
                    arguments: product),
              ),
            ],
          ),
        ));
  }
}
