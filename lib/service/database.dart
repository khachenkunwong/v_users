// ใช้เพื่อติดต่อและจัดการข้อมูลไปยังฐานข้อมูลไปยังฐานข้อมูล Cloud Firestore เช้นการติดตามข้อมูลสินค้า การเพิ่มข้อมูล
// การแก้ไขข้อมูล และการลบข้อมูลสินค้า

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/models/state_login_model.dart';
import 'package:v_users/models/user_model.dart';

//ติดต่อกับ firebase
class Database {
  static Database instance = Database._();
  Database._();
  // สร้าง database โดยการรับพารามิเตอร์ทุกตัวใน CarsModel เช่น
  // db.setCars(
  //         cars: CarsModel(
  //           id: user.uid,
  //           userName: '${user.displayName}',
  //           state: false,
  //           statejob: false,
  //           images: user.photoURL!,
  //           cartype: '',
  //           location: '',
  //           time: '',
  //           cost: '',
  //           phone: user.phoneNumber ?? '',
  //           email: user.email ?? '',
  //         ),
  //       );
  Future<void> setUsers({UsersModel? user}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference =
        FirebaseFirestore.instance.collection('users').doc('${_user?.uid}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(user!.toMap());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setCars({CarsModel? cars}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    // กำหนดให้ collection เป็น cars เเละ doc เป็น id ของผู้ใช้งาน
    final reference =
        FirebaseFirestore.instance.collection('cars').doc('${_user?.uid}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      // สร้างข้อมูลในฐานข้อมูลตามตำเเหน่งที่รับมา ตัวนี้เราไม่จำเป็นต้องสร้างผ่าน
      // firebase เพราะถ้าใช้คำสั้งนี้มันจะสร้างให้เองเเต่ในขณะเดียวกันมันก็จะไปสร้างทับข้อมูลที่มีอยู่เเล้ว
      // เเละตัวนี้ใช้เเทนการอัพเดดเฉพาะ ฟิลด์ไม่ได้ เช่นต้องการจะเเก้ name เเล้วใส่เเค่ name ไป
      // ในข้อมูลผู้ใช้จะมีเเค่ ฟิลด์ name พวก id งานจะหาย
      await reference.set(cars!.toMap());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setGetJob({UsersModel? users}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    // เป็นการสร้าง collection ซ้อน collection คือ getjob อยู่ใน cars
    final reference = FirebaseFirestore.instance
        .collection('cars')
        .doc('${_user?.uid}')
        .collection('getjob')
        .doc("${users?.id}");
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(users!.toMap());
      print('สร้าง getjob เรียบร้อย');
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setStateLogin({StateLoginModel? stateuser}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    // เป็นการสร้าง collection ซ้อน collection คือ getjob อยู่ใน cars
    final reference = FirebaseFirestore.instance
        .collection('statelogin')
        .doc('${_user?.uid}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(stateuser!.toMap());
      print('สร้าง getjob เรียบร้อย');
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setJobHistory({UsersModel? users, id}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('cars')
        .doc('${_user?.uid}')
        .collection('jobhistory')
        .doc("${users?.id}");
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(users!.toMap());
      print('สร้าง jobhistory เรียบร้อย');
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setUsersPublic({UsersModel? users}) async {
    final reference = FirebaseFirestore.instance
        .collection('userspublic')
        .doc('${users?.id}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(users!.toMap());
      print('สร้าง user public แล้ว');
    } catch (err) {
      print('error ${err}');
      rethrow;
    }
  }

  Future<void> setCarsPublic({CarsModel? cars}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference =
        FirebaseFirestore.instance.collection('carspublic').doc('${cars?.id}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(cars!.toMap());
    } catch (err) {
      rethrow;
    }
  }
   //** เพิ่มเข้ามาสำหรับเพิ่มข้อมูลงงานใน users **
  Future<void> setUserGetJob({CarsModel? cars}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    // เป็นการสร้าง collection ซ้อน collection คือ getjob อยู่ใน cars
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('getjob')
        .doc("${cars?.id}");
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(cars!.toMap());
      print('สร้าง getjob เรียบร้อย');
    } catch (err) {
      rethrow;
    }
  }

  //** เพิ่มเข้ามาสำหรับเพิ่มข้อมูลงประวัติใน users **
  Future<void> setUserJobHistory({CarsModel? cars, id}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('jobhistory')
        .doc("${cars?.id}");
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(cars!.toMap());
      print('สร้าง jobhistory เรียบร้อย');
    } catch (err) {
      rethrow;
    }
  }


  // อัพเดดเฉพาะฟิลด์ที่ต้องการ ตัวนี้อัพเดด state โดยพามิเตอร์ที่รับผ่าน CarsModel คือ state ตัวเดียวได้
  // เเตกต่างจาก set ที่เขียนทับทั้งหมดเเล้วทำให้ข้อมูลที่ไม่ได้กำหนดหายไป
  Future<void> updateCarsState({CarsModel? cars}) {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('cars');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    return reference
        // _user?.uid คือ id ข้อมูลใช้ใน Authentication ในfirebase
        .doc(_user?.uid)
        // ตัวนี้คืออัพเดต จะเพิ่มพวกฟิลด์ที่ต้องการอัพเดดเพิ่มก็ได้ เช่น 'username': cars?.username,
        // แต่ก็ต้องรับค่าเพิ่มจากรับเเค่ state รับ username ด้วย
        .update({
          'state': cars?.state,
        })
        // ถ้าเกิดไม่ ทำงานสำเร็จเเสดง "อัพเดต state" ใน terminal
        .then((value) => print("อัพเดต state"))
        // ถ้าเกิด error เกิดขึ้นให้ทำงานตรงนี้
        .catchError((error) => print("Failed to update user: $error"));
  }

  // อัพเดดเฉพาะฟิลด์ที่ต้องการ ตัวนี้อัพเดด statejob โดยพามิเตอร์ที่รับผ่าน CarsModel คือ statejob ตัวเดียว
  Future<void> updateCarsStatejob({CarsModel? cars}) {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('cars');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    return reference
        .doc(_user?.uid)
        // อัพเดต statejob
        .update({
          'statejob': cars?.statejob,
        })
        .then((value) => print("อัพเดต statejob"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> updateCarsTime({CarsModel? cars}) {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('cars');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    return reference
        // _user?.uid คือ id ข้อมูลใช้ใน Authentication ในfirebase
        .doc(_user?.uid)
        // ตัวนี้คืออัพเดต จะเพิ่มพวกฟิลด์ที่ต้องการอัพเดดเพิ่มก็ได้ เช่น 'username': cars?.username,
        // แต่ก็ต้องรับค่าเพิ่มจากรับเเค่ state รับ username ด้วย
        .update({
          'time': cars?.time,
        })
        // ถ้าเกิดไม่ ทำงานสำเร็จเเสดง "อัพเดต state" ใน terminal
        .then((value) => print("อัพเดต time"))
        // ถ้าเกิด error เกิดขึ้นให้ทำงานตรงนี้
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> updateCarsDistance({CarsModel? cars}) {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('cars');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    return reference
        // _user?.uid คือ id ข้อมูลใช้ใน Authentication ในfirebase
        .doc(_user?.uid)
        // ตัวนี้คืออัพเดต จะเพิ่มพวกฟิลด์ที่ต้องการอัพเดดเพิ่มก็ได้ เช่น 'username': cars?.username,
        // แต่ก็ต้องรับค่าเพิ่มจากรับเเค่ state รับ username ด้วย
        .update({
          'distance': cars?.distance,
        })
        // ถ้าเกิดไม่ ทำงานสำเร็จเเสดง "อัพเดต state" ใน terminal
        .then((value) => print("อัพเดต distance"))
        // ถ้าเกิด error เกิดขึ้นให้ทำงานตรงนี้
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> updateCarsAddress({CarsModel? cars}) {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('cars');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    return reference
        // _user?.uid คือ id ข้อมูลใช้ใน Authentication ในfirebase
        .doc(_user?.uid)
        // ตัวนี้คืออัพเดต จะเพิ่มพวกฟิลด์ที่ต้องการอัพเดดเพิ่มก็ได้ เช่น 'username': cars?.username,
        // แต่ก็ต้องรับค่าเพิ่มจากรับเเค่ state รับ username ด้วย
        .update({
          'address': cars?.address,
        })
        // ถ้าเกิดไม่ ทำงานสำเร็จเเสดง "อัพเดต state" ใน terminal
        .then((value) => print("อัพเดต address"))
        // ถ้าเกิด error เกิดขึ้นให้ทำงานตรงนี้
        .catchError((error) => print("Failed to update user: $error"));
  }

  // get คือนำข้อมูลที่อยู่ใน Cloud Firestore มาแสดงผลในหน้าจอข้อผู้ใช้
  Stream<List<CarsModel>> getCars() {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('cars');
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    // ที่ทำกันซ้อนกันหลายๆอันคือ ทำการเเปลง type เป็น type ที่ต้องการเเล้วถึงจะใช้ได้
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        // doc.data() คือข้อมูลจริงใน Cloud Firestore
        // CarsModel. คือทำให้สารารถกำหนดเรียกดูตาม class CarsModel ได้เลย เช่น
        // snapshot.data().state คือการเอาข้อมูลเฉพาะฟิลด์ state มาเเสดง
        return CarsModel.fromMap(doc.data());
      }).toList();
    });
  }
  Stream<List<StateLoginModel>> getStateLogin() {
    // กำหนดตำแหน่งที่ต้องการอัพเดด คือ collection cars
    final reference = FirebaseFirestore.instance.collection('statelogin');
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    // ที่ทำกันซ้อนกันหลายๆอันคือ ทำการเเปลง type เป็น type ที่ต้องการเเล้วถึงจะใช้ได้
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        // doc.data() คือข้อมูลจริงใน Cloud Firestore
        // CarsModel. คือทำให้สารารถกำหนดเรียกดูตาม class CarsModel ได้เลย เช่น
        // snapshot.data().state คือการเอาข้อมูลเฉพาะฟิลด์ state มาเเสดง
        return StateLoginModel.fromMap(doc.data());
      }).toList();
    });
  }
// statelogin
  Stream<List<UsersModel>> getUsersPublic() {
    final reference = FirebaseFirestore.instance.collection('userspublic');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return UsersModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<CarsModel>> getCarsPublic() {
    final reference = FirebaseFirestore.instance.collection('carspublic');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return CarsModel.fromMap(doc.data());
      }).toList();
    });
  }

  // การดูข้อมูลที่ collection ซ้อน collection
  Stream<List<UsersModel>> getCarsGetJob() {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('cars')
        .doc('${_user?.uid}')
        .collection('getjob');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return UsersModel.fromMap(doc.data());
      }).toList();
    });
  }
  //** เพิ่มเข้ามาสำหรับดูข้อมูลใน user **
  Stream<List<CarsModel>> getUserJobCar() {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('getjob');
    //.doc('${_user?.uid}');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot;
    //QuerySnapshot<Object?> Snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return CarsModel.fromMap(doc.data());
      }).toList();
    });
  }
  
  Future<void> deleteUsersPublic({UsersModel? users}) async {
    final reference = FirebaseFirestore.instance
        .collection('userspublic')
        .doc('${users?.id}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
      print('ลบ user public เรียบร้อย');
    } catch (err) {
      print('ลบ userspublic ไม่ได้');
      rethrow;
    }
  }

  // การลบ ข้อมูลที่ collection ซ้อน collection ถ้าต้องการลบเเบบไม่ซ้อนเเค่เอา
  // .collection('getjob').doc('${users?.id}') ออก ก็ได้กำหนดให้ลบที่
  // collection cars ที่ doc ผู้ใช้
  Future<void> deleteGetJob({UsersModel? users}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('cars')
        .doc('${_user?.uid}')
        .collection('getjob')
        .doc('${users?.id}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
      print('ลบ getjob เรียบร้อย');
    } catch (err) {
      print('ลบ getjob ไม่ได้');
      rethrow;
    }
  }

  Future<void> deleteJobHistory({UsersModel? users}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    final reference = FirebaseFirestore.instance
        .collection('cars')
        .doc('${_user?.uid}')
        .collection('jobhistory')
        .doc('${users?.id}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
      print('ลบ jobhistory เรียบร้อย');
    } catch (err) {
      print('ลบ jobhistory ไม่ได้');
      rethrow;
    }
  }

  Future<void> deleteCarsPublic({CarsModel? cars}) async {
    final reference =
        FirebaseFirestore.instance.collection('carspublic').doc('${cars?.id}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
      print('ลบ carspublic เรียบร้อย');
    } catch (err) {
      print('ลบ carspublic ไม่ได้');
      rethrow;
    }
  }
  Future<void> deleteUserGetJob({CarsModel? users}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('getjob')
        .doc('${users?.id}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
      print('ลบ getjob เรียบร้อย');
    } catch (err) {
      print('ลบ getjob ไม่ได้');
      rethrow;
    }
  }
  Future<void> deleteUserJobHistory({CarsModel? users}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('jobhistory')
        .doc('${users?.id}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
      print('ลบ jobhistory เรียบร้อย');
    } catch (err) {
      print('ลบ jobhistory ไม่ได้');
      rethrow;
    }
  }
}
