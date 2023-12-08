class AlbumList {
  List<Albums>? albums;

  AlbumList({this.albums});

  AlbumList.fromJson(Map<String, dynamic> json) {
    if (json['albums'] != null) {
      albums = <Albums>[];
      json['albums'].forEach((v) {
        albums!.add(Albums.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (albums != null) {
      data['albums'] = albums!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Albums {
  String? albumType;
  List<Artists>? artists;
  List<Copyrights>? copyrights;
  ExternalIds? externalIds;
  ExternalUrls? externalUrls;
  List<Genre?>? genres;
  String? id;
  List<Images>? images;
  bool? isPlayable;
  String? label;
  String? name;
  int? popularity;
  String? releaseDate;
  String? releaseDatePrecision;
  int? totalTracks;
  Tracks? tracks;
  String? type;
  String? uri;

  Albums(
      {this.albumType,
        this.artists,
        this.copyrights,
        this.externalIds,
        this.externalUrls,
        this.genres,
        this.id,
        this.images,
        this.isPlayable,
        this.label,
        this.name,
        this.popularity,
        this.releaseDate,
        this.releaseDatePrecision,
        this.totalTracks,
        this.tracks,
        this.type,
        this.uri});

  Albums.fromJson(Map<String, dynamic> json) {
    albumType = json['album_type'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(Artists.fromJson(v));
      });
    }
    if (json['copyrights'] != null) {
      copyrights = <Copyrights>[];
      json['copyrights'].forEach((v) {
        copyrights!.add( Copyrights.fromJson(v));
      });
    }
    externalIds = json['external_ids'] != null
        ?  ExternalIds.fromJson(json['external_ids'])
        : null;
    externalUrls = json['external_urls'] != null
        ?  ExternalUrls.fromJson(json['external_urls'])
        : null;
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres!.add( Genre.fromJson(v));
      });
    }
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add( Images.fromJson(v));
      });
    }
    isPlayable = json['is_playable'];
    label = json['label'];
    name = json['name'];
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    releaseDatePrecision = json['release_date_precision'];
    totalTracks = json['total_tracks'];
    tracks =
    json['tracks'] != null ? Tracks.fromJson(json['tracks']) : null;
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_type'] = this.albumType;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    if (this.copyrights != null) {
      data['copyrights'] = this.copyrights!.map((v) => v.toJson()).toList();
    }
    if (this.externalIds != null) {
      data['external_ids'] = this.externalIds!.toJson();
    }
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v?.toJson()).toList();
    }
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['is_playable'] = this.isPlayable;
    data['label'] = this.label;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['release_date'] = this.releaseDate;
    data['release_date_precision'] = this.releaseDatePrecision;
    data['total_tracks'] = this.totalTracks;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.toJson();
    }
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Genre {
  static Genre? fromJson(v) {}

  toJson() {}
}

class Artists {
  ExternalUrls? externalUrls;
  String? id;
  String? name;
  String? type;
  String? uri;

  Artists({this.externalUrls, this.id, this.name, this.type, this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Copyrights {
  String? text;
  String? type;

  Copyrights({this.text, this.type});

  Copyrights.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}

class ExternalIds {
  String? upc;

  ExternalIds({this.upc});

  ExternalIds.fromJson(Map<String, dynamic> json) {
    upc = json['upc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upc'] = this.upc;
    return data;
  }
}

class Images {
  int? height;
  String? url;
  int? width;

  Images({this.height, this.url, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}

class Tracks {
  List<Items>? items;
  int? limit;
  Null? next;
  int? offset;
  Null? previous;
  int? total;

  Tracks(
      {this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total});

  Tracks.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['limit'] = this.limit;
    data['next'] = this.next;
    data['offset'] = this.offset;
    data['previous'] = this.previous;
    data['total'] = this.total;
    return data;
  }
}

class Items {
  List<Artists>? artists;
  int? discNumber;
  int? durationMs;
  bool? explicit;
  ExternalUrls? externalUrls;
  String? id;
  bool? isLocal;
  bool? isPlayable;
  String? name;
  String? previewUrl;
  int? trackNumber;
  String? type;
  String? uri;

  Items(
      {this.artists,
        this.discNumber,
        this.durationMs,
        this.explicit,
        this.externalUrls,
        this.id,
        this.isLocal,
        this.isPlayable,
        this.name,
        this.previewUrl,
        this.trackNumber,
        this.type,
        this.uri});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    discNumber = json['disc_number'];
    durationMs = json['duration_ms'];
    explicit = json['explicit'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    id = json['id'];
    isLocal = json['is_local'];
    isPlayable = json['is_playable'];
    name = json['name'];
    previewUrl = json['preview_url'];
    trackNumber = json['track_number'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    data['disc_number'] = this.discNumber;
    data['duration_ms'] = this.durationMs;
    data['explicit'] = this.explicit;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['id'] = this.id;
    data['is_local'] = this.isLocal;
    data['is_playable'] = this.isPlayable;
    data['name'] = this.name;
    data['preview_url'] = this.previewUrl;
    data['track_number'] = this.trackNumber;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}