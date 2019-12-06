class Locations {
  Source source;
  String locationid;
  String locationname;
  String map;
  String city;
  String state;
  String rating;

  Locations(
      {this.source,
      this.locationid,
      this.locationname,
      this.map,
      this.city,
      this.state,
      this.rating});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
        source: Source.fromJson(json["source"]),
        locationid: json["locationid"],
        locationname: json["locationname"],
        map: json["map"],
        city: json["city"],
        state: json["state"],
        rating: json["rating"]);
  }
}

class Source {
  String locationid;
  String locationname;

  Source({this.locationid, this.locationname});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      locationid: json["locationid"] as String,
      locationname: json["locationname"] as String,
    );
  }
}
