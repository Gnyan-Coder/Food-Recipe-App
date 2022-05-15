import 'package:flutter/material.dart';
import 'package:food_recipe_app/home.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 2000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>Home()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.cyan,
      body: Center(
        child: Container(
          child: Image(
            image: AssetImage("images/chef.png"),
          )

        ),
      ),
    );
  }
}

