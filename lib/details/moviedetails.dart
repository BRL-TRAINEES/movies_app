import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/apiKey/apiKey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/screens/homescreen.dart';

class Moviedetails extends StatefulWidget {
  var movieid;
  Moviedetails(this.movieid);

  @override
  State<Moviedetails> createState() => _MoviedetailsState();
}

class _MoviedetailsState extends State<Moviedetails> {
  List<Map<String, dynamic>> MovieDetails = [];
  // List<Map<String, dynamic>> movietrailers = [];
  // List<Map<String, dynamic>> UserReviews = [];
  // List<Map<String, dynamic>> similarmovies = [];
  // List<Map<String, dynamic>> recommendedmovies = [];

  List MovieGeneres = [];

  Future Moviedetails() async {
    var moviedetailurl = 'https://api.themoviedb.org/3/movie/' +
        widget.movieid.toString() +
        '?api_key=$tmdbapikey';
    // var movietrailersurl = 'https://api.themoviedb.org/3/movie/' +
    //     widget.movieid.toString() +
    //     '/videos?api_key=$tmdbapikey';
    // var UserReviewurl = 'https://api.themoviedb.org/3/movie/' +
    //     widget.movieid.toString() +
    //     '/reviews?api_key=$tmdbapikey';
    // var similarmoviesurl = 'https://api.themoviedb.org/3/movie/' +
    //     widget.movieid.toString() +
    //     '/similar?api_key=$tmdbapikey';
    // var recommendedmoviesurl = 'https://api.themoviedb.org/3/movie/' +
    //     widget.movieid.toString() +
    //     '/recommendations?api_key=$tmdbapikey';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetail = jsonDecode(moviedetailresponse.body);
      for (var i = 0; i < 1; i++) {
        MovieDetails.add({
          "backdrop_path": moviedetail['backdrop_path'],
          "title": moviedetail['title'],
          "vote_average": moviedetail['vote_average'],
          "overview": moviedetail['overview'],
          "release_date": moviedetail['release_date'],
          "runtime": moviedetail['runtime'],
          "budget": moviedetail['budget'],
          "revenue": moviedetail['revenue'],
        });
      }
      for (var i = 0; i < moviedetail['genres'].length; i++) {
        MovieGeneres.add(moviedetail['genres'][i]['name']);
      }
    }
    // var UserReviewresponse = await http.get(Uri.parse(UserReviewurl));
    // if (UserReviewresponse.statusCode == 200) {
    //   var temp = jsonDecode(UserReviewresponse.body);
    //   var userreview = temp['results'];

    //   for (var i = 0; i < userreview.length; i++) {
    //     UserReviews.add({
    //       "name": userreview[i]['author'],
    //       "review": userreview[i]['content'],
    //       "rating": userreview[i]['author_details']['rating'] == null
    //           ? "Not Rated"
    //           : userreview[i]['author_details']['rating'].toString(),
    //       "avatarphoto": userreview[i]['author_details']['avatar_path'] == null
    //           ? "https://png.pngitem.com/pimgs/s/24-248235_user-profile-avatar-login-account-fa-user-circle.png"
    //           : "https://image.tmdb.org/t/p/w500" +
    //               userreview[i]['author_details']['avatar_path'],
    //       "creationdate": userreview[i]['created_at'].substring(0, 10),
    //       "fullreviewurl": userreview[i]['url'],
    //     });
    //   }
    // }

    // var similarmoviesresponse = await http.get(Uri.parse(similarmoviesurl));
    // if (similarmoviesresponse.statusCode == 200) {
    //   var temp = jsonDecode(similarmoviesresponse.body);
    //   var similarmovies = temp['results'];
    //   for (var i = 0; i < similarmovies.length; i++) {
    //     similarmovies.add({
    //       "poster_path": similarmovies[i]['poster_path'],
    //       "name": similarmovies[i]['title'],
    //       "vote_average": similarmovies[i]['vote_average'],
    //       "Date": similarmovies[i]['release_date'],
    //       "id": similarmovies[i]['id'],
    //     });
    //   }
    // }

    // var movietrailersresponse = await http.get(Uri.parse(movietrailersurl));
    // if (movietrailersresponse.statusCode == 200) {
    //   var temp = jsonDecode(movietrailersresponse.body);
    //   var movietrailers = temp['results'];
    //   for (var i = 0; i < movietrailers.length; i++) {
    //     if (movietrailers[i]['type'] == "Trailer") {
    //       movietrailers.add({
    //         "key": movietrailers[i]['key'],
    //       });
    //     }
    //   }
    //   movietrailers.add({'key': 'aJ0cZTcTh90'});
    // }

    // var recommendedmoviesresponse =
    //     await http.get(Uri.parse(recommendedmoviesurl));
    // if (recommendedmoviesresponse.statusCode == 200) {
    //   var temp = jsonDecode(recommendedmoviesresponse.body);
    //   var recommendedmovies = temp['results'];
    //   for (var i = 0; i < recommendedmovies.length; i++) {
    //     recommendedmovies.add({
    //       "poster_path": recommendedmovies[i]['poster_path'],
    //       "name": recommendedmovies[i]['title'],
    //       "vote_average": recommendedmovies[i]['vote_average'],
    //       "Date": recommendedmovies[i]['release_date'],
    //       "id": recommendedmovies[i]['id'],
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        body: FutureBuilder(
            future: Moviedetails(),
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
                                      'https://image.tmdb.org/t/p/original/${MovieDetails[0]['backdrop_path']}'),
                                ),
                              ),
                            ),
                            // child: trailer(
                            //   movietrailers[0]['key'],
                            // ),
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
                                        itemCount: MovieGeneres.length,
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
                                              child: Text(MovieGeneres[index]));
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
                                      child: Text(MovieDetails[0]['runtime']
                                              .toString() +
                                          ' minutes'))
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
                              child:
                                  Text(MovieDetails[0]['overview'].toString())),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            // child: Review(UserReviews),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text('Release Date : ' +
                                  MovieDetails[0]['release_date'].toString())),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text('Budget : ' +
                                  MovieDetails[0]['budget'].toString())),
                          Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text('Revenue : ' +
                                  MovieDetails[0]['revenue'].toString())),
                          // sliderlist(similarmovies, "Similar Movies", "movie",
                          //     similarmovies.length),
                          // sliderlist(recommendedmovies, "Recommended Movies",
                          //     "movie", recommendedmovies.length),
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
