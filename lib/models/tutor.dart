class Tutor {
  String? tutorid;
  String? tutorname;
  String? tutoremail;
  String? tutorphone;
  String? tutordescription;

  Tutor({
    this.tutorid,
    this.tutorname,
    this.tutoremail,
    this.tutorphone,
    this.tutordescription,
  });

  Tutor.fromJson(Map<String, dynamic> json) {
    tutorid = json['tutorid'];
    tutorname = json['tutorname'];
    tutoremail = json['tutoremail'];
    tutorphone = json['tutorphone'];
    tutordescription = json['tutordescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutorid'] = tutorid;
    data['tutorname'] = tutorname;
    data['tutoremail'] = tutoremail;
    data['tutorphone'] = tutorphone;
    data['tutordescription'] = tutordescription;
    return data;
  }
}
