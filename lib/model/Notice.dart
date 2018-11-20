import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

class Notice {
  String img;
  String title;
  String date;
  String description;
  String category;
  String link;
  String origin;

  Notice(this.img, this.title, this.date, this.description, this.category,
      this.link, this.origin);

  Notice.fromMap(Map<String, dynamic> map)
      : img = _getImageUrl(map['url_img'], 200, 200),
        title = map['tittle'],
        date = map['date'],
        description = map['description'],
        category = map['category'],
        link = map['link'],
        origin = map['origin'];

  Widget getViewNormal() {
    return new NoticeView(
        img, title, date, description, category, link, origin);
  }

  Widget getViewSpotlight() {
    return new NoticeViewSpotlight(
        img, title, date, description, category, link, origin);
  }

  static String _getImageUrl(url, height, width) {
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
    return new Container(
      height: 100.0,
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      child: new Card(
        elevation: 4.0,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getImage(_img),
            _getColumText(_title, _date, _description),
          ],
        ),
      ),
    );
  }

  Widget _getColumText(tittle, date, description) {
    return new Expanded(
        child: new Container(
      margin:
          new EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0, top: 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitleWidget(tittle),
          _getDateWidget(date),
          _getDescriptionWidget(description)
        ],
      ),
    ));
  }

  Widget _getTitleWidget(String curencyName) {
    return new Text(
      curencyName,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescriptionWidget(String description) {
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(
        description,
        maxLines: 2,
      ),
    );
  }

  Widget _getDateWidget(String date) {
    return new Text(
      date,
      style: new TextStyle(color: Colors.grey, fontSize: 10.0),
    );
  }

  Widget _getImage(String img) {
    return Container(
        child: ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
      child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: _img,
          fit: BoxFit.cover,
          width: 100.0,
          height: 100.0),
    ));
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
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: Container(
          height: 190.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Container(
                    width: double.maxFinite,
                    height: 190.0,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: _img,
                      fit: BoxFit.cover,
                    )),
              ),
              _buildGradient(),
              _buildBottom()
            ],
          ),
        ),
      ),
    );
  }

  _buildBottom() {

    return Container(
      height: 190.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildDescription()
        ],
      ),
    );

  }

  _buildGradient() {
    return DecoratedBox(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        gradient: new LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );
  }

  _buildDescription() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _date,
            style: TextStyle(color: Colors.grey),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(_description, maxLines: 2,
            style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
