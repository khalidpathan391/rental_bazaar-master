class LandlordModel {
  int id;

  String name;

  String address;
  String mobile;

  String email;
  String reference_code;
  String pic;
  LandlordModel(
    this.id,
    this.name,
    this.address,
    this.mobile,
    this.email,
    this.reference_code,
    this.pic,
  );
  LandlordModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        address = json["address"],
        mobile = json["mobile"],
        email = json["email"],
        reference_code = json["reference_code"],
        pic = json["pic"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "mobile": mobile,
      "email": email,
      "reference_code": reference_code,
      "pic": pic,
    };
  }
}
