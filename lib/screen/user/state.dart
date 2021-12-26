import 'package:flutter/material.dart';
import 'package:v_users/flutter_flow/flutter_flow_theme.dart';
import 'package:v_users/flutter_flow/flutter_flow_widgets.dart';


class StateWidget extends StatefulWidget {
  const StateWidget({Key? key}) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        child: Align(
          alignment: AlignmentDirectional(0, 0),
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
                      '20นาที',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF878787),
                      ),
                    ),
                    Image.asset(
                      'assets/images/lord.png',
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            'นายสุมมุติ สกุล',
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Image.asset(
                        'assets/images/di.png',
                        width: 24,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 7, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'ตำบลเเม่กา อำเภอเมืองพะเยา 56000 ประเทศไทย',
                            style: FlutterFlowTheme.bodyText1,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
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
              Spacer(),
              FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: 'ยกเลิกออเดอร์',
                options: FFButtonOptions(
                  width: 350,
                  height: 40,
                  color: Color(0xFF27AE60),
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
