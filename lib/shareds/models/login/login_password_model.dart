class LoginPasswordModel{

  String login;
  String password;

  LoginPasswordModel();

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    return data;
  }

}
