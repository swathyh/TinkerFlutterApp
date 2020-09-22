import 'dart:convert';
import 'package:WallpaperApp/Model/WallpaperModel.dart';
import 'package:WallpaperApp/data/Data.dart';
import 'package:WallpaperApp/data/Data.dart';
import 'package:WallpaperApp/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String CategoryName;

  Category({@required this.CategoryName});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> photos = new List();

  getCategorieWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/search?query=${widget.CategoryName}&per_page=30&page=15",
        headers: {"Authorization": apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        WallpaperModel photosModel = new WallpaperModel();
        photosModel = WallpaperModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: WallpaperList(wallpapers: photos, context: context),
      ),
    );
  }
}
