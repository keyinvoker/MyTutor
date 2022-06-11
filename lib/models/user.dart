class User {
  String? userid;
  String? username;
  String? useremail;
  String? userphone;
  String? useraddress;

  User({
    this.userid,
    this.username,
    this.useremail,
    this.userphone,
    this.useraddress,
  });

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    useremail = json['useremail'];
    userphone = json['userphone'];
    useraddress = json['useraddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['username'] = username;
    data['useremail'] = useremail;
    data['userphone'] = userphone;
    data['useraddress'] = useraddress;
    return data;
  }
}
