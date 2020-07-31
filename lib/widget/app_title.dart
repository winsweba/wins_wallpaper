import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wins_wallpaper/models/wallpaper_model.dart';
import 'package:wins_wallpaper/screens/image_view.dart';

Widget brandName(){
  return Row( 
    mainAxisAlignment: MainAxisAlignment.center,
   // mainAxisSize: MainAxisSize.min,
    children: <Widget>[ 
      Text('Wallpaper', style: TextStyle(color: Colors.black87,  ),),
      Text('Shows', style: TextStyle(color: Colors.lightBlue,  ),),
    ], 
    );
}

Widget wallpaperList({List<WallpaperModel> wallpapers , context}){
  return Container( 
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count( 
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0, 
      children: wallpapers.map((wallpaper){
        return GridTile( 
          child: GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(
                 builder: (context) => ImageView( 
                   imageUrl: wallpaper.src.portrait,)));
             },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect( 
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
              ),
            ),
          ) );
      }).toList(),
      ) ,);
}