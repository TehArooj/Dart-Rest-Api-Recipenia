import 'package:flutter/material.dart';
import 'package:rest_api/models/recipeinfo.dart';
import 'package:rest_api/pages/homepage.dart';

class OneRecipe extends StatefulWidget {
  final Recipe? recipe;
  const OneRecipe({Key? key, this.recipe}) : super(key: key);

  @override
  _OneRecipeState createState() => _OneRecipeState();
}

class _OneRecipeState extends State<OneRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe Details"),
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
                widget.recipe?.image ?? "",
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
                      widget.recipe!.label.toString(),
                      textScaleFactor: 2.5,
                    ),
                  ),
                  Container(
                    child: Text("Ingredients", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe!.ingredientLines
                          .toString()
                          .substring(
                              1,
                              widget.recipe!.ingredientLines.toString().length -
                                  1))),
                  Container(
                    child: Text("Calories", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe!.calories!.toInt().toString())),
                  Container(
                    child: Text("Health Labels", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe!.healthLabels
                          .toString()
                          .substring(
                              1,
                              widget.recipe!.healthLabels.toString().length -
                                  1))),
                  Container(
                    child: Text("Diet Labels", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe!.dietLabels
                          .toString()
                          .substring(
                              1,
                              widget.recipe!.dietLabels.toString().length -
                                  1))),
                  Container(
                    child: Text("Cautions", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe!.cautions.toString().substring(
                          1, widget.recipe!.cautions.toString().length - 1))),
                  Container(
                    child: Text("Total Weight", textScaleFactor: 1.5),
                  ),
                  Container(
                      child: Text(widget.recipe!.totalWeight
                              .toString()
                              .substring(
                                  1,
                                  widget.recipe!.totalWeight!
                                          .toInt()
                                          .toString()
                                          .length -
                                      1) +
                          " grms")),
                  Container(
                    child: Text("Total Time", textScaleFactor: 1.5),
                  ),
                  Container(
                      child:
                          Text(widget.recipe!.totalTime.toString() + " min")),
                ],
              ),
            ),
          ],
        )
        //Text(widget.recipe!.label.toString()),
        );
  }
}
