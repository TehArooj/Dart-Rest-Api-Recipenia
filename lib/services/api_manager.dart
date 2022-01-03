import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:rest_api/constants/strings.dart';
import 'package:rest_api/models/recipeinfo.dart';

class API_Manager {
  Future<RecipeModel> getRecipe() async {
    var recipedatamodel;
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse(Strings.recipe_url));
      if (response.statusCode == 200) {
        //status = "success";
        var jsonstring = response.body;
        var jsonMap = json.decode(jsonstring);
        recipedatamodel = RecipeModel.fromJson(jsonMap);
        print(recipedatamodel);
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
