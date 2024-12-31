import 'package:flutter/cupertino.dart';

class CheckValidate {
  // 정규식 패턴 상수
  static const String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String _passwordPattern =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';

  static final RegExp _emailRegExp = RegExp(_emailPattern);
  static final RegExp _passwordRegExp = RegExp(_passwordPattern);

  /// 이메일 유효성 검사
  String? validateEmail(FocusNode? focusNode, String value) {
    if (value.isEmpty) {
      focusNode?.requestFocus(); // FocusNode가 전달된 경우에만 포커스를 설정
      return '이메일을 입력하세요.';
    } else if (!_emailRegExp.hasMatch(value)) {
      focusNode?.requestFocus();
      return '잘못된 이메일 형식입니다.';
    }
    return null; // 유효한 경우 null 반환
  }

  /// 비밀번호 유효성 검사
  String? validatePassword(FocusNode? focusNode, String value) {
    if (value.isEmpty) {
      focusNode?.requestFocus();
      return '비밀번호를 입력하세요.';
    } else if (!_passwordRegExp.hasMatch(value)) {
      focusNode?.requestFocus();
      return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
    }
    return null; // 유효한 경우 null 반환
  }
}
