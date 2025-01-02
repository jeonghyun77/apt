import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../user/login_platform.dart';
import '../user/signup.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  LoginPlatform _loginPlatform = LoginPlatform.none;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/startpage.png'),
          SizedBox(
            height: 20,
          ),
          Text('간편하게 로그인하고\n다양한 서비스를 이용해 보세요. ', textAlign: TextAlign.center,style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600,),),
          SizedBox(
            height: 20,
          ),
          Center(
            child: _loginPlatform != LoginPlatform.none
                ? _logoutButton()
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_loginButton('kakao_login_medium_narrow', signInWithKakao)],
            )
          ),

          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: Text('이메일로 로그인 하기',style: TextStyle( decoration: TextDecoration.underline,fontSize: 13, color: Colors.black),),
          )
        ],
      ),)
    );
  }
  Widget _loginButton(String path, VoidCallback onTap) {
    return Ink.image(
        image: AssetImage('asset/$path.png'),
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
