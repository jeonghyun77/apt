
import 'package:apt/user/join.dart';
import 'package:flutter/material.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '로그인',
                style: TextStyle(fontSize: 25, color: Color(0xff0f0f0f), fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "이메일", labelStyle: TextStyle(color: Colors.grey,
                    fontSize: 14,)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                 obscureText: true,
                  autofocus: false,
                  cursorColor: Theme.of(context).primaryColor,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "비밀번호", labelStyle: TextStyle(color: Colors.grey, fontSize: 14,),
              ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinPage()),
                    );
                  }, child:  Text(
                    '회원가입',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  )),
                  Container(
                    width: 1,
                    height: 15,
                    color: Colors.grey,
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinPage()),
                    );
                  }, child:  Text(
                    '아이디 찾기',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  )),
                  Container(
                    width: 1,
                    height: 15,
                    color: Colors.grey,
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinPage()),
                    );
                  }, child:  Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  )),
                ],
              ),

            ],
          ),
        ),

    );
  }

}


