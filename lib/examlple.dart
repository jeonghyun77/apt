import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'MapPage.dart';

class Examlple extends StatefulWidget {
  const Examlple({super.key});

  @override
  State<Examlple> createState() => _ExamlpleState();
}

class _ExamlpleState extends State<Examlple> {

  Future<bool> connectCheck()async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return true;
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: FutureBuilder(future: connectCheck(), builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if(snapshot.data != null) {
              if (snapshot.data!) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const Mappage();
                      }));
                });
                return const Center(
                  child: Column(
                    children: [
                      Text('부동산')
                    ],
                  ),
                );
              } else {
                return const AlertDialog(
                  title: Text('내 부동산'),
                  content: Text('인터넷 연결 실패!!! 다시 시도해라~~'),
                );
              }
            }else{
              return const Center(
                child: Text('데이터 없음ㅜㅜㅜㅜㅜ'),
              );
            }

          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.none:
            return const Center(
              child: Text('데이터 없음!'),
            );
        }
      }
      ),
    );
  }
}
