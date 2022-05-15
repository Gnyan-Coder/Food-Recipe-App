class RecipeModel{
  String applabel;
  String appimageUrl;
  double appcalories;
  String appUrl;

  RecipeModel({this.applabel="LABEL",this.appimageUrl="APPIMAGEURL",this.appcalories=12.00,this.appUrl="URL"});

  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimageUrl: recipe["image"],
      appUrl: recipe["url"]
    );
  }
}