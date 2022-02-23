//import 'dart:html';

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/models/recipeinfo.dart';
import 'package:rest_api/models/userstate.dart';
import 'package:rest_api/pages/add_Recipe.dart';
import 'package:rest_api/pages/firebase_one_recipe.dart';
import 'package:rest_api/pages/login.dart';
import 'package:rest_api/pages/one_recipe.dart';
import 'package:rest_api/services/api_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:rest_api/constants/firebase-service.dart';
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
  var data = [];
  final List<String> recipes = [];
  void initState() {
    apidata = API_Manager().getRecipe(recipe_url);
    getRecipes();
    super.initState();
    controller = FloatingSearchBarController();
    dynamic filter2 = null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getRecipes() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance.collection('Recipes');
    QuerySnapshot querySnapshot = await firestore.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    log(allData.toString());
    setState(() {
      data = allData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddRecipe()),
            );
            FloatingActionButtonLocation.endFloat;
          },
        ),
        appBar: AppBar(
          title: const Text("Recipe App"),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.all_inbox_outlined),
                child: Text("All Recipes"),
              ),
              Tab(
                icon: Icon(Icons.my_library_books_outlined),
                child: Text("My Recipe"),
              ),
            ],
          ),
          // removes back button
          automaticallyImplyLeading: false,
          actions: [
            Consumer<UserModel>(builder: (context, user, child) {
              return IconButton(
                onPressed: () async {
                  await Firebase.initializeApp();
                  FirebaseService service = FirebaseService();
                  try {
                    await service.signOutFromGoogle();
                    user.setUser(null);
                    print("tintin Logging out");

                    Navigator.pushReplacementNamed(context, '/login');
                    //Navigator.push(context,MaterialPageRoute(builder: (context) => const Login()));
                  } catch (e) {
                    if (e is FirebaseAuthException) {
                      print("Hello Exception occured");
                    }
                  }
                },
                icon: const Icon(Icons.logout),
              );
            })
          ],
        ),
        body: TabBarView(
          children: [
            Column(
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
                          icon: const Icon(Icons.search),
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
                              if (index < 20) {
                                var recipeCard = snapshot.data!.hits?[index];
                                return TextButton(
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OneRecipe(
                                              recipe: recipeCard?.recipe)),
                                    )
                                  },
                                  child: Container(
                                    height: 100,
                                    margin: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Card(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.network(
                                                recipeCard?.recipe?.image ?? "",
                                                headers: const {
                                                  "Access-Control-Allow-Origin":
                                                      "*",
                                                },
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(recipeCard!
                                                .recipe!.label
                                                .toString())),
                                        Expanded(
                                            child: Text(
                                          recipeCard.recipe!.totalTime
                                                  .toString() +
                                              " min",
                                          textAlign: TextAlign.right,
                                        )),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: data
                      .map((e) => TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FirebaseOneRecipe(recipe: e)),
                              );
                            },
                            child: Container(
                              height: 100,
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Card(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(e["imageUrl"],
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(e["recipeName"].toString())),
                                  Expanded(
                                      child: Text(
                                    e["totalTime"].toString() + " min",
                                    textAlign: TextAlign.right,
                                  )),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
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
