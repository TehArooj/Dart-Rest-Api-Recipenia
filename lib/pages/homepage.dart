import 'package:flutter/material.dart';
import 'package:rest_api/models/recipeinfo.dart';
import 'package:rest_api/services/api_manager.dart';
//import 'package:intl/intl.dart';  -- not used yet

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var apidata;
  void initState() {
    apidata = API_Manager().getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest API Code"),
      ),
      body: Container(/*
        child: FutureBuilder<RecipeModel>(
          future: apidata,
          builder: (context, snapshot) {
             if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.count,
                  itemBuilder: (context, index) {
                    var recipe = snapshot.data!.[index];
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Card(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(recipe.urlToImage,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Flexible(child: Text(recipe.links)),
                          Flexible(child: Text(recipe.recipe)),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            } 
          },
        ),*/
        ),
      );
  }
}