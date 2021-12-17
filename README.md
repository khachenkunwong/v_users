# v_users

เเอปของคนเรียกรถ

## รายระเอียด

ความหมายของเครื่องหมาย

- :heavy_check_mark: คือ ทำเเล้ว
- :x: คือ ยังไม่ได้ทำเเละจำเป็นต้องทำ
- :warning: คือ ยังไม่ได้ทำและไม่จำเป็นต้องทำตอนนี้

## หน้า
### Login
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

