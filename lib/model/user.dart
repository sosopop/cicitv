class UserModel {
  UserModel({
    this.userId = "",
    this.userName = "",
    this.avatar = "",
    this.phone = "",
    this.gender = '',
    this.birth = '',
    this.vip = false,
    this.vipEndTime = "",
    this.balance = 0,
    this.income = 0,
    this.viewTimes = 0,
    this.totalViewTimes = 0,
  });
  String userId;
  String userName;
  String avatar;
  String phone;
  String gender;
  String birth;
  bool vip;
  String vipEndTime;
  int balance;
  int income;
  int viewTimes;
  int totalViewTimes;
}
