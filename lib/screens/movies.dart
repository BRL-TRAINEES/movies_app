import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/apiKey/apiKey.dart';
import 'dart:convert';

import 'package:movie_app/listdisplay/sliderlist.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popularmovies = [];
  List<Map<String, dynamic>> topratedmovies = [];
  List<Map<String, dynamic>> nowplayingmovies = [];

  Future<void> MoviesFunction() async {
    var popularmoviesurl =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
    var nowplayingmoviesurl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
    var topratedmoviesurl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';

    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'];
      for (var i = 0; i < popularmoviesjson.length; i++) {
        popularmovies.add({
          "name": popularmoviesjson[i]["title"],
          "poster_path": popularmoviesjson[i]["poster_path"],
          "vote_average": popularmoviesjson[i]["vote_average"],
          "Date": popularmoviesjson[i]["release_date"],
          "id": popularmoviesjson[i]["id"],
        });
      }
    }

    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmoviesresponse.body);
      var topratedmoviesjson = tempdata['results'];
      for (var i = 0; i < topratedmoviesjson.length; i++) {
        topratedmovies.add({
          "name": topratedmoviesjson[i]["title"],
          "poster_path": topratedmoviesjson[i]["poster_path"],
          "vote_average": topratedmoviesjson[i]["vote_average"],
          "Date": topratedmoviesjson[i]["release_date"],
          "id": topratedmoviesjson[i]["id"],
        });
      }
    }

    var nowplayingmoviesresponse =
        await http.get(Uri.parse(nowplayingmoviesurl));
    if (nowplayingmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(nowplayingmoviesresponse.body);
      var nowplayingmoviesjson = tempdata['results'];
      for (var i = 0; i < nowplayingmoviesjson.length; i++) {
        nowplayingmovies.add({
          "name": nowplayingmoviesjson[i]["title"],
          "poster_path": nowplayingmoviesjson[i]["poster_path"],
          "vote_average": nowplayingmoviesjson[i]["vote_average"],
          "Date": nowplayingmoviesjson[i]["release_date"],
          "id": nowplayingmoviesjson[i]["id"],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MoviesFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 211, 239, 33),
              ),
            );
          else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(popularmovies, "Popular Now", 20),
                  sliderlist(topratedmovies, "Top Rated", 20),
                  sliderlist(nowplayingmovies, "Now Playing", 20),
                ]);
          }
        });
  }
}
