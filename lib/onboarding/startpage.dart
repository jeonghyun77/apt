import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../user/join.dart';
import '../user/login_platform.dart';
import '../user/Login.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/images/startpage.png'),
          Text('간편하게 로그인하고\n다양한 서비스를 이용해 보세요. ', textAlign: TextAlign.center,style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w600,),),
          SizedBox(
            height: 80,
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          }, style: ElevatedButton.styleFrom(
              minimumSize: Size(280, 40),
              backgroundColor: Color(0xffffdb12), foregroundColor: Colors.black, elevation: 0
          ), child: Text(
            '로그인',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11),
          )),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinPage()));
          }, style: ElevatedButton.styleFrom(
            minimumSize: Size(280, 40),
            backgroundColor: Color(0xffffdb12), foregroundColor: Colors.black, elevation: 0
          ), child: Text(
            '회원가입',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11),
          )),

        ],
      ),)
    );
  }



}
