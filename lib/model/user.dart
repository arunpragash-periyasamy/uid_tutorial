class User {
  int? id;
  String? name;
  String? contact;
  String? description;

  User({this.id, this.name, this.contact, this.description});

  factory User.fromMap(Map<String, dynamic> json) {
    int id = json['id'];
    String name = json['name'];
    String contact = json['contact'];
    String description = json['description'];
    return User(id: id, name: name, contact: contact, description: description);
  }
}
