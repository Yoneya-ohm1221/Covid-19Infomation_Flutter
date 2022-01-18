import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myfirst_flutter/ApiData.dart';
import 'ApiData.dart';

void main() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    String? newcase = _data?.newCase.toString();
    String? date = _data?.txnDate.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 TODAY"),
        backgroundColor: const Color.fromRGBO(51, 204, 51, 1.0),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 10),
              child: Text(
                '$date',
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
                ),
                child: Stack(
                  children: [
                    Align(
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
                      alignment: AlignmentDirectional(-0.85, 0.76),
                      child: Text(
                        '+25666',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFDEC700),
                ),
                child: Stack(
                  children: [
                    Align(
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
                      alignment: AlignmentDirectional(-0.87, 0.53),
                      child: Text(
                        '25666',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFF999999),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.83, -0.51),
                            child: Text(
                              '+13',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Align(
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
                          Align(
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
                            alignment: AlignmentDirectional(-0.67, 0.47),
                            child: Text(
                              '1300000',
                              style: TextStyle(
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
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Color(0xFF1BC900),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.83, -0.51),
                              child: Text(
                                '+13',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Align(
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
                            Align(
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
                              alignment: AlignmentDirectional(-0.67, 0.47),
                              child: Text(
                                '1300000',
                                style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
