import 'dart:convert';

import 'package:WallpaperApp/Model/WallpaperModel.dart';
import 'package:WallpaperApp/data/Data.dart';
import 'package:WallpaperApp/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String query;
  Search({this.query});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController search = new TextEditingController();
  List<WallpaperModel> wallpapers = new List();

  getSeacrhWallpapers(String query) async {
    var responsed = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {"Authorization": apiKey});
    print(responsed);

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
    // TODO: implement initState
    getSeacrhWallpapers(widget.query);

    super.initState();

    search.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          getSeacrhWallpapers(search.text);
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              WallpaperList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
