import 'dart:convert';

import 'package:bloc_validate_forms/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _url = 'https://flutter-8cdd6.firebaseio.com';

  Future<bool> createProduct(ProductoModel productoModel) async {
    final url = '$_url/productos.json';

    final response =
        await http.post(url, body: productoModelToJson(productoModel));

    final decodedData = json.decode(response.body);

    print(decodedData);
  }

  Future<List<ProductoModel>> loadProducts() async {
    final url = '$_url/productos.json';

    final response = await http.get(url);
    final List<ProductoModel> products = new List();

    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);

      prodTemp.id = id;

      products.add(prodTemp);
    });

    print(products);

    return products;
  }

  Future<int> deleteProduct(String id)async{
    final url = '$_url/productos/$id.json';
    final response = await http.delete(url);

    print(json.decode(response.body));

    return 1;
  }


  Future<bool> editProduct  (ProductoModel productoModel) async {
    final url = '$_url/productos/${productoModel.id}.json';

    final response =
    await http.put(url, body: productoModelToJson(productoModel));

    final decodedData = json.decode(response.body);

    print(decodedData);
  }


}
