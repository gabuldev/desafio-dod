class Dod {
  String id;
  String nome;
  String photoUrl;

  Dod({this.id, this.nome, this.photoUrl});

  Dod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['name'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.nome;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}
