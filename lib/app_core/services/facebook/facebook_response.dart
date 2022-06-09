class FacebookResponse {
  dynamic name;
  dynamic email;

  // Picture? picture;
  dynamic id;

  FacebookResponse({this.name, this.email,
    // this.picture,
    this.id});

  FacebookResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];

    // picture =
    //     json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;

    // if (picture != null) {
    //   data['picture'] = picture!.toJson();
    // }
    data['id'] = id;
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic height;
  dynamic isSilhouette;
  dynamic url;
  dynamic width;

  Data({this.height, this.isSilhouette, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    isSilhouette = json['is_silhouette'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['is_silhouette'] = isSilhouette;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}
