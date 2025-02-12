import 'package:apt/map/map_filter.dart';
import 'package:apt/map/map_filter_dialog.dart';
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
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          TextButton(onPressed: () => throw Exception(), child: const Text("data")),
        ],
      ),
    );
  }
}
