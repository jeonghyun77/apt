
import 'package:apt/components/gradient_button.dart';
import 'package:apt/user/check_validate.dart';
import 'package:apt/user/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

bool _isObscure = true;
bool _isObscuref = true;
bool _isCheckRed = false;

 Future <void> _signUp()async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "test@example", password: "12345");
      print("회원가입 성공: ${userCredential.user?.uid}");
    }
    catch(e){
      if(_formkey.currentState!.validate()){
        Future.delayed(Duration(seconds: 2), (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (router) => false);
        });
    }

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
                validator: ValidationUtils.validateUserName,
                  onSaved: (value){},
                decoration: InputDecoration(
                  label: Text('닉네임', style:  TextStyle(fontSize: 14, color: Colors.black)),
                  hintText: "닉네임을 입력하세요.",  hintStyle: TextStyle(fontSize: 10)
                ),
              ),
                TextFormField(

                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return '이메일을 입력해주세요.';
                    }else{
                      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp reExp = RegExp(pattern);
                      if(!reExp.hasMatch(value)){
                        return '잘못된 이메일 형식입니다. 다시 입력해주세요.';
                      }
                      return null;
                    }

                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                      label: Text('이메일', style:  TextStyle(fontSize: 14,color: Colors.black)),
                      hintText: "abcd@gmail.com",
                      hintStyle: TextStyle(fontSize: 10)
                  ),
                ),
                TextFormField(
                  obscureText: _isObscure,
                  autofocus: _isObscure,
                  validator: (value){
                  String? validatePassword(String value) {
                  String pattern =
                  r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
                  RegExp regExp = RegExp(pattern);
                  if(value == null || value.isEmpty){
                    return '비밀번호를 입력하세요.';
                  }
                  else if(value.length < 8){
                    return '비밀번호는 8자리 이상이어야합니다.';
                  }else if(!regExp.hasMatch(value)){
                    return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
                  }else {
                    return null;
                  }
                  }},
                  
                  controller: _passwordController,
                    decoration: InputDecoration(
                      label: Text('비밀번호', style:  TextStyle(fontSize: 14,color: Colors.black)),
                      hintText: "비밀번호를 입력하세요.",
                        hintStyle: TextStyle(fontSize: 10),
                        suffixIcon: IconButton(onPressed: (){
                setState(() {
                _isObscure =! _isObscure;
                });
                }, icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off) ),
                    ),
                  ),
                TextFormField(
                  obscureText: _isObscuref,
                  autofocus: false,
                  controller: _passworConfirmController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return '비밀번호를 한번 더 입력해주세요.';
                    }else if(value != _passwordController.text){
                      return '비밀번호가 일치하지 않습니다.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('비밀번호 확인', style:  TextStyle(fontSize: 14,color: Colors.black)),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _isObscuref =! _isObscuref;
                      });
                    }, icon: Icon(_isObscuref ? Icons.visibility : Icons.visibility_off, color: Colors.black,) ),
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
                ),

                GradientButton(
                  onPressed:  _signUp,
                  width: 50, height: 20, child: Center(child:  Text('완료',style: TextStyle(color: Colors.white, fontSize: 13),),),)
              ],)))

            ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(20),
            child: MaterialButton(
              onPressed: _signUp,
              color: Color(0xffffdb12),
              textColor: Colors.white,
              child: Text('완료'),
            ),
      ),
    );
  }

}




