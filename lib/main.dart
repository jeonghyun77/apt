import 'package:apt/firebase_options.dart';
import 'package:apt/onboarding/splashpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(
    nativeAppKey: '${'9758d046eabb7eb6fa027accc487fed0'}',
    javaScriptAppKey: '${'e40d0dff22aec1f587a2ef9b870ce6e8'}'
  );
  runApp(const MyApp());

  FlutterError.onError = (errorDetails){
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack){
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Splashpage()));
  }
}
