import 'dart:html';

import 'package:flutter/material.dart';
import 'package:rest_api/models/recipeinfo.dart';
import 'package:rest_api/services/api_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
//import 'package:intl/intl.dart';  -- not used yet

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FloatingSearchBarController controller;
  var recipe_url =
      'https://api.edamam.com/api/recipes/v2?type=public&q=dynamic&app_id=63b50c42&app_key=23c73d1d368e716a3d8bb29c3cf2bf07';
  var apidata;
  void initState() {
    apidata = API_Manager().getRecipe(recipe_url);

    super.initState();
    controller = FloatingSearchBarController();
    dynamic filter2 = null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 72,
            child: FloatingSearchBar(
              hint: 'Search...',
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 800),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              axisAlignment: isPortrait ? 0.0 : -1.0,
              openAxisAlignment: 0.0,
              width: isPortrait ? 600 : 500,
              debounceDelay: const Duration(milliseconds: 500),
              onQueryChanged: (query) {
                setState(() {
                  recipe_url =
                      'https://api.edamam.com/api/recipes/v2?type=public&q=' +
                          query +
                          '&app_id=63b50c42&app_key=23c73d1d368e716a3d8bb29c3cf2bf07';
                  if (query != "") {
                    query = "dynamic";
                  }
                  apidata = API_Manager().getRecipe(recipe_url);
                });
              },
              transition: CircularFloatingSearchBarTransition(),
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(Icons.place),
                    onPressed: () {},
                  ),
                ),
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<RecipeModel?>(
              future: apidata,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.count,
                      itemBuilder: (context, index) {
                        var recipeCard = snapshot.data!.hits[index];
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Card(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                      recipeCard.recipe.image ?? "",
                                      headers: const {
                                        "Access-Control-Allow-Origin": "*",
                                      },
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Flexible(
                                  child:
                                      Text(recipeCard.recipe.label.toString())),
                              Flexible(
                                  child: Text(recipeCard.recipe.ingredientLines
                                      .toString())),
                            ],
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          //yeh child masla hai mtlb k i don't know how to integrate kuch b
        ],
      ),
    );
  }
}


//-------------------------------------------------------------------------------------------
//this the first running code that takes data from the API and shows it
/*
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
      body: Container(
        child: FutureBuilder<RecipeModel>(
          future: apidata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.count,
                  itemBuilder: (context, index) {
                    var recipeCard = snapshot.data!.hits[index];
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Card(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child:
                                  Image.network(recipeCard.recipe.image ?? "",
                                      headers: const {
                                        "Access-Control-Allow-Origin": "*",
                                      },
                                      fit: BoxFit.cover),
                            ),
                          ),
                          Flexible(
                              child: Text(recipeCard.recipe.label.toString())),
                          Flexible(
                              child: Text(recipeCard.recipe.ingredientLines
                                  .toString())),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
*/
