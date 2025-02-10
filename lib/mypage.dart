import 'package:apt/user/join.dart';
import 'package:apt/user/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  bool _isCkeck = false;
  final List<Map<String, dynamic>> _mylist = [
    {'title': '내 정보', 'page': JoinPage()},
    {'title': '약관 및 정책', 'page': JoinPage()},
    {'title': '알림 받기', 'page': LoginPage()},
    {'title': '고객센터', 'page': JoinPage()},
    {'title': '현재 앱 버전', 'page': JoinPage()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('설정'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                  trailing: _mylist[index]['title'] == '알림 받기'
                      ? CupertinoSwitch(
                          activeColor: Colors.amber,
                          value: _isCkeck,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCkeck = value ?? false;
                            });
                          })
                      : const Icon(Icons.navigate_next),
                  onTap: () {
                    if (_mylist[index]['title'] != '알림 받기') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => _mylist[index]['page']));
                    }
                  },
                  title: Text(
                    _mylist[index]['title']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ));
            },
            separatorBuilder: (context, index) => Divider(
                  color: Color(0xfff0f0f0),
                ),
            itemCount: _mylist.length));
  }
}
