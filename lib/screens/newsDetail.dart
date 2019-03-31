import 'package:flutter/material.dart';
import 'package:news_page/page.dart';
import 'package:news_page/models/headNews.dart';

class newsDetail extends StatelessWidget {
  // News data;
  Articles data;
  newsDetail(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Code'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlightImageAsset(data.urlToImage),
              Text(
                data.title,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 35.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              Text(
                data.content,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
