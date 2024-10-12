import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/apiKey/apiLinks.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, dynamic>> trending = [];

  Future<void> trendinghome() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            toolbarHeight: 60,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                  future: trendinghome(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            height: MediaQuery.of(context).size.height),
                        items: trending.map((i) {
                          return Builder(builder: (BuilderContext) {
                            return GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.darken),
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/original/${i['poster_path']}'),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trending',
                  style: TextStyle(
                      color: Color.fromARGB(214, 237, 231, 231),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 12,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
