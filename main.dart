import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Add.dart';

late double width;
late double height;
bool view =  false;
bool theme =  false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

AppBar appBar(BuildContext){
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 50,),
        Text("To_Do", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(width: 20,),
        Row(
          children: [
            Icon(view ? Icons.apps_sharp : Icons.list , color: Colors.black,),
            SizedBox(width: 10,),
            Icon(theme ? Icons.circle : Icons.nightlight_round , color: Colors.black,),
          ],
        ),
      ],
    ),
    toolbarHeight: 80,
    backgroundColor: Colors.green,
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.lightBlue,));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

   Firebase.initializeApp();

    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Container(
          width: width - 40,
          height: height - 100,
          child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing:  20,
            children: List.generate(10, (index) => Container(height: 50, width: 50, color: Colors.green,)),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context){return const read();}));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
