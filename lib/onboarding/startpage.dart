import 'package:apt/components/gradient_button.dart';
import 'package:flutter/material.dart';
import '../user/join.dart';
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
          CustomButton(width:  MediaQuery.of(context).size.width * 0.68, height: 40, onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },child: Center(
            child: Text(
              '로그인',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          )),
          SizedBox(
            height: 10,
          ),
          CustomButton(width: MediaQuery.of(context).size.width * 0.68, height: 40, onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => JoinPage()));
          },child: Center(
            child: Text(
              '회원가입',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          )),
        ],
      ),)
    );
  }



}
