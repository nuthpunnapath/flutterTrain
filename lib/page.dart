import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_page/models/HeadLineModel.dart';
import 'package:news_page/models/headNews.dart';
import 'package:news_page/screens/newsDetail.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  File _image;
  HeadLineModel headLineModel;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  // bool _isLoading = true;
  // List<News> news;
  // List<Articles> news;
  List<BottomNavigationBarItem> navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
    BottomNavigationBarItem(
        icon: Icon(Icons.business), title: Text('Business')),
    BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
  ];

  @override
  void initState() {
    super.initState();
    // news = [
    //   News(
    //     'images/wud.png',
    //     'เครื่องส่งสัญญาน',
    //     DateTime.now(),
    //     'newstail',
    //   ),
    //   News(
    //     'images/snow.jpg',
    //     'อากาศหยาวเย็น',
    //     DateTime.now(),
    //     'newstail',
    //   ),
    // ];
    // _fetchNews();
    headLineModel = ScopedModel.of<HeadLineModel>(context);
    headLineModel.fetchNews();
  }

  // _fetchNews() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final response = await http.get(
  //       'https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey=4fb22a82484c49798869b45c01f524c9');
  //   var responseJson = json.decode(response.body);
  //   NewsResponse newsResponse = NewsResponse.fromJson(responseJson);
  //   setState(() {
  //     news = newsResponse.articles;
  //     _isLoading = false;
  //   });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: navItems),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(
                    'Headkine',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                child: Container(
                    // child: listViewBody(),
                    ),
              );
            })
        : ScopedModelDescendant(builder: (context, child, model) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Sample Code'),
                actions: <Widget>[
                  IconButton(
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: _image == null
                          ? CircleAvatar(
                              child: Text('Gig'),
                            )
                          : Image.file(_image),
                    ),
                    tooltip: 'icon',
                    onPressed: () => getImage(),
                  ),
                ],
              ),

              bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text('Home')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business), title: Text('Business')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.school), title: Text('School')),
                ],
                // currentIndex: _selectedIndex,
                fixedColor: Colors.deepPurple,
                // onTap: _onItemTapped,
              ),
              // );

              body: model.isLoading
                  ? buildLoading()
                  : Container(
                      child: listViewBody(model),
                      // width: 200.0,
                      // height: 100.0,
                    ),
            );
          });
  }

  openDetailPage(Articles data) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => newsDetail(data)));
  }

  Widget listViewBody(dynamic model) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: model.getNews?.length,
      // itemExtent: 20.0,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            // padding: EdgeInsets.only(left: 10.0, top: 40.0),
            // alignment: Alignment.center,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                openDetailPage(model.getNews[index]);
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlightImageAsset(model.getNews[index].urlToImage),
                    Text(
                      model.getNews[index].title,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 35.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          model.getNews[index].publishedAt,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 15.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.more_vert),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
    // });
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Future _reload() async {
  //   String result = await Future.delayed(Duration(seconds: 2), () => "success");
  //   if (result == "success") {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
}

class FlightImageAsset extends StatelessWidget {
  String picture;
  FlightImageAsset(this.picture);
  @override
  Widget build(BuildContext context) {
    // AssetImage assetImage = AssetImage(this.picture);
    Image image = Image(
      // image: assetImage,
      image: this.picture == null
          ? AssetImage('images/snow.jpg')
          : NetworkImage(this.picture),
      fit: BoxFit.contain,
      // width: 250.0,
      // height: 250,
    );

    print('test');
    print(this.picture);
    return Container(
      child: image,
    );
  }
}

class News {
  String detail;
  String imageUrl;
  String headerNews;
  DateTime newsDate;
  News(this.imageUrl, this.headerNews, this.newsDate, this.detail);
}
