import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/apiKey/apiKey.dart';
import 'dart:convert';
import 'package:movie_app/listdisplay/sliderlist.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  List<Map<String, dynamic>> popularseries = [];
  List<Map<String, dynamic>> onairseries = [];
  List<Map<String, dynamic>> topratedseries = [];

  var popularseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=$tmdbapikey';
  var onairseriesurl =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=$tmdbapikey';
  var topratedseriesurl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$tmdbapikey';

  Future<void> SeriesFunction() async {
    var popularseriesresponse = await http.get(Uri.parse(popularseriesurl));
    if (popularseriesresponse.statusCode == 200) {
      var temp = jsonDecode(popularseriesresponse.body);
      var popularseriesdata = temp['results'];
      for (var i = 0; i < popularseriesdata.length; i++) {
        popularseries.add({
          'id': popularseriesdata[i]['id'],
          'name': popularseriesdata[i]['name'],
          'date': popularseriesdata[i]['first_air_date'],
          'poster_path': popularseriesdata[i]['poster_path'],
          'vote_average': popularseriesdata[i]['vote_average'],
        });
      }
    }

    var onairresponse = await http.get(Uri.parse(onairseriesurl));
    if (onairresponse.statusCode == 200) {
      var temp = jsonDecode(onairresponse.body);
      var onairdata = temp['results'];
      for (var i = 0; i < onairdata.length; i++) {
        onairseries.add({
          "name": onairdata[i]["name"],
          "poster_path": onairdata[i]["poster_path"],
          "vote_average": onairdata[i]["vote_average"],
          "Date": onairdata[i]["first_air_date"],
          "id": onairdata[i]["id"],
        });
      }
    }

    var topratedseriesresponse = await http.get(Uri.parse(topratedseriesurl));
    if (topratedseriesresponse.statusCode == 200) {
      var temp = jsonDecode(topratedseriesresponse.body);
      var topratedseriesdata = temp['results'];
      for (var i = 0; i < topratedseriesdata.length; i++) {
        topratedseries.add({
          'id': topratedseriesdata[i]['id'],
          'name': topratedseriesdata[i]['name'],
          'date': topratedseriesdata[i]['first_air_date'],
          'poster_path': topratedseriesdata[i]['poster_path'],
          'vote_average': topratedseriesdata[i]['vote_average'],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SeriesFunction(),
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
                  sliderlist(popularseries, "Popular Now", 'series', 20),
                  sliderlist(topratedseries, "Top Rated", 'series', 20),
                  sliderlist(onairseries, "Now Playing", 'series', 20),
                ]);
          }
        });
  }
}
