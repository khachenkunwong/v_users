import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/src/provider.dart';
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/models/state_login_model.dart';
import 'package:v_users/models/user_model.dart';
import 'package:v_users/service/database.dart';
import 'package:v_users/shape/datauser.dart';

final kFirebaseAnalytics = FirebaseAnalytics();

class LoginCar extends StatefulWidget {
  const LoginCar({Key? key}) : super(key: key);

  @override
  _LoginCarState createState() => _LoginCarState();
}

class _LoginCarState extends State<LoginCar> {
  //บันทัดที่ 30-31 เก็บค่าที่รับมาจากที่ผู้ใช้กรอก email และ password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = firebase_auth.FirebaseAuth.instance;
  // เรียกใช้เพื่อติดต่อกับ Cloud Firestore เพี่อ get set updata delete
  Database db = Database.instance;
  firebase_auth.User? _user;
  // กำหนดเป็น false เพื่อทำให้ปุ่มlogin in google สามารถกดได้
  bool _busy = false;
  // เอาใช้เพื่อ login ผ่าน google
  var user;
  

  late Position _currentPosition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('position.latitude: ${position.latitude}');

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        print('end mapController');
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  // initState() กำหนดให้ทำงานหรือเรียกใช้งานตัวไหนตอนเปิดหน้านี้มาครังเเรก
  void initState() {
    super.initState();
    print('firebase == user');
    _user = _auth.currentUser;
    _determinePosition();
    // _auth.authStateChanges().listen((firebase_auth.User? usr) {
    //   _user = usr;
    //   debugPrint('user=$_user');
    // });
    print('firebase == end');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        // ทำให้เลื่อนหน้าได้เเต้องระวังเมื่อใช้ร่วมกับ ListView จะใช้ร่วมกันไม่ได้ เช่น
        // SingleChildScrollView เเล้วเรียก ListView ในข้าง มันจะ error
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Image.asset(
                  'assets/images/vgistic.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF0AC258),
                            ),
                            alignment: Alignment(0, 0),
                            child: Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'ชื่อผู้ใช้',
                          labelStyle: GoogleFonts.getFont(
                            'Poppins',
                            color: Color(0xFF616161),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          hintText: 'ชื่อผู้ใช้',
                          hintStyle: GoogleFonts.getFont(
                            'Poppins',
                            color: Color(0xFF616161),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0AC258),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0AC258),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        ),
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Color(0xFF616161),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF0AC258),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(1),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            alignment: Alignment(0, 0),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'รหัสผ่าน',
                          labelStyle: GoogleFonts.getFont(
                            'Poppins',
                            color: Color(0xFF616161),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          hintText: 'รหัสผ่าน',
                          hintStyle: GoogleFonts.getFont(
                            'Poppins',
                            color: Color(0xFF616161),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0AC258),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0AC258),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        ),
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Color(0xFF616161),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 20),
                    child: TextButton(
                      onPressed: () {
                        // Get.toNamed(Routes.SEARCH_PASSWORD);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ForgotPasswordView()),
                        // );
                      },
                      child: Text(
                        'ลืมรหัสผ่าน',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Color(0xFF0AC258),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: SizedBox(
                  height: 47,
                  width: 325,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0AC258),
                    ),
                    child: Text(
                      "เข้าสู่ระบบ",
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      // final String email = emailController.text.trim();
                      // final String password = passwordController.text.trim();

                      // if (email.isEmpty) {
                      //   print("Email is Empty");
                      // } else {
                      //   if (password.isEmpty) {
                      //     print("Password is Empty");
                      //   } else {
                      //     context.read<AuthService>().login(
                      //           email,
                      //           password,
                      //         );
                      //   }
                      // }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(child: Text('หรือ')),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: SizedBox(
                            height: 47,
                            width: 325,
                            child: ElevatedButton.icon(
                              onPressed: _busy
                                  ? null
                                  : () async {
                                      setState(() => _busy = true);

                                      final user = await _googleSignIn();

                                      // setState(() => _busy = false);
                                      if (mounted) {
                                        setState(() => _busy = false);
                                        print('กำลังทำงาน = $mounted');
                                      }
                                      Navigator.pop(context);

                                      print('_busy = $mounted');
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 4,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                textStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  color: const Color(0xFF1877F2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.transparent,
                                size: 20,
                              ),
                              label: Text(
                                'Login with Google',
                                style: GoogleFonts.getFont(
                                  'Roboto',
                                  color: const Color(0xFF606060),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-0.83, 0),
                          child: Container(
                            width: 22,
                            height: 22,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/google.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: SizedBox(
                            height: 47,
                            width: 325,
                            child: ElevatedButton.icon(
                              // เมื่อกดปุ่มไปเเล้วถ้ายังทำงานไม่เสร็จจะให้แสดงสีเทาเพื่อป้องกันกันการกดซ้ำ
                              onPressed: _busy
                                  // กำหนดให้กดไม่ได้จนกว่าจะทำงานเสร็จ
                                  ? null
                                  // เมื่อยังไม่ได้กด
                                  : () async {
                                      // ทำการเปลี่ยนค่าเป็น true เพื่อทำให้กดไม่ได้ เเละทำการ รีหน้าใหม่เพื่ออัพเดทหน้าจอ
                                      setState(() => _busy = true);
                                      // // ทำการเรียกใช้งานฟังก์ชั่น _googleSignIn() เพื่อเข้าสู่ระบบผ่าน google
                                      // // await รอให้ login เสร็จก่อนเเล้วค่อยไปทำงานบันทัดต่อไป
                                      final userfacebook =
                                          await _loginWithFacebook();

                                      // // setState(() => _busy = false);
                                      // // mounted เป็นการป้องการ การ error ว่าไม่เคลียร์หน่วยความจำเมื่อไปหน้าอื่นหรือปิดหน้านี้
                                      if (mounted) {
                                        // ทำการเปลี่ยนค่าเป็น false เพื่อทำให้กดได้ และรีหน้าใหม่เพื่ออัพเดทหน้าจอ
                                        setState(() => _busy = false);
                                        //   // เช็คว่าค่า mounted คือค่าอะไรในตอนนี้(เอาไว้เช็คดูลำดับการทำงานเฉยๆว่าทำงานถึงไหนเเล้ว)
                                        print('กำลังทำงาน = $mounted');
                                      }
                                      Navigator.pop(context);

                                      print('_busy = $mounted');
                                    },
                              // ตั้งค่าปุ่มเช่น สี ตัวอักษร สีตัวอักษร สีพื้นหลัง สีพื้นหลังตัวอักษร
                              style: ElevatedButton.styleFrom(
                                // กำหนดสีปุ่ม
                                primary: Colors.white,
                                elevation: 4,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                textStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  color: const Color(0xFF1877F2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.transparent,
                                size: 20,
                              ),
                              label: Text(
                                'Login with Facebook',
                                style: GoogleFonts.getFont(
                                  'Roboto',
                                  color: const Color(0xFF606060),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-0.83, 0),
                          child: Container(
                            width: 22,
                            height: 22,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/Facebook.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Text(
                      'ยังไม่มีบัญชี?',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Color(0xFF303030),
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        //await Get.toNamed(Routes.REGISTER);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => RegisterView()),
                        // );
                      },
                      child: Text(
                        'ลงทะเบียน',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Color(0xFF27AE60),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign in with Google.
  Future<firebase_auth.User?> _googleSignIn() async {
    try {
      final curUser = _user ?? _auth.currentUser;

      if (curUser != null && !curUser.isAnonymous) {
        return curUser;
      }
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
      final user = (await _auth.signInWithCredential(credential)).user;
      print('user = 1111111 $user');
      print('กำลังเข้า store');
      // นำข้อมูลใน firestore มาเเสดง
      final userData = await FirebaseFirestore.instance
          .collection('cars')
          .doc(user!.uid)
          .get();

      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() {
          _currentPosition = position;
          print('CURRENT POS: $_currentPosition');
          print('end mapController');
        });
      }).catchError((e) {
        print(e);
      });

      print(_currentPosition.latitude);
      if (userData.data() == null) {
        await db.setCars(
          //ใช้ setProduct เพื่อเพิ่มหรือแก้ไขเอกสารไปยังฐานข้อมูล Cloud Firestore
          cars: CarsModel(
            id: user.uid,
            userName: '${user.displayName}',
            state: false,
            statejob: false,
            images: user.photoURL!,
            cartype: '',
            location:
                GeoPoint(_currentPosition.latitude, _currentPosition.longitude),
            time: '',
            distance:'',
            cost: '',
            phone: user.phoneNumber ?? '',
            email: user.email ?? '',
            address: '',
          ),
        );
      }
      db.setStateLogin(stateuser: StateLoginModel(user: false, car: true));
      // ต้องเอาออกเมื่อใช้เสร็จ
      // await db.setUsersPublic(
      //     //ใช้ setProduct เพื่อเพิ่มหรือแก้ไขเอกสารไปยังฐานข้อมูล Cloud Firestore
      //     users: UsersModel(
      //       id: user.uid,
      //       userName: '${user.displayName}',
      //       state: false,
      //       images: user.photoURL!,
      //       location: '',
      //       time: '',
      //       phone: user.phoneNumber ?? '',
      //       email: user.email ?? '',
      //       address: '',
      //     ),
      //   );

    } catch (err) {
      print(err);
    }
    kFirebaseAnalytics.logLogin();
    if (mounted) {
      setState(() => _user = user);
      print('mouted user = $mounted');
    }

    return user;
  }

  // Sign in with Facebook.
  Future _loginWithFacebook() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final facebookAuthCredential = FacebookAuthProvider.credential(
        facebookLoginResult.accessToken!.token,
      );
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      print('userData = ${userData}');
      final _auth = firebase_auth.FirebaseAuth.instance;
      firebase_auth.User? _user;
      _user = _auth.currentUser;
      final userData1 = await FirebaseFirestore.instance
          .collection('cars')
          .doc(_user!.uid)
          .get();
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() {
          _currentPosition = position;
          print('CURRENT POS: $_currentPosition');
          print('end mapController');
        });
      }).catchError((e) {
        print(e);
      });

      print("user = $_user");
      if (userData1.data() == null) {
        print('login facebook car');
        await db.setCars(
          //ใช้ setProduct เพื่อเพิ่มหรือแก้ไขเอกสารไปยังฐานข้อมูล Cloud Firestore
          
          cars: CarsModel(
            id: _user.uid,
            userName: '${_user.displayName}',
            state: false,
            statejob: false,
            images: _user.photoURL!,
            cartype: '',
            location:
                GeoPoint(_currentPosition.latitude, _currentPosition.longitude),
            time: '',
            distance: '',
            cost: '',
            phone: _user.phoneNumber ?? '',
            email: _user.email ?? '',
            address: '',
          ),
        );
      }
      db.setStateLogin(stateuser: StateLoginModel(user: false, car: true));
    } catch (e) {
      print('ล็อกอินเข้าสู่ระบบผ่าน Facebook ผิดพลาด $e');
    }
  }
}
