import 'package:flutter/material.dart';
import 'package:rest_api/models/recipeinfo.dart';
import 'package:rest_api/pages/homepage.dart';

class FirebaseOneRecipe extends StatefulWidget {
  var recipe;
  FirebaseOneRecipe({Key? key, this.recipe}) : super(key: key);

  @override
  _FirebaseOneRecipeState createState() => _FirebaseOneRecipeState();
}

class _FirebaseOneRecipeState extends State<FirebaseOneRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipe Details"),
        ),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.network(
                widget.recipe["imageUrl"] ?? "",
                headers: const {
                  "Access-Control-Allow-Origin": "*",
                },
                height: 400,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      widget.recipe["recipeName"].toString(),
                      textScaleFactor: 2.5,
                    ),
                  ),
                  Container(
                    child: Text("Ingredients", textScaleFactor: 1.5),
                  ),
                  Container(
                    child: Text(widget.recipe["ingredientsList"]),
                  ),
                  Container(
                    child: Text("Calories", textScaleFactor: 1.5),
                  ),
                  Container(
                    child: Text(
                      widget.recipe["calories"],
                    ),
                  ),
                  Container(
                    child: Text("Health Labels", textScaleFactor: 1.5),
                  ),
                  Container(
                    child: Text(widget.recipe["healthLabels"]),
                  ),
                  Container(
                    child: Text("Diet Labels", textScaleFactor: 1.5),
                  ),
                  Container(
                    child: Text(widget.recipe["dietLabels"]),
                  ),
                  Container(
                    child: Text("Cautions", textScaleFactor: 1.5),
                  ),
                  Container(
                    child: Text(widget.recipe["cautions"]),
                  ),
                  Container(
                    child: Text("Total Weight", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe["totalWeight"] + " grms")),
                  Container(
                    child: Text("Total Time", textScaleFactor: 1.5),
                  ),
                  Container(
                      child:
                          Text(widget.recipe["totalTime"].toString() + " min")),
                ],
              ),
            ),
          ],
        )
        //Text(widget.recipe!.label.toString()),
        );
  }
}
