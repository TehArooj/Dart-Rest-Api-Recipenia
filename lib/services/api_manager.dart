import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/constants/strings.dart';
import 'package:rest_api/models/recipeinfo.dart';

class API_Manager {
  Future<RecipeModel> getRecipe() async {
    var recipedatamodel;
    try {
      var client = http.Client();
      var url = Uri.parse(Strings.recipe_url);
      var response = await client.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
      if (response.statusCode == 200) {
        //status = "success";
        var jsonstring = response.body;
        var jsonMap = json.decode(jsonstring);
        recipedatamodel = RecipeModel.fromJson(jsonMap);
        print(recipedatamodel.hits);
      } else {
        //status = "fail";
      }
    } catch (exception) {
      //status = "fail";
      print(exception);
    }
    return recipedatamodel;
  }
}
