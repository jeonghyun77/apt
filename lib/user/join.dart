import 'package:flutter/material.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _SigninpageState();
}

class _SigninpageState extends State<JoinPage> {
final formKey = GlobalKey<FormState>();
final TextEditingController userIdController = TextEditingController();



Future<void> _submit()async{
  if(formKey.currentState!.validate() == false){
    return;
  }else{
    formKey.currentState!.save();
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
          key: formKey,
            child: SingleChildScrollView(
              child: Padding(padding:  const EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
                TextField(
                controller: userIdController, // ID 용 TextFormField 에는 ID 용 Controller 를 설정함.
                decoration: InputDecoration(
                  label: Text('이름', style:  TextStyle(fontSize: 14)),
                  hintText: "", // 입력에 값이 없을 때 입력을 돕기 위한 텍스트
                ),
              ),
                  TextField(
                    controller: userIdController, // ID 용 TextFormField 에는 ID 용 Controller 를 설정함.
                    decoration: InputDecoration(
                      label: Text('아이디', style:  TextStyle(fontSize: 14)),
                      hintText: "아이디를 입력하세요.",
                        hintStyle: TextStyle(fontSize: 10)
                    ),
                  ),
                TextField(
                  controller: userIdController, // ID 용 TextFormField 에는 ID 용 Controller 를 설정함.
                  decoration: InputDecoration(
                      label: Text('이메일', style:  TextStyle(fontSize: 14)),
                      hintText: "abcd@gmail.com",
                      hintStyle: TextStyle(fontSize: 10)
                  ),
                ),
                  TextField(
                    controller: userIdController, // ID 용 TextFormField 에는 ID 용 Controller 를 설정함.
                    decoration: InputDecoration(
                      label: Text('비밀번호', style:  TextStyle(fontSize: 14)),
                      hintText: "비밀번호를 입력하세요.",
                        hintStyle: TextStyle(fontSize: 10)
                    ),
                  ),
                TextField(
                  controller: userIdController, // ID 용 TextFormField 에는 ID 용 Controller 를 설정함.
                  decoration: InputDecoration(
                    label: Text('비밀번호 확인', style:  TextStyle(fontSize: 14)),
                    hintText: "비밀번호를 다시 한번 입력하세요.",
                    hintStyle: TextStyle(fontSize: 10)
                  ),
                ),

              ],)))
            ));
  }

}

Widget TextFormFiledComponent(bool obscureText, TextInputType keyboardType, TextInputAction textInputAction, String hintText, int maxsize, String errorMessage){
  return Container(
    child: TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText
      ),
      validator: (value){
        if(value!.length < maxsize){
          return errorMessage;
        }
      },
    ),
  );
}

