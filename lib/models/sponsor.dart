import '../core/res/strings.dart';

/// Model to get All Info about Sponsor
class Sponsor {
  //int data
  int id;
  int year;
  //string data
  String name;
  String details;
  String picUrl;
  String contact;
  String website;
  String sponsType;

  Sponsor({
    this.id,
    this.name,
    this.details,
    this.picUrl,
    this.contact,
    this.website,
    this.sponsType,
    this.year,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json[S.sponsorId],
      name: json[S.sponsorName],
      details: json[S.sponsorDetails],
      picUrl: json[S.sponsorPicUrl],
      contact: json[S.sponsorContact],
      website: json[S.sponsorWebsite],
      sponsType: json[S.sponsorSponsType],
      year: json[S.sponsorYear],
    );
  }
}
