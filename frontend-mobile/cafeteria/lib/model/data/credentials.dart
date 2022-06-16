class Credentials {
  final String name;
  final String password;

  Credentials(this.name, this.password);

  Credentials.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'password': password,
      };
}
