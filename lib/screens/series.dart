import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/apiKey/apiLinks.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  List<Map<String, dynamic>> popularseries = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
