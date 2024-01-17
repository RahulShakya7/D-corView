class UserModel{
  String? name;
  String? email,userId,userPhone,address;
  UserModel({
    this.name,
    this.email,this.address,this.userId,this.userPhone
});
  Map<String, dynamic> asMap() {

    return {
      'name': name??'',
      'email': email??'',
      'address': address??'',
      'userId': userId??'',
      'userPhone': userPhone??'',

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        userId: map['userId'],
        email: map['email'],
        userPhone: map['userPhone'],
        address: map['address'],
    );
  }
}