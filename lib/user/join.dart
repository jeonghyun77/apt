import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _SigninpageState();
}

class _SigninpageState extends State<JoinPage> {


final _formkey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _passworConfirmController = TextEditingController();


bool _isCheckRed = false;

// 유효성 검사
FocusNode emailFocus = new FocusNode();
FocusNode passwordFocus = new FocusNode();


final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

Future<void> _submit()async{
  if(_formkey.currentState!.validate() == false){
    return;
  }else{
    _formkey.currentState!.save();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('회원가입이 완료되었습니다. 로그인을 진행해주세요.'),
      duration: Duration(seconds: 1),)
    );
    Navigator.of(context).pop();
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('회원가입'), centerTitle: true,elevation: 0,),
        body: Form(
          key: _formkey,
            child: SingleChildScrollView(
              child: Padding(padding:  const EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
                TextFormField(
                controller: _usernameController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return '닉네임을 입력해주세요.';
                  }
                  return null;
                },
                  onSaved: (value){},
                decoration: InputDecoration(
                  label: Text('닉네임', style:  TextStyle(fontSize: 14)),
                  hintText: "닉네임을 입력하세요.",  hintStyle: TextStyle(fontSize: 10)
                ),
              ),
                TextFormField(
                  focusNode: emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                      label: Text('이메일', style:  TextStyle(fontSize: 14)),
                      hintText: "abcd@gmail.com",
                      hintStyle: TextStyle(fontSize: 10)
                  ),
                ),
                TextFormField(
                  onSaved: (value){},
                  controller: _passwordController,
                    decoration: InputDecoration(
                      label: Text('비밀번호', style:  TextStyle(fontSize: 14)),
                      hintText: "비밀번호를 입력하세요.",
                        hintStyle: TextStyle(fontSize: 10)
                    ),
                  ),
                TextFormField(
                  controller: _passworConfirmController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return '비밀번호를 한번 더 입력해주세요.';
                    }else if(value != _passwordController.text.toString()){
                      return '비밀번호가 일치하지 않습니다.';
                    }
                    return null;
                  },
                  onSaved: (value){},
                  decoration: InputDecoration(
                    label: Text('비밀번호 확인', style:  TextStyle(fontSize: 14)),
                    hintText: "비밀번호를 다시 한번 입력하세요.",
                    hintStyle: TextStyle(fontSize: 10)
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isCheckRed,
                      onChanged: (value) {
                        setState(() {
                          _isCheckRed = value!;
                        });
                      },
                    ),
                    Text("이용약관 전체동의",style: TextStyle(fontSize: 10),)
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: _isCheckRed,
                      onChanged: (value) {
                        setState(() {
                          _isCheckRed = value!;
                        });
                      },
                    ),
                    Text("[필수]", style: TextStyle(fontSize: 10, color: Colors.blueAccent),),
                    Text(" 14세 이상입니다.", style: TextStyle(fontSize: 10),)
                  ],
                )
              ],)))

            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: () async{
          },
          color: Color(0xffc7c7c7),
          textColor: Colors.white,
          child: Text('완료'),
        ),
      ),
    );
  }

}

// Widget TextFormFiledComponent(bool obscureText, TextInputType keyboardType, TextInputAction textInputAction, String hintText, int maxsize, String errorMessage){
//   return Container(
//     child: TextFormField(
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       decoration: InputDecoration(
//         hintText: hintText
//       ),
//       validator: (value){
//         if(value!.length < maxsize){
//           return errorMessage;
//         }
//       },
//     ),
//   );

// }



