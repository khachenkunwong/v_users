//กำหนด class StateLoginModel เพื่อใช้เป็น model ในการเชื่อมต่อกับ firebase ใช้กับ การ login เเละสมัครสมาชิก
class StateLoginModel {
  bool? user; //
  bool? car; //
  
  StateLoginModel({
    this.user,
    this.car,
    
  });
  factory StateLoginModel.fromMap(Map<String, dynamic>? users) {
    bool user = users?['user'];
    bool car = users?['car'];
   
    return StateLoginModel(
        user: user,
        car: car,
        );
  }
  // เอามาเเปลงเป็น <String, dynamic> เพื่อชื่อกับ firebase ได้เพราะ firebase กำหนด typeให้เป็นอย่างนี้
  // อย่างอื้นไม่ได้เช่น <String, String> ก็จะไม่สามารถเชื่อมได้
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'car': car,
      
    };
  }
}
