import 'package:flutter/material.dart';

import 'package:resue/Modules/Login/login_screen.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:resue/Modules/applied_jobs/Applied_jobs.dart';
import 'package:resue/Modules/listofavilablejobs/Available_jobs.dart';
import 'package:resue/Modules/listofjobs/listofjobs.dart';
import 'home_page.dart';
import 'package:resue/Modules/client/client_details.dart';
import 'package:resue/Modules/client_home/client_appbar.dart';


import 'package:resue/components/SplitWidget.dart';

class SimpleAppBarPagestudent extends StatefulWidget {
  @override
  _SimpleAppBarPageState createState() => _SimpleAppBarPageState();
}

class _SimpleAppBarPageState extends State<SimpleAppBarPagestudent> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,


        bottom: TabBar(
          //isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.face), text: 'My Profile'),
            Tab(icon: Icon(Icons.star), text: 'Applied jobs'),
          ],
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      body: TabBarView(
        children: [
          List_of_Ajobs(),
          FormScreen(),
          List_of_Appjobs()

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