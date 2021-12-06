import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File _pickedImage) imagePickFn;
   const UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src)async{
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 70,maxHeight: 150);
    if (pickedImageFile != null){
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage);
     }
    else{
      print("no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget> [
        CircleAvatar(
          child: Text(
            "photo".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          radius: 40,
          backgroundColor: Colors.teal,
          backgroundImage: _pickedImage !=null? FileImage(_pickedImage) : null,
        ),
        SizedBox(height:10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
                onPressed:()=>_pickImage(ImageSource.camera),
                icon: Icon(Icons.photo_camera_outlined),
                label: Text('Add Image\nFrom Camera',textAlign: TextAlign.start,)
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
                onPressed:()=>_pickImage(ImageSource.gallery),
                icon: Icon(Icons.image_outlined),
                label: Text('Add Image\nFrom Gallery',textAlign: TextAlign.start,)
            ),
          ],
        ),
      ],
    );
  }
}
