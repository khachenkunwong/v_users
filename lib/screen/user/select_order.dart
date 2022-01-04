import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:uuid/uuid.dart';
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/models/user_model.dart';
import 'package:v_users/service/database.dart';

import 'package:v_users/flutter_flow/flutter_flow_theme.dart';
import 'state.dart';

class SelectOrderWidget extends StatefulWidget {
  const SelectOrderWidget({Key? key}) : super(key: key);

  @override
  _SelectOrderWidgetState createState() => _SelectOrderWidgetState();
}

class _SelectOrderWidgetState extends State<SelectOrderWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Database db = Database.instance;
  var uuid = Uuid();

  CollectionReference user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    Stream<List<CarsModel>> job = db.getUserJobCar();
    
    var uid = uuid.v1();
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF0AC258),
        automaticallyImplyLeading: true,
        title: Text(
          'ราการที่เลือก',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: StreamBuilder<List<CarsModel>>(
            stream: job,
            builder: (context, snapshot) {
              return FutureBuilder<DocumentSnapshot>(
                  future: user.doc('${_user?.uid}').get(),
                  builder: (context, snapshot5) {
                    if (snapshot5.hasError) {
                      return Center(child: Text('เกิดข้อผิดพลาด'));
                    }
                    if (snapshot.data?.length == 0) {
                      return Center(
                        child: Text('ยังไม่ได้เลือกงาน'),
                      );
                    }
                    print('snapshot.hasData: ${snapshot.hasData}');
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StateWidget(index: index),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color: Color(0xFFF5F5F5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/car.png',
                                                      width: 75,
                                                      height: 75,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2, 10, 0, 10),
                                                      child: Text(
                                                        'ชื่อคนขับรถ ${snapshot.data![index].userName}\nสถานะ  รอเริ่มงาน\nระยะเวลา   ${snapshot.data![index].time} นาที',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]);
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }),
      ),
    );
  }
}
