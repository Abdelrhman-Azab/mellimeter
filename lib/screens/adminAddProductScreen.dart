import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddProductScreen extends StatefulWidget {
  static const routeName = "/adminaddproductscreen";
  final int edit;
  final String id;
  final String editTitle;
  final int editPrice;
  final String editDescription;
  final String editCategory;
  final List editImageurl;
  AdminAddProductScreen(
      [this.edit,
      this.id,
      this.editTitle,
      this.editPrice,
      this.editDescription,
      this.editCategory,
      this.editImageurl]);

  @override
  _AdminAddProductScreenState createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  PickedFile _file1;
  PickedFile _file2;
  PickedFile _file3;
  String _file1DownloadLink;
  String _file2DownloadLink;
  String _file3DownloadLink;
  String _title;
  String _descreption;
  String _category;
  String _id;
  int _price;
  int _selectedRaido;
  bool _isloading = false;
  List<String> _imageur = [];
  final snackBar = SnackBar(content: Text('Please add an image'));
  static GlobalKey<FormState> _myformKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _category = "decoration";
    _selectedRaido = 1;
    super.initState();
  }

  void changeRaio(int value) {
    setState(() {
      _selectedRaido = value;
    });
  }

  bool trySubmit() {
    final _isValid = _myformKey.currentState.validate();
    if (_isValid) {
      _myformKey.currentState.save();
      return true;
    }
    return false;
  }

  String category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widget.edit == 1) {
      _title = widget.editTitle;
      _price = widget.editPrice;
      _descreption = widget.editDescription;
      _id = widget.id;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: widget.edit == 1 ? Text("Edit product") : Text("Add product"),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _myformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.05,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          initialValue: _title,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a title";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _title = newValue;
                          },
                          decoration: InputDecoration(labelText: "title"),
                        )),
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          initialValue:
                              widget.edit == 1 ? _price.toString() : "",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a price";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _price = int.parse(newValue);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(labelText: "price"),
                        )),
                    SizedBox(height: 10),
                    if (_file1 != null)
                      Container(
                        height: 200,
                        child: Image.file(
                          File(_file1.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    if (widget.edit != 1)
                      RaisedButton(
                        child: Text(
                          "image 1",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          _file1 = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        color: Colors.white,
                      ),
                    if (_file2 != null)
                      Container(
                        height: 200,
                        child: Image.file(
                          File(_file2.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    if (widget.edit != 1)
                      RaisedButton(
                        child: Text(
                          "image 2",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          _file2 = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        color: Colors.white,
                      ),
                    SizedBox(height: 10),
                    if (_file3 != null)
                      Container(
                        height: 200,
                        child: Image.file(
                          File(_file3.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    if (widget.edit != 1)
                      RaisedButton(
                        child: Text(
                          "image 3",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          _file3 = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        color: Colors.white,
                      ),
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: TextFormField(
                          initialValue: _descreption,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a descreption";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _descreption = newValue;
                          },
                          decoration: InputDecoration(labelText: "descreption"),
                        )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: _selectedRaido,
                            onChanged: (val) {
                              changeRaio(val);
                              _category = "decoration";
                              print(_category);
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Text("decoration")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: _selectedRaido,
                            onChanged: (val) {
                              changeRaio(val);
                              _category = "furniture";
                              print(_category);
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Text("furniture")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 3,
                            groupValue: _selectedRaido,
                            onChanged: (val) {
                              changeRaio(val);
                              _category = "tools";
                              print(_category);
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Text("tools")
                      ],
                    ),
                    FlatButton(
                      onPressed: () async {
                        trySubmit();
                        if (trySubmit()) {
                          setState(() {
                            _isloading = true;
                          });
                          if (widget.edit == 1) {
                            print(_category);
                            await updateProduct(_title, _descreption, _price,
                                _category, _scaffoldKey, _id);
                          } else {
                            await upLoadFile(_file1, _file2, _file3);

                            await addProduct(_title, _descreption, _price,
                                _imageur, _category, _scaffoldKey);
                            _imageur.clear();
                            _file1 = null;
                            _file2 = null;
                            _file3 = null;
                            _file1DownloadLink = "";
                            _file2DownloadLink = "";
                            _file3DownloadLink = "";
                          }

                          setState(() {
                            _isloading = false;
                          });
                        }
                      },
                      child: widget.edit == 1
                          ? Text("UPDATE")
                          : Text("Add product"),
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future upLoadFile(PickedFile file, PickedFile file2, PickedFile file3) async {
    if (file != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(file.path);
      UploadTask uploadTask = storageReference.putFile(File(file.path));
      await uploadTask.whenComplete(() async {
        _file1DownloadLink = await storageReference.getDownloadURL();
        _imageur.add(_file1DownloadLink);
      });
    }
    if (file2 != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(file2.path);
      UploadTask uploadTask = storageReference.putFile(File(file2.path));
      await uploadTask.whenComplete(() async {
        _file2DownloadLink = await storageReference.getDownloadURL();
        _imageur.add(_file2DownloadLink);
      });
    }
    if (file3 != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(file3.path);
      UploadTask uploadTask = storageReference.putFile(File(file3.path));
      await uploadTask.whenComplete(() async {
        _file3DownloadLink = await storageReference.getDownloadURL();
        _imageur.add(_file3DownloadLink);
      });
    }
  }
}

Future addProduct(String mytitle, String mydescreption, int myprice,
    List myimageurl, String mycategory, GlobalKey<ScaffoldState> key) async {
  if (myimageurl.isEmpty) {
    final snackBar = SnackBar(
      content: Text('Please add an image'),
      backgroundColor: Colors.red[400],
    );
    key.currentState.showSnackBar(snackBar);
    return;
  }
  FirebaseFirestore.instance.collection("products").add({
    "title": mytitle,
    "descreption": mydescreption,
    "price": myprice,
    "imageurl": myimageurl,
    "category": mycategory,
  }).then((value) => FirebaseFirestore.instance
      .collection("products")
      .doc(value.id)
      .update({"id": value.id}));
}

Future updateProduct(String mytitle, String mydescreption, int myprice,
    String mycategory, GlobalKey<ScaffoldState> key, String id) async {
  await FirebaseFirestore.instance.collection("products").doc(id).update({
    "title": mytitle,
    "descreption": mydescreption,
    "price": myprice,
    "category": mycategory,
  });
  print(myprice);
  print(mycategory);
}
