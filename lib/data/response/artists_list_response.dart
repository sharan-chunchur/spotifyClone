class ArtistsList {
  String? query;
  Artists? artists;

  ArtistsList({this.query, this.artists});

  ArtistsList.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    artists =
    json['artists'] != null ? new Artists.fromJson(json['artists']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    if (this.artists != null) {
      data['artists'] = this.artists!.toJson();
    }
    return data;
  }
}

class Artists {
  int? totalCount;
  List<ArtistsItems>? items;
  PagingInfo? pagingInfo;

  Artists({this.totalCount, this.items, this.pagingInfo});

  Artists.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <ArtistsItems>[];
      json['items'].forEach((v) {
        print(v);
        items!.add( ArtistsItems.fromJson(v));
      });
    }
    pagingInfo = json['pagingInfo'] != null
        ?  PagingInfo.fromJson(json['pagingInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.pagingInfo != null) {
      data['pagingInfo'] = this.pagingInfo!.toJson();
    }
    return data;
  }
}

class ArtistsItems {
  Data? data;

  ArtistsItems({this.data});

  ArtistsItems.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? uri;
  Profile? profile;
  Visuals? visuals;

  Data({this.uri, this.profile, this.visuals});

  Data.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    visuals =
    json['visuals'] != null ? new Visuals.fromJson(json['visuals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.visuals != null) {
      data['visuals'] = this.visuals!.toJson();
    }
    return data;
  }
}

class Profile {
  String? name;

  Profile({this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Visuals {
  AvatarImage? avatarImage;

  Visuals({this.avatarImage});

  Visuals.fromJson(Map<String, dynamic> json) {
    avatarImage = json['avatarImage'] != null
        ? new AvatarImage.fromJson(json['avatarImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatarImage != null) {
      data['avatarImage'] = this.avatarImage!.toJson();
    }
    return data;
  }
}

class AvatarImage {
  List<Sources>? sources;

  AvatarImage({this.sources});

  AvatarImage.fromJson(Map<String, dynamic> json) {
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(new Sources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sources {
  String? url;
  int? width;
  int? height;

  Sources({this.url, this.width, this.height});

  Sources.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class PagingInfo {
  int? nextOffset;
  int? limit;

  PagingInfo({this.nextOffset, this.limit});

  PagingInfo.fromJson(Map<String, dynamic> json) {
    nextOffset = json['nextOffset'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextOffset'] = this.nextOffset;
    data['limit'] = this.limit;
    return data;
  }
}