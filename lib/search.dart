import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/recipe.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  String query;
  Search(this.query);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=12342395&app_key=99f6390f2f7d441c9052e80ff89353d8";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 400) {
      print("recipes not found");
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        data["hits"].forEach((element) {
          RecipeModel recipeModel = RecipeModel();
          recipeModel = RecipeModel.fromMap(element["recipe"]);
          recipeList.add(recipeModel);
          setState(() {
            isLoading = false;
          });
        });
      });
      recipeList.forEach((Recipe) {
        print(Recipe.applabel);
        print(Recipe.appcalories);
      });
    } else {
      print("connection failed");
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if((searchController.text).isEmpty)
                            {
                              print("Blank search");
                            }else{
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Search(searchController.text)));
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: Icon(
                                Icons.search,
                              )),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "Search Any Recipe Name",
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    child: isLoading
                        ? Center(
                              child:CircularProgressIndicator(),
                            )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Recipe(recipeList[index].appUrl)));
                                },
                                child: Card(
                                  margin: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          recipeList[index].appimageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                          ),
                                          child: Text(
                                            recipeList[index].applabel,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        width: 80,
                                        height: 40,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    size: 16,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                    recipeList[index]
                                                        .appcalories
                                                        .toString()
                                                        .substring(0, 6),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
