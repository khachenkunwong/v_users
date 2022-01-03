import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';


import 'select_order.dart';
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/service/database.dart';
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

  @override
  Widget build(BuildContext context) {
    Stream<List<CarsModel>> getcar = db.getCarsPublic();
    _user = _auth.currentUser;
    var uuid = Uuid();
    var uid = uuid.v1();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0AC258),
        // true กำหนดให้มีปุ่มย้อนกลับ
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
                  //ใช้ setProduct เพื่อสร้างเอกสารไปยังฐานข้อมูล Cloud Firestore
                  await db.setCarsPublic(
                    cars: CarsModel(
                      // กำหนด id โดยการเเรนดอม
                      id: '$uid',
                      // กำหนดข้อมูลจาก Authentication ที่เป็น name ของผู้ใช้
                      userName: '${_user?.displayName}',
                      // กำนหดให้ state มีค่าเริ่มต้นเป็น false
                      state: true,
                      statejob: false,
                      // กำหนดข้อมูลจาก Authentication ที่เป็น urlภาพ ของผู้ใช้ ลงไปในฐานข้อมูล Cloud Firestore
                      // ลงในฟิล images
                      images: _user?.photoURL!,
                      cartype: 'รถยนต์',
                      location: GeoPoint(53.483959, -2.244644),
                      time: '',
                      distance: '',
                      // กำหนดข้อมูลจาก Authentication ที่เป็น เบอร์โทร ของผู้ใช้ ลงไปในฐานข้อมูล Cloud Firestore
                      // ลงใน ฟิล phone การใช้ตัวนี้ ?? ก็เหมือนกับการใช้ if else เช่น
                      // if (_user?.phoneNumber != null) {
                      // คือถ้าไม่ได้เป็นค่าว่างก็จะไม่ทำอะไร เช่นค่าเดิมคือ 08830303030 ก็จะกำหนดเป็น 08830303030 เหมือนเดิม
                      //   return _user?.phoneNumber;
                      // } else {
                      //  ถ้าค่าว่างก็จะกำหนดเป็น ''
                      //  return '';
                      // }
                      cost: '',
                      phone: _user?.phoneNumber ?? '',
                      email: _user?.email ?? '',
                      address: '',
                    ),
                  );
                  // สั่งให้ รีโหลดหน้า
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
            stream: getcar,
            builder: (context, snapshot) {
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
                      if (snapshot.data![index].state == true) {
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SelectOrderWidget(),
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
                                            MainAxisAlignment.spaceAround,
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
                      }
                      return Text('',style: TextStyle(fontSize: 0.5),);
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
