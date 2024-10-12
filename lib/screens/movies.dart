import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/apiKey/apiLinks.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popularmovies = [];

  Future<void> MoviesFunction() async {
    var popularmovieresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmovieresponse.statusCode == 200) {
      var temp = jsonDecode(popularmovieresponse.body);
      var popularmoviedata = temp['results'];
      for (var i = 0; i < popularmoviedata.length; i++) {
        popularmovies.add({
          'id': popularmoviedata[i]['id'],
          'name': popularmoviedata[i]['name'],
          'date': popularmoviedata[i]['first_air_date'],
          'poster_path': popularmoviedata[i]['poster_path'],
          'vote_average': popularmoviedata[i]['vote_average'],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
