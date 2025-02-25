
import 'dart:convert';
import 'dart:io';
import 'package:apt/components/gradient_button.dart';
import 'package:http/http.dart' as http;
import 'package:apt/mainpage.dart';
import 'package:apt/user/join.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../constants/constants.dart';
import '../map/mapPage.dart';
import 'login_platform.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isObscuref = true;
  bool _isCheckRed = false;

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.facebook:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.google:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }


  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      final url = Uri.https('kapi.kakao.com', '/v1/user/access_token_info');
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
      });
      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
    } catch (erorr) {
      print('카카오톡 로그인 실패 $erorr');
    }
  }




 Future<void> _login()async{
   try{
     //이메일 & 비밀번호 로그인 시도
     await auth.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim()); // trim() 사용자가 이메일이나 비밀번호 입력할 때 공백이 들어가는 것 방지
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Mainpage()));
   }on FirebaseAuthException catch(e){
     String message;
     switch(e.code){
       case 'user-not-found':
         message = '이메일을 찾을 수 없습니다.';
         break;
       case 'wrong-password':
         message = '잘못된 비밀번호 입니다.';
         break;
       case 'invalid-email':
         message = '올바른 이메일 형식을 입력해주세요.';
         break;
       case 'too-many-requests':
         message = '로그인 시도가 너무 많습니다. 잠시 후 다시 시도하세요.';
         break;
       default:
         message = '로그인에 실패했습니다. 다시 시도해주세요.';
     }
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
   }
 }


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
                child: TextFormField(
                 obscureText: true,
                 autofocus: false,
                  cursorColor: Theme.of(context).primaryColor,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _isObscuref =! _isObscuref;
                      });
                    }, icon: Icon(_isObscuref ? Icons.visibility : Icons.visibility_off, color: Colors.black,) ),
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
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mappage()));
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
              SizedBox(
                height: 30,
              ),
              Center(
                  child: _loginPlatform != LoginPlatform.none
                      ? _logoutButton()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_loginButton('kakao_login_medium_narrow', signInWithKakao)],
                  )
              ),

            ],
          ),
        ),
    );
  }

  Widget _loginButton(String path, VoidCallback onTap) {
    return Ink.image(
        image: AssetImage('asset/images/$path.png'),
        width: 200,
        height: 60,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(35.0),
          ),
          onTap: onTap,
        ));
  }

  Widget _logoutButton(){
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(onPressed: signOut,style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(
        const Color(0xff0165E1),
      ),), child:
      Text('로그아웃')),
    );
  }
}




