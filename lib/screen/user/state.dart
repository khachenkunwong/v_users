import 'package:flutter/material.dart';
import 'package:v_users/flutter_flow/flutter_flow_theme.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v_users/flutter_flow/flutter_flow_widgets.dart';
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/service/database.dart';
import 'package:v_users/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class StateWidget extends StatefulWidget {
  final index;
  const StateWidget({Key? key, this.index}) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Database db = Database.instance;

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    Stream<List<CarsModel>> getuserjobcar = db.getUserJobCar();

    var uid = uuid.v1();
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    CollectionReference userjob = FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .collection('getjob');

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF0AC258),
        automaticallyImplyLeading: true,
        title: Text(
          'สถานะ',
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
            stream: getuserjobcar,
            builder: (context, snapshot2) {
              if (snapshot2.hasError) {
                return Center(child: Text('เกิดข้อผิดพลาด'));
              }
              if (snapshot2.data?.length == 0) {
                return Center(
                  child: Text('ยังไม่มีรายงานที่ดำเนินการอยู่'),
                );
              }
              if (snapshot2.hasData) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/car.png',
                                  width: 143,
                                  height: 143,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'พบคนขับแล้ว',
                                  style: FlutterFlowTheme.bodyText1,
                                ),
                                Text(
                                  '${snapshot2.data?[widget.index].time}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF878787),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/lord.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/profile.png',
                                        ),
                                      ),
                                      Text(
                                        '${snapshot2.data?[widget.index].userName}',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/phone.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Image.asset(
                                    'assets/images/di.png',
                                    width: 24,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 7, 10, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot2.data?[widget.index].address}',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 40, 0, 0),
                                        child: Text(
                                          'ตำบลเเม่กา อำเภอเมืองพะเยา 56000 ประเทศไทย',
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: SizedBox(
                              width: 335,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                onPressed: () {
                                  // 1.การยกเลิกงานคือลบ doc ใน collection getjob โดยในต้องส่งค่า id ของ user เข้าไปใน deleteGetJob ด้วยตันนี้จำเป็น
                                  // 2.ลบ doc ใน collection jobhistory โดยในต้องส่งค่า id ของ user เข้าไปใน deleteJobHistory ด้วยตันนี้จำเป็นจำเป็น
                                  // 3.นำ ค่าที่เคยส่งเค้าไปใน collection getjob และ collection jobhistory กลับคืนมา ใน collection userspublic
                                  // ทั้งหมด ถ้าสงสัยข้อนี้ควรกับไปดูบันทัดที่ 306 ลงมาดูก่อน

                                  db.deleteUserGetJob(
                                      users: CarsModel(
                                    // id จาก collection users
                                    id: '${snapshot2.data?[widget.index].id}',
                                  ));
                                  db.deleteUserJobHistory(
                                      users: CarsModel(
                                    // id จาก collection users
                                    id: '${snapshot2.data?[widget.index].id}',
                                  ));
                                  db.setCarsPublic(
                                    cars: CarsModel(
                                      id: snapshot2.data?[widget.index].id,
                                      userName: snapshot2
                                          .data?[widget.index].userName,
                                      state:
                                          snapshot2.data?[widget.index].state,
                                      statejob: snapshot2
                                          .data?[widget.index].statejob,
                                      images:
                                          snapshot2.data?[widget.index].images,
                                      cartype:
                                          snapshot2.data?[widget.index].cartype,
                                      location: snapshot2
                                          .data?[widget.index].location,
                                      distance: snapshot2
                                          .data?[widget.index].distance,
                                      cost: snapshot2.data?[widget.index].cost,
                                      time: snapshot2.data?[widget.index].time,
                                      phone:
                                          snapshot2.data?[widget.index].phone,
                                      email:
                                          snapshot2.data?[widget.index].email,
                                      address:
                                          snapshot2.data?[widget.index].address,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ยกเลิกงาน',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              // ถ้า error คือ type ของฟิลตัวใดตัวหนึ่งไม่ตรงให้ทำตรงนี้
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
