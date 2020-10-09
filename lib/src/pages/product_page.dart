import 'dart:io';

import 'package:bloc_validate_forms/src/bloc/products_bloc.dart';
import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:bloc_validate_forms/src/models/product_model.dart';
import 'package:bloc_validate_forms/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _saving = false;

  ProductoModel producto = new ProductoModel();
  ProductsBloc productsBloc;

  File _image;
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {

    productsBloc = Provider.productsBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;


    if(prodData != null){
      producto = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: _selectPhoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _takePhoto),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _showPhoto(),
                _renderName(),
                _renderPrice(),
                _renderEnabled(),
                _renderButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderEnabled() {
    return SwitchListTile(
      value: producto.disponible,
      onChanged: (value) {
        producto.disponible = value;
        setState(() {

        });
      },
      title: Text('Disponible'),
    );
  }

  Widget _renderName() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return "Ingrese un nombre valido";
        } else {
          return null;
        }
      },
    );
  }

  Widget _renderPrice() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      onSaved: (value) => producto.valor = double.parse(value),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        if (isNumber(value)) {
          return null;
        } else {
          return "Ingrese un numero";
        }
      },
    );
  }

  Widget _renderButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textColor: Colors.white,
      label: Text('Guardar'),
      color: Colors.deepPurple,
      icon: Icon(Icons.save_alt),
      onPressed: (_saving)? null : _submit,
    );
  }

  void _submit() async{
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {_saving = true;});

    if(_image !=null){
     producto.fotoUrl = await productsBloc.uploadPhoto(_image);
    }

    if(producto.id == null){
      productsBloc.addProduct(producto);
    }else{
      productsBloc.editProduct(producto);
    }
    setState(() {_saving = false;});
    showSnack("Registro guardado");

    Navigator.pop(context);
  }

  void showSnack(String message){
    final snack = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snack);
  }
  Widget _showPhoto(){
    if(producto.fotoUrl != null){
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/images/jar-loading.gif'),
        height: 300,
        fit: BoxFit.contain,
      );
    }else{
      return Image(
        image: AssetImage(_image?.path ?? 'assets/images/no-image.png'),
        height: 300,
        fit: BoxFit.cover
      );
    }
  }


  _selectPhoto() async{
    final pickeFile = await picker.getImage(source: ImageSource.gallery);

    if(_image != null){
      producto.fotoUrl = null;
    }

    setState(() {
      if(pickeFile != null){
        _image = File(pickeFile.path);

      }else{
        print('No image selected');
      }
    });
  }

  _takePhoto() async{
    final pickeFile = await picker.getImage(source: ImageSource.camera);
    if(_image != null){
      producto.fotoUrl = null;
    }
    setState(() {
      if(pickeFile != null){
        _image = File(pickeFile.path);

      }else{
        print('No image selected');
      }
    });
  }
}
