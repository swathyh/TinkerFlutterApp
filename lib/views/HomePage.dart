import 'dart:convert';

import 'package:WallpaperApp/Model/Categories_Model.dart';
import 'package:WallpaperApp/Model/WallpaperModel.dart';
import 'package:WallpaperApp/data/Data.dart';
import 'package:WallpaperApp/views/Category.dart';
import 'package:WallpaperApp/views/Search.dart';
import 'package:WallpaperApp/views/image_view.dart';
import 'package:WallpaperApp/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController search = new TextEditingController();

  getTrendWallpapers() async {
    var responsed = await http.get(
        "https://www.pexels.com/api/?per_page=15&page=15",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> json = jsonDecode(responsed.body);
    json["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTrendWallpapers();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: search,
                        decoration: InputDecoration(
                            hintText: "Search your favourite",
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                        query: search.text,
                                      )));
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Made By ",
                        style: TextStyle(
                            color: Colors.black87, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Swathy",
                        style: TextStyle(
                            color: Colors.red, fontStyle: FontStyle.normal),
                      )
                    ],
                  )),
              SizedBox(
                height: 18,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryBox(
                        title: categories[index].CategoryName,
                        ImageUrl: categories[index].ImageUrl,
                      );
                    }),
              ),
              WallpaperList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String ImageUrl, title;
  CategoryBox({@required this.ImageUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Category(CategoryName: title.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  ImageUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
