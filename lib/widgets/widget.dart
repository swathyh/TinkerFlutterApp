import 'package:WallpaperApp/Model/WallpaperModel.dart';
import 'package:WallpaperApp/views/image_view.dart';
import 'package:flutter/material.dart';

Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87),
      ),
      Text(
        "App",
        style: TextStyle(color: Colors.red),
      )
    ],
  );
}

Widget WallpaperList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    ImageUrl: wallpaper.src.portrait,
                  ),
                ));
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Container(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                wallpaper.src.portrait,
                fit: BoxFit.cover,
              ),
            )),
          ),
        ));
      }).toList(),
    ),
  );
}
