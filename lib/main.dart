import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CameraHome(),
  ));
}

class CameraHome extends StatefulWidget {
  @override
  _CameraHomeState createState() => _CameraHomeState();
}

class _CameraHomeState extends State<CameraHome> {
  File image;
  String filename;
  Future getCamImage() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      image = _image;
      filename = basename(image.path);
    });
  }

  Future getGallImage() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = _image;
      filename = basename(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Stack(
            children: <Widget>[
              Image.asset(
        'images/pic.jpg',
        height: double.infinity,
        fit: BoxFit.cover,
              ),
              image == null
          ? Center(
              child: Text(
                'GetImage',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : imageArea(),
              Positioned(
          top: 500.0,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Expanded(
                        child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                    color: Colors.lightGreen,
                    onPressed: getCamImage,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Camera',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 60.0),
                  RaisedButton.icon(
                    color: Colors.lightBlueAccent,
                    onPressed: getGallImage,
                    icon: Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Gallery',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ))
            ],
          ),
      ),
    );
  }

  imageArea() {
    return Column(
      children: <Widget>[
        Container(
            height: 400.0,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.file(
                image,
                //fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height:30.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
                  child: RaisedButton(
            onPressed: submitImage,
            child: Text('Send'),
          ),
        )
      ],
    );
  }

  Future<String> submitImage() async {
    StorageReference reference = FirebaseStorage.instance.ref().child(filename);
    reference.putFile(image);
    return '';
  }
}
