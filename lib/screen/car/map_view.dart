import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:v_users/models/cars_model.dart';
import 'package:v_users/models/user_model.dart';
import 'package:v_users/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class MapView extends StatefulWidget {
  final index;
  const MapView({Key? key, this.index}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Database db = Database.instance;
  CollectionReference carscollection =
      FirebaseFirestore.instance.collection('cars');
  final _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? _user;
  var curl;

  String? id;
  String? userName;
  bool? state;
  bool? statejob;
  String? images;
  String? cartype;
  GeoPoint? location;
  String? time;
  String? distance;
  String? cost;
  String? phone;
  String? email;
  var positionlatitude;
  var positionlongitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<CarsModel>> getCars = db.getCars();
    Stream<List<UsersModel>> getCarsGetJob = db.getCarsGetJob();

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: StreamBuilder<List<CarsModel>>(
          stream: getCars,
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ระยะทาง ${snapshot1.data?[widget.index].distance}'),
                  Text('เวลา ${snapshot1.data?[widget.index].time}')
                ],
              );
            }
            return CircularProgressIndicator();
          }),
      body: StreamBuilder<List<UsersModel>>(
          stream: getCarsGetJob,
          builder: (context, snapshot2) {
            if (snapshot2.hasData) {
              print('getCarsGetJob');
              return FutureBuilder<DocumentSnapshot>(
                  future: carscollection.doc('${_user?.uid}').get(),
                  builder: (context, snapshot3) {
                    if (snapshot3.hasError) {
                      return Text("Something went wrong");
                    }
                    if (snapshot3.hasData) {
                      if (snapshot3.connectionState == ConnectionState.done) {
                        print('FutureBuilder');
                        if (snapshot3.data!.data() != null) {
                          Map<String, dynamic> data =
                              snapshot3.data!.data() as Map<String, dynamic>;
                          this.id = data['id'];
                          this.userName = data['userName'];
                          this.state = data['state'];
                          this.statejob = data['statejob'];
                          this.images = data['images'];
                          this.cartype = data['cartype'];
                          this.location = data['location'];
                          this.time = data['time'];
                          this.distance = data['distance'];
                          this.cost = data['cost'];
                          this.phone = data['phone'];
                          this.email = data['email'];
                          print(
                              'map data["location"].latitude ${data["location"].latitude}');
                          return GoogleMapsWidget(
                              apiKey: "AIzaSyDTd1w6YJIqbEg2Mxt-oBtB11X-EH9MJso",
                              sourceLatLng: LatLng(data["location"].latitude,
                                  data["location"].longitude),
                              destinationLatLng: LatLng(
                                  snapshot2
                                      .data![widget.index].location!.latitude,
                                  snapshot2
                                      .data![widget.index].location!.longitude),
                              routeWidth: 5,
                              routeColor: Colors.red,
                              sourceMarkerIconInfo: MarkerIconInfo(
                                assetPath: "assets/images/profile.png",
                                assetMarkerSize: Size.square(10),
                              ),
                              destinationMarkerIconInfo: MarkerIconInfo(
                                assetPath:
                                    "assets/images/119144250_2707083406197058_4036648299533454283_n 1.png",
                                assetMarkerSize: Size.square(50),
                              ),
                              driverMarkerIconInfo: MarkerIconInfo(
                                assetPath: "assets/images/car.png",
                                assetMarkerSize: Size.square(50),
                              ),
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              // mock stream
                              // driverCoordinatesStream:
                              //     Stream.periodic(Duration(seconds: 1), (i) {
                              //   print(
                              //       'positionlatitude.latitude: ${positionlatitude} , ${positionlongitude}');
                              //   if (positionlatitude != null) {
                              //     return LatLng(
                              //       19.0257631 + i/10000 , 99.9231893 - i/10000

                              //     );
                              //   }
                              //   return LatLng(
                              //     i.toDouble(),
                              //     i.toDouble(),
                              //   );
                              // }),
                              sourceName: "${data['userName']}",
                              driverName: "คนขับกำลังเดินทาง",
                              destinationName:
                                  "${snapshot2.data?[widget.index].userName}",

                              // การเอียง
                              tiltGesturesEnabled: true,
                              // เปิดปิดจราจร
                              trafficEnabled: false,
                              // เมื่อกดmakerของต้นทาง
                              onTapSourceMarker: (onTapSourceMarker1) {
                                print("onTapSourceMarker $onTapSourceMarker1");
                              },
                              // เมื่อกดmakerของปลายทาง
                              onTapDestinationMarker:
                                  (onTapDestinationMarker1) {
                                print(
                                    "onTapDestinationMarker $onTapDestinationMarker1");
                              },
                              onTapDriverMarker: (currentLocation) {
                                print(
                                    "Driver is currently at $currentLocation");
                                curl = currentLocation;
                              },
                              // เมื่อกดwidnowของจุดเริ่มต้น
                              onTapSourceInfoWindow: (onTapSourceInfoWindow1) {
                                print(
                                    "onTapSourceInfoWindow $onTapSourceInfoWindow1");
                              },
                              // เมื่อกดwidnowของจุดปลายทาง
                              onTapDestinationInfoWindow:
                                  (onTapDestinationInfoWindow1) {
                                print(
                                    "onTapDestinationInfoWindow $onTapDestinationInfoWindow1");
                              },
                              // เมื่อกดwidnowของคนขับ
                              onTapDriverInfoWindow: (onTapDriverInfoWindow1) {
                                print(
                                    "onTapDriverInfoWindow $onTapDriverInfoWindow1");
                              },
                              // เวลาในการเดินทาง
                              totalTimeCallback: (time) {
                                db.updateCarsTime(
                                    cars: CarsModel(time: '$time'));
                              },
                              // ระยะทาง
                              totalDistanceCallback: (distance) {
                                db.updateCarsDistance(
                                    cars: CarsModel(distance: '$distance'));
                              });
                        }
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }
}
