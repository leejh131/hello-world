import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'providers/routine_provider.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/progress_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoutineProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '운동 루틴 앱',
        theme: ThemeData(
          primarySwatch: Colors.teal, // ✅ 블루에서 티얼로 변경하여 톤 통일
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'NotoSans', // 선택적으로 Google Fonts 사용 가능
        ),
        home: HomeScreen(), // ✅ 리디자인된 홈 화면 적용
        routes: {
          '/calendar': (ctx) => CalendarScreen(),
          '/progress': (ctx) => ProgressScreen(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}
