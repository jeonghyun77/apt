import 'package:apt/user/join.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({super.key});

  @override
  State<SinginPage> createState() => _JoinpageState();
}

class _JoinpageState extends State<SinginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _statusMessage = '';
  bool _isObscure = true;

  Future<void> _signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential.user != null) {
        if (!userCredential.user!.emailVerified) {
          setState(() {
            _statusMessage = '이메일 인증이 완료되지 않았습니다. 이메일을 확인해주세요';
          });
        } else {
          setState(() {
            _statusMessage = '로그인 성공!';
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => JoinPage()));
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _statusMessage = e.message ?? '로그인 실패';
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('로그아웃 중 오류가 발생했습니다.'),
      ));
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController.addListener((){
      setState(() {
        _statusMessage = _passwordController.text;
      });
    });
  }




  void _clearText(){
    _passwordController.clear();
  }


  void _toggleObscure(){
    setState(() {
      _isObscure =! _isObscure;
    });
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
                style: TextStyle(fontSize: 25, color: Color(0xff0f0f0f)),
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
                 obscureText: _isObscure,
                  autofocus: false,
                  cursorColor: Theme.of(context).primaryColor,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "비밀번호", labelStyle: TextStyle(color: Colors.grey, fontSize: 14,),
              ))),
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //       backgroundColor: Color(0xff232c4a), shape: LinearBorder()),
              //   onPressed: _signIn,
              //   child: Text('로그인',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 14,
              //       )),
              // ),

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
