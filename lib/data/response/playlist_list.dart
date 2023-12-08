class PlaylistsList {
  String? query;
  Playlists? playlists;

  PlaylistsList({this.query, this.playlists});

  PlaylistsList.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    playlists = json['playlists'] != null
        ? new Playlists.fromJson(json['playlists'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    if (this.playlists != null) {
      data['playlists'] = this.playlists!.toJson();
    }
    return data;
  }
}

class Playlists {
  int? totalCount;
  List<PlaylistItems>? items;
  PagingInfo? pagingInfo;

  Playlists({this.totalCount, this.items, this.pagingInfo});

  Playlists.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <PlaylistItems>[];
      json['items'].forEach((v) {
        items!.add(new PlaylistItems.fromJson(v));
      });
    }
    pagingInfo = json['pagingInfo'] != null
        ? new PagingInfo.fromJson(json['pagingInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class PlaylistItems {
  Data? data;

  PlaylistItems({this.data});

  PlaylistItems.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  Images? images;
  Owner? owner;

  Data({this.uri, this.name, this.description, this.images, this.owner});

  Data.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    name = json['name'];
    description = json['description'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Images {
  List<Items>? items;

  Images({this.items});

  Images.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  List<Sources>? sources;

  Items({this.sources});

  Items.fromJson(Map<String, dynamic> json) {
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

class Owner {
  String? name;

  Owner({this.name});

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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