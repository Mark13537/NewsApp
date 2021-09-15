class ArticlesArticlesSource {
  String? id;
  String? name;

  ArticlesArticlesSource({
    this.id,
    this.name,
  });
  ArticlesArticlesSource.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class ArticlesData {
  ArticlesArticlesSource? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  ArticlesData({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
  ArticlesData.fromJson(Map<String, dynamic> json) {
    source = (json["source"] != null)
        ? ArticlesArticlesSource.fromJson(json["source"])
        : null;
    author = json["author"]?.toString();
    title = json["title"]?.toString();
    description = json["description"]?.toString();
    url = json["url"]?.toString();
    urlToImage = json["urlToImage"]?.toString();
    publishedAt = json["publishedAt"] == null
        ? null
        : DateTime.parse(json["publishedAt"]);
    content = json["content"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (source != null) {
      data["source"] = source!.toJson();
    }
    data["author"] = author;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["content"] = content;
    return data;
  }
}

class Articles {
  String? status;
  int? totalResults;
  List<ArticlesData?>? articles;

  Articles({
    this.status,
    this.totalResults,
    this.articles,
  });
  Articles.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    totalResults = json["totalResults"]?.toInt();
    if (json["articles"] != null) {
      final v = json["articles"];
      final arr0 = <ArticlesData>[];
      v.forEach((v) {
        arr0.add(ArticlesData.fromJson(v));
      });
      articles = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["totalResults"] = totalResults;
    if (articles != null) {
      final v = articles;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["articles"] = arr0;
    }
    return data;
  }
}
