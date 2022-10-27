class User {
  String? name;
  String? surname;
  String? userName;
  String? emailAddress;
  String? profilePictureUrl;
  bool? allowSetPassword;
  int? userType;
  String? userToken;
  String? lastSeen;
  String? title;
  int? id;

  User(
      {this.name,
        this.surname,
        this.userName,
        this.emailAddress,
        this.profilePictureUrl,
        this.allowSetPassword,
        this.userType,
        this.userToken,
        this.lastSeen,
        this.title,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    userName = json['userName'];
    emailAddress = json['emailAddress'];
    profilePictureUrl = json['profilePictureUrl'];
    allowSetPassword = json['allowSetPassword'];
    userType = json['userType'];
    userToken = json['userToken'];
    lastSeen = json['lastSeen'];
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['userName'] = this.userName;
    data['emailAddress'] = this.emailAddress;
    data['profilePictureUrl'] = this.profilePictureUrl;
    data['allowSetPassword'] = this.allowSetPassword;
    data['userType'] = this.userType;
    data['userToken'] = this.userToken;
    data['lastSeen'] = this.lastSeen;
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }
}

