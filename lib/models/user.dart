class User {
  String displayName;
  String displayLastName;
  String email;
  String location;
  String password;
  String uuid;
  String role;
  double balance;
  String phone;

  User();

  User.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    displayLastName = data['displayLastName'];
    email = data['email'];
    location = data['location'];
    password = data['password'];
    uuid = data['uuid'];
    role = data['role'];
    balance = data['balance'];
    phone = data['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'displayLastName': displayLastName,
      'email': email,
      'location': location,
      'password': password,
      'uuid': uuid,
      'role': role,
      'balance': balance,
      'phone': phone,
    };
  }
}
