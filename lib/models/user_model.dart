//กำหนด class CarsModel เพื่อใช้เป็น model ในการเชื่อมต่อกับ firebase ใช้กับ การ login เเละสมัครสมาชิก
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? id; //เก็บรหัสสินค้า
  String? userName; //ชื่อ user
  bool? state; //สถานะการรับงาน
  String? images; //ภาพ profile user
  GeoPoint? location; //ตำแหน่งที่ตั้งของคนขับ
  String? time; //เวลาที่ถึง
  String? phone; //เบอร์โทรศัพท์
  String? email; //อีเมล
  String? address; //ที่อยู่
  UsersModel({
    this.id,
    this.userName,
    this.state,
    this.images,
    this.location,
    this.time,
    this.phone,
    this.email,
    this.address,
  });
  factory UsersModel.fromMap(Map<String, dynamic>? users) {
    String id = users?['id'];
    String userName = users?['userName'];
    bool state = users?['state'];
    String images = users?['images'];
    GeoPoint location = users?['location'];
    String time = users?['time'];
    String phone = users?['phone'];
    String email = users?['email'];
    String address = users?['address'];
    return UsersModel(
        id: id,
        userName: userName,
        state: state,
        images: images,
        location: location,
        time: time,
        phone: phone,
        email: email,address: address);
  }
  // เอามาเเปลงเป็น <String, dynamic> เพื่อชื่อกับ firebase ได้เพราะ firebase กำหนด typeให้เป็นอย่างนี้
  // อย่างอื้นไม่ได้เช่น <String, String> ก็จะไม่สามารถเชื่อมได้
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'state': state,
      'images': images,
      'location': location,
      'time': time,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
