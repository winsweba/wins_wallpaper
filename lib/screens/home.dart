import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wins_wallpaper/data/data.dart';
import 'package:wins_wallpaper/models/categories_model.dart';
import 'package:wins_wallpaper/models/wallpaper_model.dart';
import 'package:wins_wallpaper/screens/categories.dart';
import 'package:wins_wallpaper/screens/image_view.dart';
import 'package:wins_wallpaper/screens/search.dart';
import 'package:wins_wallpaper/widget/app_title.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

     List<CategoriesModel> categories = new List();
     List<WallpaperModel> wallpapers = new List();

     TextEditingController searchController = new TextEditingController();


  getTrendingWallpaper() async{
    var response = await http.get("https://api.pexels.com/v1/curated?per_page=50&page=1", 
    headers: {
      "Authorization" : apiKey,
    });
    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
     // print(element);
     WallpaperModel wallpaperModel = new WallpaperModel();
     wallpaperModel = WallpaperModel.fromMap(element);
     wallpapers.add(wallpaperModel);
    });

    setState(() {
      
    });

  }


  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Seaech or Wallpaper',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell( 
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute( 
                        builder: (context) => Search(searchQuery: searchController.text,)));
                    },
                    child: Container(child: Icon(Icons.search))),
                ],
              ),
            ),
            SizedBox(height: 16),

            Container(
              height: 80,
              child: ListView.builder( 
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoriesList(titel: categories[index].categoriesName, 
                  imageUrls: categories[index].imageUrl,);
                }),
            ),
            
           wallpaperList(wallpapers: wallpapers,context: context),
          ],
        ), ),
      ),
      
    );
  }
}

class CategoriesList extends StatelessWidget {
  final String imageUrls;
  final String titel;

  CategoriesList({@required this.imageUrls,@required this.titel});  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(
          categoriesName: titel.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4 ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16), 
              child: Image.network(imageUrls, height: 100, width: 100,fit: BoxFit.cover,)),
            Container(
              
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16), 
              ),
               height: 100, width: 100,
              alignment: Alignment.center ,
              child: Text(titel, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),),
              
            )
          ]
        )
      ),
    );
  }
}
