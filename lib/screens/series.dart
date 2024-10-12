import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/apiKey/apiKey.dart';
import 'dart:convert';
import 'package:movie_app/apiKey/apiLinks.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  var populartvseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey';
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 143,
                    top: 15,
                    bottom: 25,
                  ),
                  child: Text(
                    'Popular Series',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            );
          }
        });
  }
}
