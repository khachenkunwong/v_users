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
- :heavy_check_mark: ล็อกอิน Facebook *(update 19/12/64) อาร์ม*
  - :heavy_check_mark: Authentication ระบบยืนยันตัวต้นว่า Facebook นี้มีจริง *(update 19/12/64) อาร์ม*
  - :x: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
- :warning: ล็อกอิน Email หรือเเบบพิมพ์ลงไปในชื่อผู้ใช้ และ รหัสผ่าน
  - :warning: Authentication ระบบยืนยันตัวต้นว่า Gmail นี้มีจริง
  - :warning: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
  - :warning: ลืมรหัสผ่าน
- :heavy_check_mark: เมื่อไม่เลือก บัญชี Gmail ที่จะล็อกอินแล้วกดย้อนกลับ *(update 18/12/64) อาร์ม*

### หน้าผู้ใช้เลือกรถ

[![image.png](https://i.postimg.cc/vmtRd5mY/image.png)](https://postimg.cc/zLv2CbW6)

#### Design

- :heavy_check_mark: หน้าผู้ใช้เลือกรถ

#### ระบบ

- :heavy_check_mark: ล็อกเอาท์
- :heavy_check_mark: เชื่อมกับ Cloud Firestore ที่เก็บข้อมูลของคนขับ *(update 18/12/64) อาร์ม*
- :heavy_check_mark: แสดงรายการรถทั้งหมดที่พร้อมทำงาน *(update 18/12/64) อาร์ม*
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

## อัพเดดเวอร์ชันโปรเจค
- v0.1 
  - ทำ app ในส่วนของ UI ลง
- v0.2 
  - เพิ่ม google map 
  - เปลียนชื่อแพคเกจเเอป 
  - เพิ่ม jsonที่จะเชื่อมกับ firebase 
- v0.3
  - เพิ่มปุ่ม ล็อกเอา
  - เพิ่มเอกสารเขียนคำอธิบาย 
- v0.4
 - เชื่อมกับ databse และแสดงข้อมูล
 - เพิ่มเอกสาร
- v0.5 
  - เพิ่มล็อกอิน facebook และเอาข้อมูลลงใน database
- v0.6 
  - แก้ที่เก็บข้อมูลของคนเรียนรถและคนขับรถสลับกัน
  - เพิ่มเอกสารหัวข้อ อัพเดดเวอร์ชันโปรเจค