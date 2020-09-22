import 'package:WallpaperApp/Model/Categories_Model.dart';

String apiKey = "563492ad6f9170000100000147566873856a4fac965d5979e362b03d";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = new List();
  CategoriesModel categoriesModel = new CategoriesModel();

  //
  categoriesModel.ImageUrl =
      "https://images.pexels.com/photos/750818/pexels-photo-750818.jpeg?cs=srgb&dl=pexels-fox-750818.jpg&fm=jpg";
  categoriesModel.CategoryName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.ImageUrl =
      "https://images.pexels.com/photos/1134166/pexels-photo-1134166.jpeg?cs=srgb&dl=pexels-aleksandar-pasaric-1134166.jpg&fm=jpg";
  categoriesModel.CategoryName = "City";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.ImageUrl =
      "https://images.pexels.com/photos/445399/pexels-photo-445399.jpeg?cs=srgb&dl=pexels-avinash-patel-445399.jpg&fm=jpg";
  categoriesModel.CategoryName = "Automobile";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  //
  categoriesModel.ImageUrl =
      "https://images.pexels.com/photos/1318477/pexels-photo-1318477.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoriesModel.CategoryName = "Rain";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  return categories;
}
