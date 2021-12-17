# v_users

เเอปของคนเรียกรถ

## รายระเอียด

ความหมายของเครื่องหมาย

- :heavy_check_mark: คือ ทำเเล้ว
- :x: คือ ยังไม่ได้ทำเเละจำเป็นต้องทำ
- :warning: คือ ยังไม่ได้ทำและไม่จำเป็นต้องทำตอนนี้

## หน้า

### หน้าล็อกอิน

[![image.png](https://i.postimg.cc/xCGTbr8Q/image.png)](https://postimg.cc/zbB19cT2)

#### Design

- :heavy_check_mark: หน้าล็อกอิน

#### ระบบ

- :heavy_check_mark: ล็อกอิน Google
  - :heavy_check_mark: Authentication ระบบยืนยันตัวต้นว่า gmail นี้มีจริง
  - :heavy_check_mark: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
- :warning: ล็อกอิน Facebook
  - :warning: Authentication ระบบยืนยันตัวต้นว่า Facebook นี้มีจริง
  - :warning: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
- :warning: ล็อกอิน Email หรือเเบบพิมพ์ลงไปในชื่อผู้ใช้ และ รหัสผ่าน
  - :warning: Authentication ระบบยืนยันตัวต้นว่า Gmail นี้มีจริง
  - :warning: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
  - :warning: ลืมรหัสผ่าน
- :x: เมื่อไม่เลือก บัญชี Gmail ที่จะล็อกอินแล้วกดย้อนกลับ

### หน้าผู้ใช้เลือกรถ

[![image.png](https://i.postimg.cc/vmtRd5mY/image.png)](https://postimg.cc/zLv2CbW6)

#### Design

- :heavy_check_mark: หน้าผู้ใช้เลือกรถ

#### ระบบ

- :heavy_check_mark: ล็อกเอาท์
- :x: เชื่อมกับ Cloud Firestore ที่เก็บข้อมูลของคนขับ
- :x: แสดงรายการรถทั้งหมดที่พร้อมทำงาน
- :x: เรียงรายการรถที่อยู่ใกล้จากบนลงล่าง โดยกำหนดใน Firebase
- :x: เชื่อม Google Map เพี่อคำนวนระยะทางเพื่อหาเวลาการเดินทางจากคนขับมาหาคนเรียกรถ

### หน้าแสดงรายการคนขับรถที่ผู้ใช้เรียกรถเเล้ว

[![image.png](https://i.postimg.cc/Xvr8fCZj/image.png)](https://postimg.cc/NywmYL7S)

#### Design

- :heavy_check_mark: หน้าแสดงรายการคนขับรถที่ผู้ใช้เรียกรถเเล้ว

#### ระบบ

- :x: เชื่อมกับ Cloud Firestore ที่เก็บข้อมูลของคนขับ
- :x: แสดงรายการรถทั้งหมดที่ผู้ใช้เรียก
- :x: เชื่อม Google Map เพี่อคำนวนระยะทางเพื่อหาเวลาการเดินทางจากคนขับมาหาคนเรียกรถ

### หน้าติดตามรถว่าถึงไหนเเล้ว

[![image.png](https://i.postimg.cc/fRLFPk3F/image.png)](https://postimg.cc/dLb4ksjm)

#### Design

- :heavy_check_mark: หน้าติดตามรถว่าถึงไหนเเล้ว

#### ระบบ

- :warning: โทรผ่านเเอป
- :x: เชื่อมกับ Cloud Firestore ที่เก็บข้อมูลของคนขับ
- :x: แสดงรายระเอียดคนขับรถ
- :x: ยกเลิกงาน
- :x: เชื่อม Google Map เพี่อคำนวนระยะทางเพื่อหาเวลาการเดินทางจากคนขับมาหาคนเรียกรถ