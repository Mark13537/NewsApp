import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/Helpers/AppConstants.dart';
import 'package:news_app/Helpers/Helpers.dart';
import 'package:news_app/Helpers/LayoutHelper.dart';
import 'package:news_app/Helpers/NetworkHelper.dart';
import 'package:news_app/Helpers/ShowNotificationHelper.dart';
import 'package:news_app/Model/Articles.dart';

class TopHeadlinesScreen extends StatefulWidget {
  @override
  _TopHeadlinesScreenState createState() => _TopHeadlinesScreenState();
}

class _TopHeadlinesScreenState extends State<TopHeadlinesScreen> {
  bool _isDialogShowing = false;
  Articles articles;
  Future<List<Article>> refresh;
  List<Article> articleList;

  @override
  void initState() {
    super.initState();
    refresh = getTopHeadlines();
    getTopHeadlinesAPI();
  }

  Future<List<Article>> getTopHeadlines() async {
    return articleList;
  }

  Future<bool> getTopHeadlinesAPI() async {
    setState(() {
      _isDialogShowing = true;
    });
    String url = API_TOP_HEADLINES + COUNTRY_CODE + API_KEY;
    try {
      final response = await getDio().get(url).catchError((onError) {
        showCustomDialog(context, "Something went wrong",
            "Please try again later", () => {Navigator.pop(context)});
      });

      if (response.statusCode != 200) {
        if (_isDialogShowing) {
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
          articleList = articles.articles;
          refresh = getTopHeadlines();
          _isDialogShowing = false;
        });
        return true;
      }
    } on DioError catch (e) {
      if (_isDialogShowing) {
        setState(() {
          _isDialogShowing = false;
        });
      }
      return false;
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: RichText(
        text: TextSpan(
          text: 'Top Headlines ',
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
      ),
    );
  }

  Center buildDataLoder() {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinKitRing(
              lineWidth: 3,
              color: BLUE_TEXT_COLOR,
              size: 40.0,
              duration: Duration(milliseconds: 1000),
            ),
            const SizedBox(height: 10),
            Text(
              "Getting data",
              style: semiBoldTxtStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsList() {
    return FutureBuilder<List<Article>>(
        future: refresh,
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No News Found",
                style: semiBoldTxtStyle.copyWith(fontSize: 20),
              ),
            );
          }
          return ListView.builder(
              itemCount: articleList.length,
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
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      articleList[index].urlToImage)),
                            )),
                        SizedBox(height: 10),
                        Text(articleList[index].title ?? "",
                            style: medTxtStyleSemiBoldBlack.copyWith(
                                fontSize: 16)),
                        SizedBox(height: 10),
                        Text(
                          articleList[index].description ?? "",
                          style: medTxtStyleSemiBoldBlack.copyWith(
                              fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(articleList[index].author ?? "",
                                  style: medTxtStyleSemiBoldBlack.copyWith(
                                      fontSize: 12)),
                              Text(
                                  articleList[index].publishedAt != null
                                      ? formatTime(
                                          articleList[index].publishedAt)
                                      : "",
                                  style: medTxtStyleSemiBoldBlack.copyWith(
                                      fontSize: 12, color: Colors.grey)),
                            ])
                      ]),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.width;

    LayoutHelper();

    LayoutHelper.instance.width = width;
    LayoutHelper.instance.height = height;
    LayoutHelper.instance.fontSize = width < 400
        ? 16
        : (width > 400 && width < 600)
            ? 18
            : 22;
    LayoutHelper.instance.titleFontSize = width < 400
        ? 20
        : (width > 400 && width < 600)
            ? 22
            : 28;
    LayoutHelper.instance.appBarTitleSize = width < 400
        ? 32
        : (width > 400 && width < 600)
            ? 36
            : 45;

    return SafeArea(
      child: Scaffold(
          appBar: buildAppBar(),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () {
                getTopHeadlinesAPI();
              },
            ),
            child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    !_isDialogShowing
                        ? Expanded(
                            child: buildNewsList(),
                          )
                        : buildDataLoder()
                  ],
                )),
          )),
    );
  }
}
