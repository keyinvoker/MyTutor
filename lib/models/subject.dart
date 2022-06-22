class Subject {
  String? subjectid;
  String? subjectname;
  String? subjectdescription;
  String? subjectprice;
  String? subjecttutorid;
  String? subjectsessions;
  String? subjectrating;
  String? subjecttutor;

  Subject({
    this.subjectid,
    this.subjectname,
    this.subjectdescription,
    this.subjectprice,
    this.subjecttutorid,
    this.subjectsessions,
    this.subjectrating,
    this.subjecttutor,
  });

  Subject.fromJson(Map<String, dynamic> json) {
    subjectid = json['subjectid'];
    subjectname = json['subjectname'];
    subjectdescription = json['subjectdescription'];
    subjectprice = json['subjectprice'];
    subjecttutorid = json['subjecttutorid'];
    subjectsessions = json['subjectsessions'];
    subjectrating = json['subjectrating'];
    subjecttutor = json['subjecttutor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectid'] = subjectid;
    data['subjectname'] = subjectname;
    data['subjectdescription'] = subjectdescription;
    data['subjectprice'] = subjectprice;
    data['subjecttutorid'] = subjecttutorid;
    data['subjectsessions'] = subjectsessions;
    data['subjectrating'] = subjectrating;
    data['subjecttutor'] = subjecttutor;
    return data;
  }
}
