import 'dart:async';

import 'package:apt/geoFire/geoflutterfire.dart';
import 'package:apt/geoFire/models/point.dart';
import 'package:apt/map/map_filter.dart';
import 'package:apt/map/map_filter_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Aptpage extends StatefulWidget {
  const Aptpage({super.key});

  @override
  State<Aptpage> createState() => _AptpageState();
}

class _AptpageState extends State<Aptpage> {
  int currentItem = 0;
  MapFilter mapFilter = MapFilter();
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.4968, 127.0632);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  final Set<Marker> _markers = {};
  BitmapDescriptor? _markerIcon;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MarkerId? selectMarker;
  BitmapDescriptor makerIcon = BitmapDescriptor.defaultMarker;

  late List<DocumentSnapshot> documentList = List<DocumentSnapshot>.empty(growable: true);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addCustomIcon();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(40, 40)), "assets/images/apartment.png",

    ).then((icon) {
      setState(() {
        makerIcon = icon;
        print("아이콘 나옴");
      });
    }).catchError((error) {
      print("아이콘 로드 실패: $error");
    });
  }


  Future<void> _searchApt()async{
    final GoogleMapController controller = await _controller.future;
    final bounds = await controller.getVisibleRegion();
    LatLng centerBounds = LatLng((bounds.southwest.latitude + bounds.northeast.latitude / 2), (bounds.southwest.longitude + bounds.northeast.latitude / 2));
    final aptRef = FirebaseFirestore.instance.collection('cities');
    final geo = Geoflutterfire();

    GeoFirePoint center = geo.point(latitude: centerBounds.latitude, longitude: centerBounds.longitude);

    double radius = 1;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: aptRef).within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList){
      this.documentList = documentList;
      drawMaker(documentList);
    });
  }

  drawMaker(List<DocumentSnapshot> documentList){
    if(markers.isNotEmpty){
      List<MarkerId> markerIds = List.of(markers.keys);
      for(var markerId in markerIds){
        setState(() {
          _markers.clear();
          markers.forEach((key, value) {
            _markers.add(value);
          });
        });
      }
    }
    for(var element in documentList){
      var info = element.data()! as Map<String, dynamic>;
      if(selectedCheck(info, mapFilter.peopleString, mapFilter.carString, mapFilter.buildingString)){
        MarkerId markerId = MarkerId(info['position']['geohash']);
        Marker marker = Marker(markerId: markerId, infoWindow: InfoWindow(
          title: info['name'], snippet: '${info['address']}', onTap: (){}),
          position: LatLng((info['position']['geopoint'] as GeoPoint).latitude, (info['position']['geopoint'] as GeoPoint).longitude),
          icon: makerIcon,
        );
        setState(() {
          markers[markerId] = marker;
        });
      }
    }
  }


  bool selectedCheck(Map<String, dynamic> info, String? peopleString, String? carString, String? buildingString){
    final dong = info['ALL_DONG_CO'];
    final people = info['ALL_HSHLD_CO'];
    final parking = people / info['CNT_PA'];
    MarkerId markerId = MarkerId(info['position']['geohash']);
    Marker marker = Marker(markerId: markerId);

    if(dong >= int.parse(buildingString!)){
      if(people >= int.parse(peopleString!)){
        if(carString == '1'){
          if(parking < 1){
            return true;
          }else{
            return false;
          }
        }else{
          if(parking >= 1){
            return true;
          }else{
            return false;
          }
        }

      }else{
        return false;
      }

    }else{
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [IconButton(onPressed: () async
        {var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return MapFilterDialog(mapFilter: mapFilter);
        }));
        if(result != null){
          mapFilter = result as MapFilter;
        }
        }, icon: Icon(Icons.search))],
      ),
      body:
      currentItem == 0
          ? GoogleMap(
            markers: _markers,
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ): ListView.builder(itemBuilder: (context, value){
        Map<String, dynamic> item = documentList[value].data() as Map<String, dynamic>;
        return InkWell(
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.apartment),
              title: Text(item['name']),
              subtitle: Text(item['address']),
              trailing: const Icon(Icons.arrow_circle_right_sharp),
            ),
          ),
          onTap: (){},
        );
      }, itemCount: documentList.length,
      ),
      floatingActionButton: FloatingActionButton(onPressed: addCustomIcon,
        child: Icon(Icons.search), ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'list',
          ),
        ],
        currentIndex: currentItem,
        onTap: (value){
          if(value == 0){
            _controller = Completer<GoogleMapController>();
          }
          setState(() {
            currentItem = value;
          });
        },
      ),
    );
  }

}
