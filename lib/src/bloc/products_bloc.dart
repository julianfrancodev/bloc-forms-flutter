import 'dart:io';

import 'package:bloc_validate_forms/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bloc_validate_forms/src/models/product_model.dart';

class ProductsBloc {
  final _productsController = new BehaviorSubject<List<ProductoModel>>();
  final _loadController = new BehaviorSubject<bool>();
  final _productsProvider = new ProductsProvider();

  Stream<List<ProductoModel>> get productsStream => _productsController.stream;

  Stream<bool> get loading => _loadController.stream;

  void loadProducts() async {
    final products = await _productsProvider.loadProducts();
    _productsController.sink.add(products);
  }

  void addProduct(ProductoModel productoModel) async {
    _loadController.sink.add(true);
    await _productsProvider.createProduct(productoModel);
    _loadController.sink.add(false);
  }

  Future<String> uploadPhoto(File image) async {
    _loadController.sink.add(true);
    final photoUrl = await _productsProvider.uploadImage(image);
    _loadController.sink.add(false);

    return photoUrl;
  }

  void editProduct(ProductoModel productoModel) async {
    _loadController.sink.add(true);
    await _productsProvider.editProduct(productoModel);
    _loadController.sink.add(false);
  }

  void deleteProduct(String id) async {
    await _productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsController?.close();
    _loadController?.close();
  }
}
