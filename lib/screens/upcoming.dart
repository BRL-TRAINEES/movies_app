import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/listdisplay/sliderlist.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List<Map<String, dynamic>> upcoming = [];
  var upcomingurl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${dotenv.env['tmdbapikey']}';

  Future<void> UpcomingFunction() async {
    var upcomingresponse = await http.get(Uri.parse(upcomingurl));
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
    return FutureBuilder(
        future: UpcomingFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 211, 239, 33),
              ),
            );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(upcoming, "Upcoming", 'movie', 20),
                ]);
          }
        });
  }
}
