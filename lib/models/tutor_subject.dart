class TutorSubject {
  String? subjectname;
  TutorSubject({
    this.subjectname,
  });

  TutorSubject.fromJson(Map<String, dynamic> json) {
    subjectname = json['subjectname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectname'] = subjectname;
    return data;
  }
}
