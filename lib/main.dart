import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
      nativeAppKey: 'd74dc25a658483ab83e3177d7346f4a6',
      javaScriptAppKey: '608adc94cc0be02c8e522675d38b4e4d');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("카카오 로그인 서비스", style: TextStyle(fontSize: 30)),
          ElevatedButton(
              onPressed: () async {
                // 카카오톡 실행 가능 여부 확인
                // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정
                if (await isKakaoTalkInstalled()) {
                  print("카카오톡이 설치되어 있습니다.");
                  await UserApi.instance.loginWithKakaoTalk();
                } else {
                  print("카카오톡이 설치되어 있지 않습니다.");
                  OAuthToken oauthToken =
                      await UserApi.instance.loginWithKakaoAccount();
                  print(oauthToken.accessToken);
                  print(oauthToken.expiresAt);
                  print(oauthToken.scopes![0]);
                }
              },
              child: Text("카카오로그인")),
        ],
      ),
    );
  }
}
