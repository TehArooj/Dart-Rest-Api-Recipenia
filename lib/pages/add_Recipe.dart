import 'package:flutter/material.dart';
import 'package:rest_api/models/recipeinfo.dart';
import 'package:rest_api/pages/homepage.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:rest_api/models/userstate.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  Future<void> recipeSetup(
      String recipeName,
      String ingredientsList,
      String calories,
      String healthLabels,
      String dietLabels,
      String cautions,
      String weight,
      String time,
      String imageUrl,
      String userID) async {
    await Firebase.initializeApp();
    CollectionReference recipes =
        FirebaseFirestore.instance.collection("Recipes");
    // -- for firebase auth
    //FirebaseAuth auth = FirebaseAuth.instance;
    //String uid = auth.currentUser.uid.toString();
    recipes.add({
      'recipeName': recipeName,
      'ingredientsList': ingredientsList,
      'calories': calories,
      'healthLabels': healthLabels,
      'dietLabels': dietLabels,
      'cautions': cautions,
      'totalWeight': weight,
      'totalTime': time,
      'imageUrl': imageUrl,
      'uid': userID
    });
    return;
  }

  String? recName,
      ingList,
      hLabels,
      dLabels,
      cautions,
      cal,
      weight,
      time,
      _fileUrl,
      userID;

  File? _image;
  List<String> urlsList = [];

  Future chooseFile() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() => {_image = File(pickedFile!.path)});
  }

  Future saveRecipe(String uID) async {
    await Firebase.initializeApp();

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("img" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image!);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((url) {
        setState(() {
          _fileUrl = url;
          recipeSetup(recName!, ingList!, cal!, hLabels!, dLabels!, cautions!,
              weight!, time!, _fileUrl!, uID);
          Navigator.pop(context);
        });
      });
    });
  }

  //recipeSetup(recName!, ingList!, cal!, hLabels!, dLabels!,cautions!, weight!, time!, _fileUrl!,uID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Recipe name',
              ),
              onChanged: (text) {
                recName = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Recipe Ingredients list',
              ),
              onChanged: (text) {
                ingList = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Total Calories',
              ),
              onChanged: (text) {
                cal = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Health Labels',
              ),
              onChanged: (text) {
                hLabels = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Diet Labels',
              ),
              onChanged: (text) {
                dLabels = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Cautions',
              ),
              onChanged: (text) {
                cautions = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Total weight (grms)',
              ),
              onChanged: (text) {
                weight = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Total Time to cook (mins)',
              ),
              onChanged: (text) {
                time = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.purple,
                ),
                onPressed: chooseFile,
                child: const Text('Choose Image')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Consumer<UserModel>(builder: (context, user, child) {
              return TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.purple,
                ),
                child: const Text('Add'),
                onPressed: () {
                  userID = user.u?.email;
                  saveRecipe(userID!);
                  /*if (ingList == null) {
                    SweetAlert.show(context,
                        title: "Error",
                        subtitle: "Recipe can't be added please fill all data",
                        style: SweetAlertStyle.error);
                  } else {
                    saveRecipe(userID!);
                    SweetAlert.show(context,
                        title: "Success",
                        subtitle: "Recipe Added",
                        style: SweetAlertStyle.success);
                  }*/

                  /*Alert(
                    context: context,
                    title: "SUCCESS",
                    desc: "Recipe Added.",
                  ).show();*/
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
