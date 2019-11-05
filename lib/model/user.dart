class User {
  int id;
  String name;

  User(this.id, this.name);

  User.initial()
      : id = 0,
        name = '';
}
