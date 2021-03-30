import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:buy_it/models/product.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:buy_it/services/store.dart';
import 'package:path_provider/path_provider.dart';


class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //static String id = 'AddProduct';
  String _name, _price, _description, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  String dropdownValue = 'chaud';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
            ),
            SizedBox(
              height: 10,
            ),
            // CustomTextField(
            //   onClick: (value) {
            //     _category = value;
            //   },
            //   hint: 'Product Category',
            // ),

            SizedBox(
              height: 20,
            ),
          Container(
            padding: EdgeInsets.only(left: 50,right:50),
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Catégory',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['chaud', 'froid', 'sucré', 'salé']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

            // ignore: deprecated_member_use
            RaisedButton(onPressed: () async {
              // ignore: deprecated_member_use
              var image = await ImagePicker.pickImage(source: ImageSource.gallery);
              var _storedImage = File(image.path);
              Directory appDir = await getApplicationDocumentsDirectory();
              final fileName = path.basename(image.path);
              final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
               _imageLocation=savedImage.path;
            },
              child:Text('Add Picture'),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();

                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pLocation: _imageLocation,
                      pCategory: _imageLocation));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }

}

