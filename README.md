# v_users

เเอปของคนเรียกรถและคนขับรถ

## รายระเอียด

ความหมายของเครื่องหมาย

- :heavy_check_mark: คือ ทำเเล้ว
- :x: คือ ยังไม่ได้ทำเเละจำเป็นต้องทำ
- :warning: คือ ยังไม่ได้ทำและไม่จำเป็นต้องทำตอนนี้

## หน้า User

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
  - :heavy_check_mark: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้ *(update 19/12/64) อาร์ม*
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
## หน้า Car

### หน้าล็อกอิน

[![image.png](https://i.postimg.cc/xCGTbr8Q/image.png)](https://postimg.cc/zbB19cT2)

#### Design

- :heavy_check_mark: หน้าล็อกอิน

#### ระบบ

- :heavy_check_mark: ล็อกอิน Google
  - :heavy_check_mark: Authentication ระบบยืนยันตัวต้นว่า gmail นี้มีจริง
  - :heavy_check_mark: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
- :heavy_check_mark: ล็อกอิน Facebook *(update 26/12/64) อาร์ม*
  - :heavy_check_mark: Authentication ระบบยืนยันตัวต้นว่า Facebook นี้มีจริง *(update 26/12/64) อาร์ม*
  - :heavy_check_mark: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้ *(update 26/12/64) อาร์ม*
- :warning: ล็อกอิน Email หรือเเบบพิมพ์ลงไปในชื่อผู้ใช้ และ รหัสผ่าน
  - :warning: Authentication ระบบยืนยันตัวต้นว่า Gmail นี้มีจริง
  - :warning: Cloud Firestore เก็บข้อมูลผู้ใช้ที่สมัครไว้
  - :warning: ลืมรหัสผ่าน
- :heavy_check_mark: เมื่อไม่เลือก บัญชี Gmail ที่จะล็อกอินแล้วกดย้อนกลับ *(update 26/12/64) อาร์ม*

### หน้าเลือกรับงาน

[![image.png](https://i.postimg.cc/8cS1FmqJ/image.png)](https://postimg.cc/tZB0wWRp)

#### Design

- :heavy_check_mark: หน้าเลือกรับงาน

#### ระบบ

- :heavy_check_mark: แสดงข้อมูลงานทั้งหมด
- :heavy_check_mark: เชื่อมต่อ Cloud Firestore ที่เก็บข้อมูลของงานที่จะรับ
- :heavy_check_mark: เปิดปิดสถาะว่ารับงานหรือไม่รับงานถ้าไม่รับงานก็จะไม่แสดงบนหน้าจอของคนให้งาน
- :heavy_check_mark: ล็อกเอาท์
- :heavy_check_mark: ฟังชันรับงาน
- :heavy_check_mark: ฟังชันขออนุญาติผู้ใช้เปิดตำแหน่ง Location (GPS)
- :warning: ดูรายระเอีดยเพิ่มเติมของคนให้งาน

### หน้ารอกดเริ่มงาน

[![image.png](https://i.postimg.cc/1zFhpN0p/image.png)](https://postimg.cc/TyT4x14w)

#### Design

- :heavy_check_mark: หน้ารอกดเริ่มงาน

#### ระบบ

- :heavy_check_mark: เชื่อมต่อ Cloud Firestore ที่เก็บข้อมูลของงานที่จะรับ
- :heavy_check_mark: แสดงข้อมูลของผู้ให้งาน
- :heavy_check_mark: ฟังชันยกเลิกงาน
- :heavy_check_mark: ฟังชันเริ่มงาน
- :warning: โทรภายในแอป
- :warning: ฟังชันเสร็จงาน

### หน้านำทาง

[![image.png](https://i.postimg.cc/NMbNTgn6/image.png)](https://postimg.cc/1nnc1ZsX)

#### Design

- :heavy_check_mark: หน้านำทาง

#### ระบบ
- :heavy_check_mark: หาตำแหน่งของผู้ใช้ (My location)
- :heavy_check_mark:เชื่อม Google Map
- :heavy_check_mark: แสดง Google Map
- :heavy_check_mark: แสดงตำแหน่งของผู้ใช้ในปัจจุบัน
- :x: นำทาง ลากเส้นระหว่างตำแหน่งคนขับไปหาคนสั้งงาน
- :x: ฟังชันเสร็จงาน
## หน้าเพิ่มเติม

[![image.png](https://i.postimg.cc/zBTVrXXP/image.png)](https://postimg.cc/8JP1dGvh)

- :heavy_check_mark: เชื่อมหน้าไปยังหน้าล็อกอิน User
- :heavy_check_mark: เชื่อมหน้าไปยังหน้าล็อกอิน Car
- :heavy_check_mark: แก้บัคล็อกอินแล้วไม่ไปหน้ารายการ

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
  - เพิ่มล็อกอิน facebook ของ User และเอาข้อมูลลงใน database
- v0.6 
  - แก้ที่เก็บข้อมูลของคนเรียนรถและคนขับรถสลับกัน
  - เพิ่มเอกสารหัวข้อ อัพเดดเวอร์ชันโปรเจค
  - แก้เอกสาร
- v0.7
  - ทำการรวมเเอปทั้ง 2 เเอปคือ User กับ Car
  - จัดการไฟล์เพิ่มเติ่มเพื่อเพื่อรวมเเอป
  - เพิ่ม login facebook ของ Car
  - แก้บัคการ login google
  - แก้บัคเวลา login google แล้วข้อมูลไปลงใน database ของ car ผิดที่
  - เพิ่มหน้าเลือก User และ Car
  - เพิ่ม collection นำไปใช้ในการควบคุม User กับ Car 
  - แก้เอกสาร