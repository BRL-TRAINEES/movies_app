import 'package:flutter/material.dart';
import 'package:movie_app/apiKey/apiKey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Moviedetails extends StatefulWidget {
  var movieid;
  Moviedetails(this.movieid);

  @override
  State<Moviedetails> createState() => _MoviedetailsState();
}

class _MoviedetailsState extends State<Moviedetails> {
  List<Map<String, dynamic>> MovieDetails = [];
  List<Map<String, dynamic>> movietrailers = [];
  List<Map<String, dynamic>> UserReviews = [];
  List<Map<String, dynamic>> similarmovies = [];
  List<Map<String, dynamic>> recommendedmovies = [];

  List MoviesGeneres = [];

  Future Moviedetails() async {
    var moviedetailurl = 'https://api.themoviedb.org/3/movie/' +
        widget.movieid.toString() +
        '?api_key=$tmdbapikey';
    var movietrailersurl = 'https://api.themoviedb.org/3/movie/' +
        widget.movieid.toString() +
        '/videos?api_key=$tmdbapikey';
    var UserReviewurl = 'https://api.themoviedb.org/3/movie/' +
        widget.movieid.toString() +
        '/reviews?api_key=$tmdbapikey';
    var similarmoviesurl = 'https://api.themoviedb.org/3/movie/' +
        widget.movieid.toString() +
        '/similar?api_key=$tmdbapikey';
    var recommendedmoviesurl = 'https://api.themoviedb.org/3/movie/' +
        widget.movieid.toString() +
        '/recommendations?api_key=$tmdbapikey';
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
