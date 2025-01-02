import 'package:flutter/cupertino.dart';

class ValidationUtils {
  // 정규식 패턴 상수
  static String? validateUserName(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if(value == null || value.isEmpty){
      return '닉네임을 입력해주세요.';
    }else if(regExp.hasMatch(value)){
      return '특수문자는 닉네임에 포함할 수 없습니다.';
    }
    return null;
  }

  /// 이메일 유효성 검사
  static String? validateEmail(FocusNode? focusNode, String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if(value == null || value.isEmpty) {
      focusNode?.requestFocus(); // FocusNode가 전달된 경우에만 포커스를 설정
      return '이메일을 입력해주세요.';
    }else{
      RegExp reExp = RegExp(pattern);
      if(!reExp.hasMatch(value)){
        focusNode?.requestFocus();
        return '잘못된 이메일 형식입니다. 다시 입력해주세요.';
      }
      return null;
    }
  }

  /// 비밀번호 유효성 검사
 static String? validatePassword(FocusNode? focusNode, String? value) {
    String pattern = r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
    RegExp regExp = RegExp(pattern);
    if(value == null || value.isEmpty){
      focusNode?.requestFocus();
      return '비밀번호를 입력하세요.';
    } else if(value.length < 8){
      focusNode?.requestFocus();
      return '비밀번호는 8자리 이상이어야합니다.';
    }else if(!regExp.hasMatch(value)){
      focusNode?.requestFocus();
      return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
    }
    return null; //유효성 검증 결과
  }

  // 비밀번호 확인
  static String? validatePasswordConfirm(FocusNode? focusNode, String? value) {
    String pattern = r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
    RegExp regExp = RegExp(pattern);
    if(value == null || value.isEmpty){
      focusNode?.requestFocus();
      return '비밀번호를 입력하세요.';
    } else if(value.length < 8){
      focusNode?.requestFocus();
      return '비밀번호는 8자리 이상이어야합니다.';
    }else if(!regExp.hasMatch(value)){
      focusNode?.requestFocus();
      return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
    }
    return null; //유효성 검증 결과
  }
}
