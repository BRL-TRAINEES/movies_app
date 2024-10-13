import 'package:flutter/material.dart';
import 'package:movie_app/details/moviedetails.dart';
import 'package:movie_app/details/seriesdetails.dart';

class typecheck extends StatefulWidget {
  var idnew;
  var typechecker;

  typecheck(this.idnew, this.typechecker);

  @override
  State<typecheck> createState() => _typecheckState();
}

class _typecheckState extends State<typecheck> {
  checktype() {
    if (widget.typechecker.toString() == 'movie') {
      return Moviedetails(widget.idnew);
    } else if (widget.typechecker.toString() == 'series') {
      return Seriesdetails(widget.typechecker);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('no Such page found'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}
