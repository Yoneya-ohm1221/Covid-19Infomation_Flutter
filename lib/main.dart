// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:myfirst_flutter/ApiData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ApiData.dart';

void main() {
  Intl.defaultLocale = 'th';
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Covid-19 Info",
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ApiData? _data;
  String? totalcase;
  String? newcase;
  String? newdeath;
  String? totaldeath;
  String? newrecov;
  String? totalrecov;
  String? newcaseexcludeabroad;

  @override
  void initState() {
    super.initState();
    setState(() {
      todoApi();
    });
  }

  Future<void> todoApi() async {
    var url = "https://covid19.ddc.moph.go.th/api/Cases/today-cases-all";
    var data = await http.get(Uri.parse(url));
    setState(() {
      _data = ApiData.fromJson(jsonDecode(data.body)[0]);
      String? date = _data?.txnDate.toString();
      var newcaseBase = _data?.newCase;
      var totalcaseBase = _data?.totalCase;
      var newdeathBase = _data?.newDeath;
      var totaldeathBase = _data?.totalDeath;
      var newrecovBase = _data?.newRecovered;
      var totalrecovBase = _data?.totalRecovered;
      var totalnewcaseExcludeabroadBase =
          (_data?.newCase)! - (_data?.newCaseExcludeabroad)!;

      final numberFormat = NumberFormat("#,###,###,###", "en_US");
      totalcase = numberFormat.format(totalcaseBase);
      newcase = numberFormat.format(newcaseBase);
      newdeath = numberFormat.format(newdeathBase);
      totaldeath = numberFormat.format(totaldeathBase);
      newrecov = numberFormat.format(newrecovBase);
      totalrecov = numberFormat.format(totalrecovBase);
      newcaseexcludeabroad = numberFormat.format(totalnewcaseExcludeabroadBase);
    });
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.yMMMMEEEEd();
    DateTime datenow = DateTime.now();
    var mydate = format.format(datenow);

    return Scaffold(
      appBar: AppBar(
        title: const Text("COVID-19 TODAY"),
        backgroundColor: const Color.fromRGBO(51, 204, 51, 1.0),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildAboutDialog(context),
              );
            },
          )
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 18, 0, 10),
              child: Text(
                mydate,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFD30202),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Color(0xFFD30202),
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-0.87, -0.72),
                      child: Text(
                        'ผู้ติดเชื้อใหม่',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.85, 0.55),
                      child: Text(
                        '+${newcase ?? "0"}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFDEC700),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Color(0xFFDEC700),
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-0.9, -0.79),
                      child: Text(
                        'ผู้ติดเชื้อสะสม',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.87, 0.53),
                      child: Text(
                        totalcase ?? "0",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Color(0xFF999999),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          //background color of box
                          BoxShadow(
                            color: Color(0xFF999999),
                            blurRadius: 5.0,
                          )
                        ],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-0.83, -0.41),
                            child: Text(
                              '+${newdeath ?? "0"}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          const Align(
                            alignment: AlignmentDirectional(-0.77, -0.84),
                            child: Text(
                              'เสียชีวิตวันนี้',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Align(
                            alignment: AlignmentDirectional(-0.7, 0.09),
                            child: Text(
                              'เสียชีวิตสะสม',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-0.67, 0.57),
                            child: Text(
                              totaldeath ?? "0",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 180,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1BC900),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            //background color of box
                            BoxShadow(
                              color: Color(0xFF1BC900),
                              blurRadius: 5.0,
                            )
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              alignment:
                                  const AlignmentDirectional(-0.77, -0.42),
                              child: Text(
                                '+${newrecov ?? "0"}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            const Align(
                              alignment: AlignmentDirectional(-0.77, -0.84),
                              child: Text(
                                'หายป่วยวันนี้',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Align(
                              alignment: AlignmentDirectional(-0.7, 0.09),
                              child: Text(
                                'หายป่วยสะสม',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment:
                                  const AlignmentDirectional(-0.60, 0.57),
                              child: Text(
                                totalrecov ?? "0",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 180, 207, 1),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    //background color of box
                    BoxShadow(
                      color: Color.fromRGBO(0, 180, 207, 1),
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional(-0.87, -0.72),
                      child: Text(
                        'ผู้ติดเชื้อต่างชาติในไทย',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.85, 0.55),
                      child: Text(
                        '+${newcaseexcludeabroad ?? "0"}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAboutDialog(BuildContext context) {
  // ignore: unnecessary_new
  return new AlertDialog(
    title: const Text('About App'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAboutText(),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Okay, got it!'),
      ),
    ],
  );
}

Widget _buildAboutText() {
  return RichText(
    text: TextSpan(
      children: [
        const TextSpan(
          text: 'แอพพลิเคชั่นแสดงข้อมูลสถานการณ์โควิดประจำวัน ข้อมูลจาก',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        TextSpan(
          text: 'กรมควบคุมโรค',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch('https://ddc.moph.go.th/viralpneumonia/');
            },
        ),
        const TextSpan(
          text: '\n\nThe app was developed by yoneya follow the code ',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        TextSpan(
          text: 'on my github',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(
                  'https://github.com/Yoneya-ohm1221/Covid-19Infomation_Flutter/');
            },
        ),
      ],
    ),
  );
}
