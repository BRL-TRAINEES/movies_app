import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/apiKey/apiKey.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/details/moviedetails.dart';
import 'package:movie_app/details/seriesdetails.dart';
import 'package:movie_app/screens/movies.dart';
import 'package:movie_app/screens/series.dart';
import 'package:movie_app/screens/upcoming.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  List<Map<String, dynamic>> trending = [];
  String trendingweekurl =
      'https://api.themoviedb.org/3/trending/all/week?api_key=$tmdbapikey';
  String trendingdayurl =
      'https://api.themoviedb.org/3/trending/all/day?api_key=$tmdbapikey';

  Future<void> trendinghome() async {
    if (val == 1) {
      var trendingweekresponse = await http.get(Uri.parse(trendingweekurl));
      if (trendingweekresponse.statusCode == 200) {
        var temp = jsonDecode(trendingweekresponse.body);
        var trendingweekdata = temp['results'];
        for (var i = 0; i < trendingweekdata.length; i++) {
          trending.add({
            'id': trendingweekdata[i]['id'],
            'poster_path': trendingweekdata[i]['poster_path'],
            'vote_average': trendingweekdata[i]['vote_average'],
            'media_type': trendingweekdata[i]['media_type'],
            'indexno': i,
          });
        }
      }
    } else if (val == 2) {
      var trendingdayresponse = await http.get(Uri.parse(trendingdayurl));
      if (trendingdayresponse.statusCode == 200) {
        var temp = jsonDecode(trendingdayresponse.body);
        var trendingdaydata = temp['results'];
        for (var i = 0; i < trendingdaydata.length; i++) {
          trending.add({
            'id': trendingdaydata[i]['id'],
            'poster_path': trendingdaydata[i]['poster_path'],
            'vote_average': trendingdaydata[i]['vote_average'],
            'media_type': trendingdaydata[i]['media_type'],
            'indexno': i,
          });
        }
      }
    }
  }

  int val = 1;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                  future: trendinghome(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          height: MediaQuery.of(context).size.height,
                          viewportFraction: 1.0,
                        ),
                        items: trending.map((i) {
                          return Builder(builder: (BuilderContext) {
                            return GestureDetector(
                              onTap: () {
                                if (i['media_type'] == 'movie') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Moviedetails(i['id'])));
                                } else if (i['media_type'] == 'tv') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Seriesdetails(i['id'])));
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.darken),
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/original/${i['poster_path']}'),
                                  ),
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 211, 239, 33),
                        ),
                      );
                    }
                  }),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Trending',
                  style: TextStyle(
                      color: Color.fromARGB(214, 237, 231, 231),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: DropdownButton(
                        value: val,
                        dropdownColor: Color.fromRGBO(0, 0, 0, 0.437),
                        autofocus: true,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: const Color.fromARGB(255, 203, 243, 28),
                          size: 30,
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'This Week',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Today',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            value: 2,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            trending.clear();
                            val = int.parse(
                              value.toString(),
                            );
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text('Movies'),
                  ),
                  Tab(
                    child: Text('Series'),
                  ),
                  Tab(
                    child: Text('Upcoming'),
                  ),
                ],
              ),
            ),
            Container(
              height: 1000,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Movies(),
                  Series(),
                  Upcoming(),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
