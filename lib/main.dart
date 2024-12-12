import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'node.dart';
List<Node> decisionMap = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String csv = "decision_map.csv";
  String fileData = await rootBundle.loadString(csv);
  print(fileData);
  List <String> rows = fileData.split("\n");

  for(int i = 0; i < rows.length; i++) {
    // this selects an item from row and places
    String row = rows[i];
    List <String> itemInRow = row.split(","); //splits the stuff into a seperate list by the comma from the node list
    Node node = Node(
      int.parse(itemInRow[0]),
      int.parse(itemInRow[1]),
      itemInRow[2]
      );
      decisionMap.add(node);
    }

  runApp(const MaterialApp(
    home: MyFlutterApp(),
  ),
  );
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({super.key});

  @override
  State<StatefulWidget> createState(){
    return MyFlutterState();
  }
}
class MyFlutterState extends State<MyFlutterApp>{

  late int iD;
  late int nextID;
  String description = "";

  @override

  void initState() {
    super.initState();
    //Place code here to initilise server objects
    WidgetsBinding.instance.addPostFrameCallback((_){
      //Place Cide here you want to execute immediately after
      //The Ui is buikt

      setState((){
      Node current = decisionMap.first;
      iD = current.iD;
      nextID = current.nextID;
      description = current.description;

      });
    });
  }
  
  
  void clickHandler(){
    setState((){
      for (Node nextNode in decisionMap){
        if (nextNode .iD == nextID){
          iD = nextNode.iD;
          nextID = nextNode.nextID;
          description = nextNode.description;
          break;
        }
      }
    });
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff3e87c5),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children:[Align(
   alignment: const Alignment(0.2, 0.0),
   child: MaterialButton(
     onPressed: () {clickHandler( );},
     color: const Color(0xff3a21d9),
     elevation: 0,
     shape: const RoundedRectangleBorder(
     borderRadius: BorderRadius.zero,
     ),
     textColor: const Color(0xfffffdfd),
     height: 40,
     minWidth: 140,
     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
     child: const Text(
     "Click Here",
     style: TextStyle(
     fontSize: 20,
     fontWeight: FontWeight.w400,
     fontStyle: FontStyle.normal,
     ),
     ),
   ),
          ),
           Align(
 alignment: const Alignment(0.0, -0.7),
 child: Text(
   description,
   textAlign: TextAlign.center,
   overflow: TextOverflow.clip,
   style: const TextStyle(
     fontWeight: FontWeight.w400,
     fontStyle: FontStyle.normal,
     fontSize: 34,
     color: Color(0xffffffff),
   ),
 ),
          ),],
          ),
        ),
      ),
      //Flutter Ui Widgets Go here 
    );
  }
}
