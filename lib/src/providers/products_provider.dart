import 'dart:convert';
import 'dart:io';

import 'package:bloc_validate_forms/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<int> deleteProduct(String id) async {
    final url = '$_url/productos/$id.json';
    final response = await http.delete(url);

    print(json.decode(response.body));

    return 1;
  }

  Future<bool> editProduct(ProductoModel productoModel) async {
    final url = '$_url/productos/${productoModel.id}.json';

    final response =
        await http.put(url, body: productoModelToJson(productoModel));

    final decodedData = json.decode(response.body);

    print(decodedData);
  }

  Future<String> uploadImage(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dhnhdmi21/image/upload?upload_preset=elqrecou');
    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo mal en subir image');
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
