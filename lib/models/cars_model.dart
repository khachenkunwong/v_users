//กำหนด class CarsModel เพื่อใช้เป็น model ในการเชื่อมต่อกับ firebase ใช้กับ การ login เเละสมัครสมาชิก
import 'package:cloud_firestore/cloud_firestore.dart';

class CarsModel {
  String? id; //เก็บรหัสสินค้า
  String? userName; //ชื่อ user
  bool? state; //สถานะการรับงาน
  bool? statejob; //สถานะการเปิดรับงาน
  String? images; //ภาพ profile user
  String? cartype; //ประเภทรถ
  GeoPoint? location; //ตำแหน่งที่ตั้งของคนขับ
  String? time; //เวลาที่ถึง
  String? distance; //ระยะทาง
  String? cost; //ค่าบริการ
  String? phone; //เบอร์โทรศัพท์
  String? email; //อีเมล
  String? address; //ที่อยู่
  CarsModel({
    this.id,
    this.userName,
    this.state,
    this.statejob,
    this.images,
    this.cartype,
    this.location,
    this.time,
    this.distance,
    this.cost,
    this.phone,
    this.email,
    this.address,
  });
  factory CarsModel.fromMap(Map<String, dynamic>? users) {
    String id = users?['id'];
    String userName = users?['userName'];
    bool state = users?['state'];
    bool statejob = users?['statejob'];
    String images = users?['images'];
    String cartype = users?['cartype'];
    GeoPoint location = users?['location'];
    String time = users?['time'];
    String distance = users?['distance'];
    String cost = users?['cost'];
    String phone = users?['phone'];
    String email = users?['email'];
    String address = users?['address'];
    return CarsModel(
        id: id,
        userName: userName,
        state: state,
        statejob: statejob,
        images: images,
        cartype: cartype,
        location: location,
        time: time,
        distance: distance,
        cost: cost,
        phone: phone,
        email: email,
        address: address);
  }
  // เอามาเเปลงเป็น <String, dynamic> เพื่อชื่อกับ firebase ได้เพราะ firebase กำหนด typeให้เป็นอย่างนี้
  // อย่างอื้นไม่ได้เช่น <String, String> ก็จะไม่สามารถเชื่อมได้
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'state': state,
      'statejob': statejob,
      'images': images,
      'cartype': cartype,
      'location': location,
      'time': time,
      'distance': distance,
      'cost': cost,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
