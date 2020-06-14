import 'package:flutter/material.dart';
import 'package:mind_over_myths/mind_over_myths/Model/place_model.dart';
import 'package:mind_over_myths/mind_over_myths/screen/pages/places_details.dart';
import 'package:mind_over_myths/mind_over_myths/utils/gplace.dart';

class PlacesPage extends StatefulWidget {
  @override
  State createState() => new Placestate();
}

class Placestate extends State<PlacesPage> {

  String _currentPlaceId;
  @override
  Widget build(BuildContext context) {

      onItemTapped= ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new PlaceDetailPage(_currentPlaceId)));


    return new Scaffold(
        body:_createContent(),
      );
  }
final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _createContent() {

    if(_places == null){
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    else{
      return new ListView(
         children: _places.map((f){

           return new Card(
              child: new ListTile(
              title: new Text(f.name,style: _biggerFont,),
               leading: new Image.network(f.icon),
               subtitle: new Text(f.vicinity),
                onTap: (){
                  _currentPlaceId = f.id;
                 // onItemTapped();
                 handleItemTap(f);
                }
           ),
           )
            ;
         }).toList(),
      );
    }
  }
  List<PlaceDetail> _places;
  @override
  void initState() {
    super.initState();
    if (_places == null) {
      LocationService.get().getNearbyPlaces().then((data) {
        this.setState(() {
          _places = data;
        });
      });
    }


  }

  handleItemTap(PlaceDetail place){
    
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new PlaceDetailPage(place.id)));
  }

  VoidCallback onItemTapped;
}