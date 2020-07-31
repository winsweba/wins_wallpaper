import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';


class ImageView extends StatefulWidget {
  final String imageUrl;
  ImageView({this.imageUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.imageUrl,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <
              Widget>[
            GestureDetector(
              onTap: () {
                // ignore: unnecessary_statements
                _save;
              },
              child: Stack(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff1C1B1B).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(40),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60, width: 1),
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          Color(0x36ffffff),
                          Color(0x0fffffff),
                        ])),
                    child: Column(children: <Widget>[
                      Text(
                        "Set Wallpaper",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      Text(
                        "Image Will be save in gallery",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
          ]),
        ),
      ]),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      Map<PermissionGroup, PermissionStatus> permissions =
 
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    } else {
       PermissionStatus permission =  await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}
