import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_api/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      color: Colors.grey[200],
      child: _buildFirestore(),
    );
  }

  _buildFirestore() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('news').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
            default:
              return _buildListView(snapshot.data.documents);
          }
        },
      ),
    );
  }

  _buildListView(List<DocumentSnapshot> documents) {
    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (_, index) {
            News news = News.fromSnapshot(documents[index]);
            return _buildListViewItem(news);
          }),
    );
  }

  _buildListViewItem(News newsAtIndex){
    return InkWell(
      onDoubleTap: (){
        print("double tap");
        Firestore.instance.runTransaction((tran) async{
          var snapshot = await tran.get(newsAtIndex.reference);
          News news = News.fromSnapshot(snapshot);
          news.photo.large += ",a,";
          tran.update(news.reference, news.toMap());
        });
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 5.0),
        child: Column(
          children: <Widget>[
            Container(
                width: 300.0,
                height: 50.0,
                child: Text("commenter: ${newsAtIndex.comments[0].commenter} and text: ${newsAtIndex.comments[0].text}")
            ),
            Container(
                width: 300.0,
                height: 50.0,
                child: Text("photo large: ${newsAtIndex.photo.large}")
            ),
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: (){
                      Firestore.instance.runTransaction((tran) async{
                        await tran.delete(newsAtIndex.reference);
                        print("newsAtIndex.reference.documentID ${newsAtIndex.reference.documentID} deleted");
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _inc = 0;

  _buildAppBar() {
    return AppBar(
      title: Text("News"),
      actions: <Widget>[
        IconButton(onPressed: (){
          _inc++;
          Firestore.instance.runTransaction((tran) async{
            var ref = Firestore.instance.collection("news");
            Photo p = Photo();
            List<Comment> c = [];
            c.add(Comment());
            News news = News(title: "my title $_inc", photo: p, comments: c);
            await ref.add(news.toMap());
          }).whenComplete(() => print("news added"));
        }, icon: Icon(Icons.add_circle),),
      ],
    );
  }

}