import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resue/Modules/Home/Components/app_bar.dart';
import 'package:resue/Modules/Home/Components/body.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:resue/Modules/listofavilablejobs/Available_jobs.dart';
import 'package:resue/Modules/listofjobs/listofjobs.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width  of our screen
    return Material( child: SingleChildScrollView(
      child: Container(
        height: size.height,
        // it will take full width
        width: size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomAppBar(),


            List_of_jobs()
            // It will cover 1/3 of free spaces


            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    ),
    );
  }
}

class SearchBarDemoHome extends StatefulWidget {
  @override
  _SearchBarDemoHomeState createState() => new _SearchBarDemoHomeState();
}

class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Jobs'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _SearchBarDemoHomeState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,

    );
  }
}