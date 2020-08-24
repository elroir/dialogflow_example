import 'package:dialogflowexample/src/pages/home_page.dart';
import 'package:dialogflowexample/src/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => ProviderProvider(),
      child: MaterialApp(
        title: 'DialogFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.grey,
          primaryColor: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'home',
        routes: {
          'home'      : (context)  => HomePage(),
        },
      ),
    );
  }
}


