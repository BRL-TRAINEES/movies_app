import 'package:flutter/material.dart';

Widget sliderlist(List listname, String title, itemlength) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 140,
          top: 15,
          bottom: 25,
        ),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Container(
        height: 250,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: itemlength,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${listname[index]['poster_path']}'),
                          fit: BoxFit.cover)),
                  margin: EdgeInsets.only(left: 10),
                  width: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6, top: 4, right: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.356),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(listname[index]['vote_average'].toString()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      )
    ],
  );
}
