import 'package:cloud_firestore/cloud_firestore.dart';

class News{
  String title;
  String content;
  String imageUrl;
  String postDate;
  DocumentReference reference;
  Photo photo;
  List<Comment> comments;

  News({this.title, this.content, this.imageUrl, this.postDate, this.photo, this.comments, this.reference});

  News.fromMap(Map map, {this.reference}){
    title = map["title"] ?? "nodata";
    content = map["content"] ?? "nodata";
    imageUrl = map["imageUrl"] ?? "nodata";
    postDate = map["postDate"] ?? "nodata";
    photo = Photo.fromMap(map["photos"]);
    comments = List<Comment>.from(map["comments"].map((x) => Comment.fromMap(x)));
  }

  factory News.fromSnapshot(DocumentSnapshot snapshot){
    return News.fromMap(snapshot.data, reference: snapshot.reference);
  }

  Map<String, dynamic> toMap() =>{
    "title": title ?? "nodata",
    "content": content ?? "nodata",
    "imageUrl": imageUrl ?? "nodata",
    "postDate": postDate ?? "nodata",
    "photos": photo.toMap(),
    "comments" : List<dynamic>.from(comments.map((x) => x.toMap())),
  };
}

class Photo{
  String large, small;

  Photo({this.large, this.small});

  factory Photo.fromMap(Map map){
    return Photo(
      large: map['large'] ?? "nolarge",
      small: map['small'] ?? "nosmall",
    );
  }

  Map<String, dynamic> toMap() =>{
    "large": large ?? "nodata",
    "small": small ?? "nodata",
  };
}

class Comment{
  String commenter;
  String text;
  Comment({this.commenter = "nodata", this.text = "nodata"});

  factory Comment.fromMap(Map map){
    return Comment(
      commenter: map['commenter'] ?? "nodata",
      text: map['text'] ?? "nodata",
    );
  }

  Map<String, dynamic> toMap() => {
    "commenter" : commenter ?? "nodata",
    "text" : text ?? "nodata",
  };
}
