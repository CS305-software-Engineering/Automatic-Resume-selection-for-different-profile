
import '../book/Book.dart';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import '../book/Book.dart';
import 'package:uuid/uuid.dart';


import 'data.dart';

var uuid = Uuid();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String orderId;
  String stage = "Test";
  String orderAmount;
  String tokenData = "";
  String customerName = "Customer Name";
  String orderNote = "Order_Note";
  String orderCurrency = "INR";
  // String appId;
  String customerPhone = "9094395340";
  String customerEmail = "sample@gmail.com";
  String notifyUrl = "https://test.gocashfree.com/notify";
  String testUrl = "https://test.cashfree.com/api/v2/cftoken/order";

  payment(String name, String phone, String amount, String email,
      String note) async {
    customerName = name;
    customerPhone = phone;
    customerEmail = email;
    orderNote = note;
    orderAmount = amount;
    orderId = uuid.v1();

    http.Response response = await http.post(testUrl,
        headers: <String, String>{
          'content-type': 'application/json',
          "x-client-id": appID,
          "x-client-secret": appsecret
        },
        body: jsonEncode(<String, String>{
          "orderId": orderId,
          "orderAmount": orderAmount,
          "orderCurrency": "INR"
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      String token = ["cftoken"].toString();

      Map<String, dynamic> param = {
        "orderId": orderId,
        "orderAmount": orderAmount,
        "customerName": customerName,
        "orderNote": orderNote,
        "orderCurrency": orderCurrency,
        "appId": appID,
        "customerPhone": customerPhone,
        "customerEmail": customerEmail,
        "stage": stage,
        "tokenData": map["cftoken"],
        "notifyUrl": notifyUrl,
        'hideOrderId': false
      };

      CashfreePGSDK.doPayment(param)
          .then((value) => value?.forEach((key, value) {
        print("$key : $value");
      }));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Book()),
      );
    }
  }

  Future<void> makeUpiPayment(String name, String phone, String amount,
      String email, String note) async {
    customerName = name;
    customerPhone = phone;
    customerEmail = email;
    orderNote = note;
    orderAmount = amount;
    orderId = uuid.v1();

    http.Response response = await http.post(
        "https://cac-gamma.cashfree.com/cac/v1/authorize",
        headers: <String, String>{
          'content-type': 'application/json',
          "x-client-id": appID,
          "x-client-secret": appsecret
        },
        body: jsonEncode(<String, String>{
          "orderId": orderId,
          "orderAmount": orderAmount,
          "orderCurrency": "INR"
        }));
    print("${response.statusCode}");
    print("${response.body}");
    print("###########################################################");
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      String token = ["cftoken"].toString();

      Map<String, dynamic> param = {
        "orderId": orderId,
        "orderAmount": orderAmount,
        "customerName": customerName,
        "orderNote": orderNote,
        "orderCurrency": orderCurrency,
        "appId": appID,
        "customerPhone": customerPhone,
        "customerEmail": customerEmail,
        "stage": stage,
        "tokenData": map["cftoken"],
        "notifyUrl": "https://test.cashfree.com/api/v2/",
      };
      CashfreePGSDK.doUPIPayment(param)
          .then((value) => value?.forEach((key, value) {
        print("$key : $value");
        //Do something with the result
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: Text('DO PAYMENT'),
                onPressed: () => payment("customer name", "9898986767", "50",
                    "customeremail@gmail.com", "order note for normal payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
