import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        'https://api.themoviedb.org/3/movie/popular?api_key=${dotenv.env['tmdbapikey']}';
    var nowplayingmoviesurl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=${dotenv.env['tmdbapikey']}';
    var topratedmoviesurl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${dotenv.env['tmdbapikey']}';

    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var temp = jsonDecode(popularmoviesresponse.body);
      var popularMovies = temp['results'];
      for (var i = 0; i < popularMovies.length; i++) {
        popularmovies.add({
          "name": popularMovies[i]["title"],
          "poster_path": popularMovies[i]["poster_path"],
          "vote_average": popularMovies[i]["vote_average"],
          "Date": popularMovies[i]["release_date"],
          "id": popularMovies[i]["id"],
        });
      }
    }

    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var temp = jsonDecode(topratedmoviesresponse.body);
      var topratedMovies = temp['results'];
      for (var i = 0; i < topratedMovies.length; i++) {
        topratedmovies.add({
          "name": topratedMovies[i]["title"],
          "poster_path": topratedMovies[i]["poster_path"],
          "vote_average": topratedMovies[i]["vote_average"],
          "Date": topratedMovies[i]["release_date"],
          "id": topratedMovies[i]["id"],
        });
      }
    }

    var nowplayingmoviesresponse =
        await http.get(Uri.parse(nowplayingmoviesurl));
    if (nowplayingmoviesresponse.statusCode == 200) {
      var temp = jsonDecode(nowplayingmoviesresponse.body);
      var nowplayingMovies = temp['results'];
      for (var i = 0; i < nowplayingMovies.length; i++) {
        nowplayingmovies.add({
          "name": nowplayingMovies[i]["title"],
          "poster_path": nowplayingMovies[i]["poster_path"],
          "vote_average": nowplayingMovies[i]["vote_average"],
          "Date": nowplayingMovies[i]["release_date"],
          "id": nowplayingMovies[i]["id"],
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
                child: SpinKitWanderingCubes(
              color: const Color.fromARGB(255, 220, 214, 19),
              size: 50.0,
            ));
          else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(popularmovies, "Popular Now", 'movie', 20),
                  sliderlist(topratedmovies, "Top Rated", 'movie', 20),
                  sliderlist(nowplayingmovies, "Now Playing", 'movie', 20),
                ]);
          }
        });
  }
}
