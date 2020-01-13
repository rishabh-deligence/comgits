class Committer {
  final String name;
  final String email;
  final String date;

  Committer({this.name, this.email, this.date});

  factory Committer.fromJson(Map<String, dynamic> json) {
    return Committer(
      name: json['name'],
      email: json['email'],
      date: json['date'],
    );
  }
}