class User {
  String _firstName;
  String _lastName;
  String _company;
  String _email;
  String _password;

  User(firstName, lastName,company,email, password) {
    this._firstName = firstName.toString();
    this._lastName = lastName.toString();
    this._company = company.toString();
    this._email = email.toString();
    this._password = password.toString();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['fname'], json['lname'], json['company'], json['email'], json['password']);
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get company => _company;

  set company(String value) {
    _company = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }


}