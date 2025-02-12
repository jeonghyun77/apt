import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mappage extends StatefulWidget {
  const Mappage({super.key});

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  int currentItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('부동산이'),
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
      body: currentItem == 0 ? Container() : ListView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem,
        onTap: (value){
          setState(() {
            currentItem = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list')
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text('이 위치로 검색하기'))
    );
  }
}
