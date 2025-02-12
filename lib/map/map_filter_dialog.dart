import 'package:apt/map/map_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapFilterDialog extends StatefulWidget {
  final MapFilter mapFilter;
  const MapFilterDialog({super.key, required this.mapFilter});

  @override
  State<MapFilterDialog> createState() => _MapFilterDialogState();

}

class _MapFilterDialogState extends State<MapFilterDialog> {
  late MapFilter mapFilter;
  final List<DropdownMenuItem<String>> _buildingDownMenuItems = [
    const DropdownMenuItem<String>(
      value: '1', child: Text('1동')),
    const DropdownMenuItem<String>(
        value: '2', child: Text('2동')),
    const DropdownMenuItem<String>(
        value: '3', child: Text('3동'))
  ];
  final List<DropdownMenuItem<String>> _peopleDownMenuItems = [
    const DropdownMenuItem<String>(
        value: '0', child: Text('전부')),
    const DropdownMenuItem<String>(
        value: '100', child: Text('100세대 이상')),
    const DropdownMenuItem<String>(
        value: '300', child: Text('300세대 이상')),
    const DropdownMenuItem<String>(
        value: '500', child: Text('500세대 이상'))
  ];
  final List<DropdownMenuItem<String>> _carDownMenuItems = [
    const DropdownMenuItem<String>(
        value: '1', child: Text('세대별 1대 미만')),
    const DropdownMenuItem<String>(
        value: '2', child: Text('세대별 1대 이상')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapFilter = widget.mapFilter;
    mapFilter.buildingString = _buildingDownMenuItems.first.value;
    mapFilter.buildingString = _peopleDownMenuItems.first.value;
    mapFilter.buildingString = _carDownMenuItems.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('MY 부동산'),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(items: _buildingDownMenuItems, onChanged: (value){
                setState(() {
                  mapFilter.buildingString = value!;
                });
              },
                value: mapFilter.buildingString,
              )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(items: _peopleDownMenuItems, onChanged: (value){
                  setState(() {
                    mapFilter.peopleString = value!;
                  });
                },
                  value: mapFilter.peopleString,
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(items: _carDownMenuItems, onChanged: (value){
                  setState(() {
                    mapFilter.carString = value!;
                  });
                },
                  value: mapFilter.carString,
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(items: _carDownMenuItems, onChanged: (value){
                  setState(() {
                    mapFilter.carString = value!;
                  });
                },
                  value: mapFilter.carString,
                )
            ),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop(mapFilter);
                }, child: Text('확인')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('취소'))
              ],
            )
          ],
        ),
      ),
    );
  }
}


