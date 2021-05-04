import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:resue/Modules/confirm/confirm.dart';
import 'package:tuple/tuple.dart';
const kPrimaryColor = Color(0xFFFFC200);
const kTextcolor = Color(0xFF241424);
const kDarkButton = Color(0xFF372930);
int i=0;
var jobid;
var client_id;
var job_des;
var job_summary;
 List<Tuple2<Tuple2<Tuple2<String,String>,String>, double>> entries = [];
var searchqueue = new Queue.from(entries);