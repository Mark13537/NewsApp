import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Helpers/AppConstants.dart';
import 'package:news_app/Helpers/Helpers.dart';
import 'package:news_app/Helpers/NetworkHelper.dart';
import 'package:news_app/Helpers/ShowNotificationHelper.dart';
import 'package:news_app/Model/Articles.dart';

import 'Widgets/InputTextField.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTxtCotroller = TextEditingController();
  Articles? articles;
  List<ArticlesData>? articleList = [];
  Timer? _timer;
  String? previousKeyword;
  bool? _isDialogShowing;

  void searchWithThrottle(String keyword, {int? throttleTime}) {
    _timer?.cancel();
    if (keyword != previousKeyword && keyword.isNotEmpty) {
      previousKeyword = keyword;
      _timer = Timer.periodic(Duration(milliseconds: throttleTime ?? 350),
          (timer) async {
        await getTopHeadlinesAPI(keyword);
        _timer!.cancel();
      });
    }
  }

  Future<bool> getTopHeadlinesAPI(String query) async {
    setState(() {
      _isDialogShowing = true;
    });
    String url = API_SEARCH + query + "&" + API_KEY;
    try {
      final response = await getDio().get(url).catchError((onError) {
        showCustomDialog(context, "Something went wrong",
            "Please try again later", () => {Navigator.pop(context)});
      });

      if (response.statusCode != 200) {
        if (_isDialogShowing!) {
          setState(() {
            _isDialogShowing = false;
          });
        }
        showCustomDialog(context, "Something went wrong",
            "Please try again later", () => {Navigator.pop(context)});
        return false;
      } else {
        setState(() {
          articles = Articles.fromJson(response.data);
          articleList = articles!.articles!.cast<ArticlesData>();
          _isDialogShowing = false;
        });
        return true;
      }
    } on DioError catch (e) {
      if (_isDialogShowing!) {
        setState(() {
          _isDialogShowing = false;
        });
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: InputTextField(
            onChanged: (text) async {
              if (text.length >= 3) searchWithThrottle(text, throttleTime: 300);
            },
            autoFocus: true,
            controller: searchTxtCotroller,
            name: "Search News",
            inputBorder: InputBorder.none,
          ),
          actions: [
            InkWell(
              onTap: () {
                searchTxtCotroller.clear();
                articleList!.clear();
              },
              child: Icon(
                Icons.cancel_rounded,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Column(
          children: [
            Text("Search Results"),
            Expanded(
              child: ListView.builder(
                  itemCount: articleList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 200.0,
                                padding: EdgeInsets.only(bottom: 20),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 6,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                  image: articleList![index].urlToImage != null
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              articleList![index].urlToImage!))
                                      : DecorationImage(
                                          image:
                                              AssetImage("assets/noImage.png"),
                                          fit: BoxFit.cover),
                                )),
                            SizedBox(height: 10),
                            Text(articleList?[index].title ?? "",
                                style: medTxtStyleSemiBoldBlack.copyWith(
                                    fontSize: 16)),
                            SizedBox(height: 10),
                            Text(
                              articleList?[index].description ?? "",
                              style: medTxtStyleSemiBoldBlack.copyWith(
                                  fontSize: 14, color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(articleList?[index].author ?? "",
                                      style: medTxtStyleSemiBoldBlack.copyWith(
                                          fontSize: 12)),
                                  Text(
                                      articleList?[index].publishedAt != null
                                          ? formatTime(
                                              articleList![index].publishedAt!)
                                          : "",
                                      style: medTxtStyleSemiBoldBlack.copyWith(
                                          fontSize: 12, color: Colors.grey)),
                                ])
                          ]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
