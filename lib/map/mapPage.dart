import 'dart:async';

import 'package:apt/map/map_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/constants.dart';
import '../geoFire/geoflutterfire.dart';
import '../geoFire/models/point.dart';

class Mappage extends StatefulWidget {
  const Mappage({super.key});

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  int currentItem = 0;
  MapFilter mapFilter = MapFilter();
  Completer<GoogleMapController>_controller = Completer<GoogleMapController>();
  MarkerId? selectedMarker;
  BitmapDescriptor markerIcons = BitmapDescriptor.defaultMarker;

  late List<DocumentSnapshot> documentList = List<DocumentSnapshot>.empty(growable: true);


  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  static const CameraPosition _googleMapCamera = CameraPosition(target: LatLng(37.4968, 127.0632),zoom: 15);
  // final LatLng _center = const LatLng(37.4968, 127.0632);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addCustomIcon();
  }

  void addCustomIcon()async{
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'asset/images/apartment.png');
      setState(() {
        markerIcons = customIcon;
      });
  }
  Future<void> _searchApt()async{

    final GoogleMapController controller = await _controller.future;
    final bounds = await controller.getVisibleRegion();
    LatLng centerBounds = LatLng((bounds.southwest.latitude + bounds.northeast.latitude / 2), (bounds.southwest.longitude + bounds.northeast.latitude / 2));
    // final aptRef = FirebaseFirestore.instance.collection('cities');
    final citiesRef = firestore.collection('cities');

    citiesRef.snapshots().listen((snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc.data());
        // Firestore 데이터 출력
      });

    });
    final geo = Geoflutterfire();

    GeoFirePoint center = geo.point(latitude: centerBounds.latitude, longitude: centerBounds.longitude);

    double radius = 1;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: citiesRef).within(center: center, radius: radius, field: field);

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
          markers.remove(markerId);
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
          icon: markerIcons,
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
      appBar: AppBar(title: Text('my 부동산'), actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.search))
      ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
                child:Column
                  (children: [
                    Text('홍길동',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('hong@gamil.com',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],) ),
            ListTile(
              title: const Text('내가 선택한 아파트'),
              onTap: (){},
            ),
            ListTile(
              title: const Text('설정'),
              onTap: (){},
            )

          ],
        ),
      ),
      body: currentItem == 0
          ? GoogleMap(initialCameraPosition: _googleMapCamera,
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController cotroller) {
            _controller.complete(cotroller);

          })
          : ListView.builder(
        itemCount: documentList.length,
          itemBuilder: (context, value){
            Map<String, dynamic> item =
                documentList[value].data() as Map<String, dynamic>;
            return InkWell(
              onTap: (){},
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.apartment),
                  title: Text(item['name']),
                  subtitle: Text(item['address']),
                  trailing: const Icon(Icons.arrow_circle_right_sharp),
                ),
              ),
            );
       }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem,
        onTap: (value){
          if(value == 0){
            _controller = Completer<GoogleMapController>();
          }
          setState(() {
            currentItem = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list')
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _searchApt, label: Text('이 위치로 검색하기'))
    );
  }
}
