import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final String date;
  final String time;
  final String venue;
  final String iconUrl;
  final int id;
  final String details;

  Event({
    this.name,
    this.date,
    this.time,
    this.venue,
    this.iconUrl,
    this.id,
    this.details,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json[S.eventnameKey] as String,
      date: json[S.eventdateKey] as String,
      time: json[S.eventtimeKey] as String,
      venue: json[S.eventvenueKey] as String,
      iconUrl: json[S.eventiconurlKey] as String,
      id: json[S.eventidKey] as int,
      details: json[S.eventdetailsKey] as String,
    );
  }

  @override
  List<Object> get props => [];
}
