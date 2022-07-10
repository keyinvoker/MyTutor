class Cart {
  String? cartid;
  String? subjectid;
  String? subjectname;
  String? price;

  Cart({
    this.cartid,
    this.subjectid,
    this.subjectname,
    this.price,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cartid'];
    subjectid = json['subjectid'];
    subjectname = json['subjectname'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartid'] = cartid;
    data['subjectid'] = subjectid;
    data['subjectname'] = subjectname;
    data['price'] = price;
    return data;
  }
}
