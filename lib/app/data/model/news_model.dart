import 'package:info_a1/core/util.dart';

class NewsModel {
  String? message;
  int? total;
  List<Data>? data;

  NewsModel({this.message, this.total, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  String? link;
  String? isoDate;
  String? image;
  String? description;
  String? time;

  Data({this.title, this.link, this.isoDate, this.image, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    isoDate = json['isoDate'];
    image = json['image'];
    description = json['description'];
    time = timeAgo(isoDate!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['isoDate'] = isoDate;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
