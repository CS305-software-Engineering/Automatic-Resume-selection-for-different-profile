import 'package:flutter/material.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:resue/Modules/confirm/confirm.dart';
import 'package:resue/components/SplitWidget.dart';






class MyAppSplit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List of Jobs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          child: SplitWidget(
            childFirst: confirm(),
            childSecond:FormScreen() ,
          ),
        ));
  }


}