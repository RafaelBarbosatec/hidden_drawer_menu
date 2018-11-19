
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

class Notice{

  String img;
  String title;
  String date;
  String description;
  String category;
  String link;
  String origin;

  Notice(this.img, this.title, this.date, this.description, this.category,
      this.link, this.origin);

  Notice.fromMap(Map<String, dynamic>  map) :
        img = _getImageUrl(map['url_img'],200,200),
        title = map['tittle'],
        date = map['date'],
        description = map['description'],
        category = map['category'],
        link = map['link'],
        origin = map['origin'];


  Widget getViewNormal(){
    return new NoticeView(img,title,date,description,category,link,origin);
  }

  Widget getViewSpotlight(){
    return new NoticeViewSpotlight(img,title,date,description,category,link,origin);
  }

  static String _getImageUrl(url,height,width){

    return 'http://104.131.18.84/notice/tim.php?src=$url&h=$height&w=$width';

  }

}

class NoticeView extends StatelessWidget {

  String _img;
  String _title;
  String _date;
  String _description;
  String _category;
  String _link;
  String _origin;


  NoticeView(this._img, this._title, this._date, this._description,
      this._category, this._link, this._origin);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NoticeViewSpotlight extends StatelessWidget {

  String _img;
  String _title;
  String _date;
  String _description;
  String _category;
  String _link;
  String _origin;


  NoticeViewSpotlight(this._img, this._title, this._date, this._description,
      this._category, this._link, this._origin);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
              child: Container(
                width: double.maxFinite,
                  height: 180.0,
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: _img,fit: BoxFit.cover,)
              ),
            ),
            _buildDescription()
          ],
        ),
      ),
    );
  }

  _buildDescription() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _date,
            style: TextStyle(
              color: Colors.grey
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(_description),
          )
        ],
      ),
    );
  }
}

