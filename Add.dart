import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class read extends StatefulWidget {
  const read({Key? key}) : super(key: key);

  @override
  _readState createState() => _readState();
}

class _readState extends State<read> {

  @override
  void initState() {
    Firebase.initializeApp().then((value) {
      setState(() {});
      activatelistner();
    });
    // TODO: implement initState
    super.initState();
  }

  Map<dynamic, dynamic> name = {};
  late int angle;
  final database = FirebaseDatabase.instance.ref();

  void activatelistner(){
    database.onValue.listen((event) {
      setState(() {
         name = event.snapshot.value as Map<dynamic, dynamic>;
         // if(name["player 1"]["angle"] == 17){angle = 10;}
         // else if(name["player 1"]["angle"] > 17){angle = 40;}
      });
    });
  }

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
            child: Text("Add To Do", style: TextStyle(fontSize: 20),),
          ),
          const Center(
            child: Text("Priority", style: TextStyle(fontSize: 10),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) => Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("priority" + index.toString()),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            )),
          ),
          Expanded(
            child: ListView(
              children: List.generate(2, (index) => Container(
                width: 300/411 * width,
                height: 110/411 * width,
                alignment: Alignment.bottomCenter,
                child: TextField(
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  controller: index == 1 ? title : description,
                  autofocus: false,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20/411 * width,
                    fontFamily: "Quicksand",
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (number){
                    setState(() {});
                  },
                  onSubmitted: (number){
                  },
                ),
              ),
              )
            ),
          ),
          Row(
            children: [
              Text("Pick the Date = ", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              MaterialButton(
                  onPressed: (){
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025)
                    );
                  },
                child: Text("Dare"),
              )
            ],
          )
        ],
      ),
    );
  }
}
