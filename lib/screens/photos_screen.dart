import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_api/helpers/keystore_helper.dart';
import 'package:firebase_api/helpers/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File _imageFile;

  Future getImage(bool camera) async {
    File image;
    if (camera == true) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile = image;
      print('Image file $_imageFile');
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print('Upload successful!');
//      Scaffold.of(context).showSnackBar(
//        SnackBar(
//          content: Text('Photo has been chosen!'),
//        ),
//      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.camera_enhance),
              onPressed: () {
                getImage(true);
              }),
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () {
                getImage(false);
              }),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Choose Photo'),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Container(
                    height: 100.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ModalDrawerHandle(
                            handleColor: Colors.indigoAccent,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  getImage(true);
                                }),
                            IconButton(
                                icon: Icon(Icons.image),
                                onPressed: () {
                                  getImage(false);
                                }),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 400.0,
              child: (_imageFile != null)
                  ? Image.file(
                      _imageFile,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            RaisedButton(
                child: Text('Upload'),
                onPressed: () {
                  uploadImage(context);
                }),
            RaisedButton(
              child: Text('Print'),
              onPressed: () {
                print(readDataFromLocal('useremail'));
                print(readDataFromLocal('pwd'));

                print(readStorage('userstorage'));
                print(readStorage('pwdstorage'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
