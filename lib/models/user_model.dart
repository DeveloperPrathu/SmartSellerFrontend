class UserModel{

  String? email;
  String? phone;
  String? fullname;

  UserModel(this.email, this.phone, this.fullname);

  UserModel.fromJson(dynamic json){
    email = json['email'];
    phone = json['phone'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> tojson(){
    var map = <String, dynamic>{};
    map['email'] = email;
    map['phone'] = phone;
    map['fullname'] = fullname;
    return map;
  }
}