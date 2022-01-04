import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:v_users/service/database.dart';
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/models/user_model.dart';

import 'select_order.dart';
import 'package:v_users/flutter_flow/flutter_flow_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database.instance;
  final _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? _user;

  CollectionReference cars =
      FirebaseFirestore.instance.collection('carspublic');

  @override
  Widget build(BuildContext context) {
    Stream<List<CarsModel>> getcarpublic = db.getCarsPublic();
    _user = _auth.currentUser;
    var uuid = Uuid();
    var uid = uuid.v1();
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // ไปยังหน้า
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectOrderWidget()),
          );
        },
        child: Text('กดเพื่อไปหน้ารายการที่เลือก'),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF0AC258),
        automaticallyImplyLeading: true,
        title: Row(
          
          children: [
            Text(
              'จัดส่งที่ ตำบลเเม่กา',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  print('uid = $uid');
                  await db.setCarsPublic(
                    cars: CarsModel(
                      id: '$uid',
                      userName: '${_user?.displayName}',
                      state: true,
                      statejob: false,
                      images: _user?.photoURL!,
                      cartype: 'รถยนต์',
                      location: GeoPoint(17.4443097, 102.2812651),
                      time: '',
                      distance: '',
                      cost: '',
                      phone: _user?.phoneNumber ?? '',
                      email: _user?.email ?? '',
                      address: '',
                    ),
                  );
                  setState(() {
                    print('relord');
                  });
                },
                child: Text('เพิ่มรายการ')),
          ],
        ),
        actions: [],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            // logout
            FirebaseAuth.instance.signOut();
          },
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: StreamBuilder<List<CarsModel>>(
            stream: getcarpublic,
            builder: (context, snapshot) {
              print('snapshot.error: ${snapshot.error}');
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.data?.length == 0) {
                return Center(
                  child: Text('ยังไม่มีรถใกล้เคียง'),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.05, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                              child: InkWell(
                                onTap: () async {
                                  //สร้างงานในระบบ
                                  db.setUserGetJob(
                                    cars: CarsModel(
                                      id: snapshot.data?[index].id,
                                      userName: snapshot.data?[index].userName,
                                      state: snapshot.data?[index].state,
                                      statejob: snapshot.data?[index].statejob,
                                      images: snapshot.data?[index].images,
                                      cartype: snapshot.data?[index].cartype,
                                      location: snapshot.data?[index].location,
                                      cost: snapshot.data?[index].cost,
                                      time: snapshot.data?[index].time,
                                      distance: snapshot.data?[index].distance,
                                      phone: snapshot.data?[index].phone,
                                      email: snapshot.data?[index].email,
                                      address: snapshot.data?[index].address,
                                    ),
                                  );
                                  //สร้างประวัติในระบบ
                                  db.setUserJobHistory(
                                    cars: CarsModel(
                                      id: snapshot.data?[index].id,
                                      userName: snapshot.data?[index].userName,
                                      state: snapshot.data?[index].state,
                                      statejob: snapshot.data?[index].statejob,
                                      images: snapshot.data?[index].images,
                                      cartype: snapshot.data?[index].cartype,
                                      location: snapshot.data?[index].location,
                                      cost: snapshot.data?[index].cost,
                                      time: snapshot.data?[index].time,
                                      distance: snapshot.data?[index].distance,
                                      phone: snapshot.data?[index].phone,
                                      email: snapshot.data?[index].email,
                                      address: snapshot.data?[index].address,
                                    ),
                                  );
                                  //ลบข้อมูลในระบบ
                                  db.deleteCarsPublic(
                                      cars: CarsModel(
                                          id: snapshot.data?[index].id));
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectOrderWidget(),
                                    ),
                                  );
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0xFFF5F5F5),
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 0, 0, 0),
                                          child: Image.asset(
                                            'assets/images/car.png',
                                            width: 75,
                                            height: 75,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 0, 0, 0),
                                          child: Text(
                                            'ชื่อคนขับรถ ${snapshot.data![index].userName}\nสถานะ  รอเริ่มงาน\nระยะเวลา   ${snapshot.data![index].time} นาที\nประเภทรถ ${snapshot.data![index].cartype}\nราคา ${snapshot.data![index].cost} บาท',
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
