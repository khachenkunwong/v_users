import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import 'screen/home.dart';
import 'screen/login/login.dart';
import 'shape/datauser.dart';

// import 'firebase_options.dart'; // generated via `flutterfire` CLI
// ถ้าต้องใช้ async, await ก็ต้องใช้ Future โดยตัวนี้กำหนด type เป็น void
Future<void> main() async {
  // บันทัดที่ 15 21 คือ การตั้งค่า firebase เพื่อให้เราสามารถใช้งานได้
  WidgetsFlutterBinding.ensureInitialized();
  // ใน intializeApp สามารถกำหนดหรือตั้งค่าในการเรียกใช้ firebase ได้
  // เช่นกำหนด Web API Key ,Project name ,Project ID เป็นต้น
  // เพื่อจะได้ป้องกันการเรียกใช้งานนอกเหนือจาก app ที่กำหนดได้
  // ที่ยังไม่ได้กำหนดเพราะตัวเเอปยังไม่เสร็จเเละมีความยุ่งยากในการกำหนดเนื่องจาก
  // เปลี่ยนโปรเจคของ firebase บ่อยๆ
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // false เพื่อไม่เห็นข้อความ debug มุมขว้าบนในหน้า ui
      debugShowCheckedModeBanner: false,
      home: AuthenticationGate(),
    );
  }
}

class AuthenticationGate extends StatefulWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  State<AuthenticationGate> createState() => _AuthenticationGateState();
}

class _AuthenticationGateState extends State<AuthenticationGate> {
  @override
  Widget build(BuildContext context) {
    // MultiProvider ใช้เพื่อเราต้องการนำค่าที่ต้องใช้ทุกหน้าหรือเราไม่อยากส่งค่าผ่านทุกหน้า
    // เช่นข้อมูลของผู้ใช้เมื่อต้องการเรียกใช้ก็ต้องประกาศตัวเเปรในหน้านั้นทุกครั้งเพื่อจะต้องรู้ชื่อที่เราผู้ใช้สมัคร
    // ตัวนี้เปลียนเสมื่อนตัวที่เอาเเชร์ค่าไปหน้าต่างๆ
    return MultiProvider(
      // สามารถสร้าง class เพื่อเก็บข้อมูลได้หลาย class
      providers: [
        // สร้าง class ที่ 1 เพื่อเก็บข้อมูลของผู้ใช้ เช่น ชื่อ id ภาพโปรไฟล์ อื้นๆ
        Provider<DataUser>(create: (context) => DataUser()),
      ],
      // StreamBuilder ใช้เพื่อติดตามข้อมูลของ Class User ซึ่งเป็น class ของ package 
      // กำหนด type เป็น User? เพื่อเอาไว้กันว่าถ้าไม่ใช้ type นี้เเล้วเมื่อใส่ค่า parameter
      // ใน stream ไม่ถูกเเล้วมันถึงจะเเจ้ง error
      child: StreamBuilder<User?>(
        // authStateChanges() ตรวจสอบว่ามีการเข้าสู่ระบบหรือไม่
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // snapshot.hasData ตรวจสอบว่ามีข้อมูลหรือไม่ โดยที่ outputเป็น ture หรือ false
            // !snapshot.hasData ถ้าไม่มีข้อมูลจะเป็น true ถ้ามีข้อมูลจะเป็น false เพราะมี ! หรือ not
            // ค่าเลยสลับกัน
            if (!snapshot.hasData) {
              // เข้าเมื่อยังไม่ได้ login หรือยังไม่ได้สมัคร
              return Login();
            }
            // เมื่อสมัครหรือ login แล้ว
            return HomePage();
          }),
    );
  }
}
