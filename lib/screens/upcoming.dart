import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/apiKey/apiLinks.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List<Map<String, dynamic>> upcoming = [];

  Future<void> Upcoming() async {
    var upcomingresponse = await http.get(Uri.parse(popularseriesurl));
    if (upcomingresponse.statusCode == 200) {
      var temp = jsonDecode(upcomingresponse.body);
      var upcomingdata = temp['results'];
      for (var i = 0; i < upcomingdata.length; i++) {
        upcoming.add({
          'id': upcomingdata[i]['id'],
          'name': upcomingdata[i]['name'],
          'date': upcomingdata[i]['first_air_date'],
          'poster_path': upcomingdata[i]['poster_path'],
          'vote_average': upcomingdata[i]['vote_average'],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
