class Dod {
  Emissora emissora;

  Dod({this.emissora});

  Dod.fromJson(Map<String, dynamic> json) {
    emissora = json['emissora'] != null
        ? new Emissora.fromJson(json['emissora'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.emissora != null) {
      data['emissora'] = this.emissora.toJson();
    }
    return data;
  }
}

class Emissora {
  List<String> pessoas;
  List<String> objects;
  String finalImage;

  Emissora({this.pessoas, this.objects, this.finalImage});

  Emissora.fromJson(Map<String, dynamic> json) {
    pessoas = json['pessoas'].cast<String>();
    objects = json['objects'].cast<String>();
    finalImage = json['final_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pessoas'] = this.pessoas;
    data['objects'] = this.objects;
    data['final_image'] = this.finalImage;
    return data;
  }
}