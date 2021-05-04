import 'package:flutter/material.dart';
import 'package:resue/Modules/Login/login_screen.dart';
import 'package:resue/Modules/client/client_details.dart';
import 'package:resue/Modules/listofjobs/listofjobs.dart';

class AppBarPage extends StatefulWidget {
  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Client Page"),

        bottom: TabBar(
          //isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Add Job'),
            Tab(icon: Icon(Icons.star), text: 'Posted Jobs'),
          ],
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      body: TabBarView(
        children: [
          MybApp(),
          List_of_jobs(),
        ],
      ),
    ),
  );

  Widget buildPage(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 28),
    ),
  );
}