import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/details/type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchbarFunction extends StatefulWidget {
  const SearchbarFunction({super.key});

  @override
  State<SearchbarFunction> createState() => _SearchbarFunctionState();
}

class _SearchbarFunctionState extends State<SearchbarFunction> {
  List<Map<String, dynamic>> searchresult = [];

  Future<void> searchfunction(val) async {
    await dotenv.load();
    var searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=${dotenv.env['tmdbapikey']}&query=$val';
    var searchresponse = await http.get(Uri.parse(searchurl));
    if (searchresponse.statusCode == 200) {
      var temp = jsonDecode(searchresponse.body);
      var searchdata = temp['results'];
      for (var i = 0; i < searchdata.length; i++) {
        if (searchdata[i]['id'] != null &&
            searchdata[i]['poster_path'] != null &&
            searchdata[i]['vote_average'] != null &&
            searchdata[i]['media_type'] != null) {
          searchresult.add({
            'id': searchdata[i]['id'],
            'poster_path': searchdata[i]['poster_path'],
            'vote_average': searchdata[i]['vote_average'],
            'media_type': searchdata[i]['media_type'],
            'original_language': searchdata[i]['original_language'],
            'overview': searchdata[i]['overview'],
          });

          if (searchresult.length > 20) {
            searchresult.removeRange(20, searchresult.length);
          }
        } else {
          print('null value found');
        }
      }
    }
  }

  final TextEditingController searchvalue = TextEditingController();
  bool showlist = false;
  var val1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showlist = !showlist;
      },
      child: Padding(
          padding:
              const EdgeInsets.only(left: 12, top: 30, bottom: 30, right: 12),
          child: Column(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  autofocus: false,
                  controller: searchvalue,
                  onSubmitted: (value) {
                    searchresult.clear();
                    setState(
                      () {
                        val1 = value;
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    );
                  },
                  onChanged: (value) {
                    searchresult.clear();
                    setState(
                      () {
                        val1 = value;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchvalue.clear();
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: const Color.fromARGB(255, 237, 184, 27)
                            .withOpacity(0.6),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 237, 184, 27)
                          .withOpacity(0.6),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              searchvalue.text.length > 0
                  ? FutureBuilder(
                      future: searchfunction(val1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                              height: 380,
                              child: ListView.builder(
                                  itemCount: searchresult.length,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      typecheck(
                                                        searchresult[index]
                                                            ['id'],
                                                        searchresult[index]
                                                            ['media_type'],
                                                      )));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            height: 195,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    11, 11, 11, 0.944),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(7),
                                                    ),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            'https://image.tmdb.org/t/p/w500${searchresult[index]['poster_path']}'),
                                                        fit: BoxFit.fill)),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            '${searchresult[index]['media_type']}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.9),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            241,
                                                                            193,
                                                                            52)
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            245,
                                                                            200,
                                                                            65),
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          '${searchresult[index]['vote_average']}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'open sans',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .amber
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .language_outlined,
                                                                        color: Colors
                                                                            .amber,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          '${searchresult[index]['original_language']}',
                                                                          style: TextStyle(
                                                                              fontFamily: 'open sans',
                                                                              decoration: TextDecoration.none,
                                                                              color: Colors.white,
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w500,
                                                                              letterSpacing: 1.02))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            height: 85,
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                '${searchresult[index]['overview']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .white)))
                                                      ])))
                                            ])));
                                  }));
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: const Color.fromARGB(255, 226, 182, 50),
                          ));
                        }
                      })
                  : Container(),
            ],
          )),
    );
  }
}
