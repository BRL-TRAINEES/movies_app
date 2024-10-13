import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/apiKey/apiKey.dart';
import 'package:movie_app/screens/homescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Seriesdetails extends StatefulWidget {
  var seriesid;
  Seriesdetails(this.seriesid);

  @override
  State<Seriesdetails> createState() => _SeriesdetailsState();
}

class _SeriesdetailsState extends State<Seriesdetails> {
  List<Map<String, dynamic>> seriesDetails = [];
  List SeriesGeneres = [];

  Future Seriesdetails() async {
    var seriesdetailurl = 'https://api.themoviedb.org/3/tv/' +
        widget.seriesid.toString() +
        '?api_key=$tmdbapikey';

    var seriesdetailresponse = await http.get(Uri.parse(seriesdetailurl));
    if (seriesdetailresponse.statusCode == 200) {
      var Seriesdetails = jsonDecode(seriesdetailresponse.body);

      for (var i = 0; i < 1; i++) {
        seriesDetails.add({
          "poster_path": Seriesdetails['poster_path'],
          "name": Seriesdetails['name'],
          "vote_average": Seriesdetails['vote_average'],
          "overview": Seriesdetails['overview'],
          "first_air_date": Seriesdetails['first_air_date'],
          "last_air_date": Seriesdetails['last_air_date'],
          "number_of_episodes": Seriesdetails['number_of_episodes'],
          "in_production": Seriesdetails['in_production'],
        });
      }
      for (var i = 0; i < Seriesdetails['genres'].length; i++) {
        SeriesGeneres.add(Seriesdetails['genres'][i]['name']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        body: FutureBuilder(
            future: Seriesdetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(FontAwesomeIcons.circleArrowLeft),
                            iconSize: 28,
                            color: Colors.white),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Homescreen()),
                                    (route) => false);
                              },
                              icon: Icon(FontAwesomeIcons.houseChimneyUser),
                              iconSize: 25,
                              color: Colors.white)
                        ],
                        backgroundColor: Color.fromRGBO(14, 14, 14, 0.622),
                        centerTitle: false,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.3,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original/${seriesDetails[0]['poster_path']}'),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: [
                              Row(children: [
                                Container(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: SeriesGeneres.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      25, 25, 25, 0.89),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  Text(SeriesGeneres[index]));
                                        })),
                              ]),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(25, 25, 25, 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        seriesDetails[0]['number_of_episodes']
                                                .toString() +
                                            ' episodes',
                                      ))
                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                'Description :',
                                style: TextStyle(
                                    color: Color.fromARGB(214, 237, 231, 231),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 20, top: 10, right: 20),
                              child: Text(
                                  seriesDetails[0]['overview'].toString())),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            // child: Review(UserReviews),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text('First Episode Date : ' +
                                  seriesDetails[0]['first_air_date']
                                      .toString())),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text('Latest Episode Date : ' +
                                  seriesDetails[0]['last_air_date']
                                      .toString())),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                  seriesDetails[0]['in_production'] == false
                                      ? 'Series Ended'
                                      : 'Series In Production')),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 244, 194, 47),
                ));
              }
            }));
  }
}
