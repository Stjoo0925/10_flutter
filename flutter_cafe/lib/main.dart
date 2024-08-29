import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_flutter_example_project/controllers/NumberViewModel.dart';
import 'package:h_flutter_example_project/controllers/FavoriteViewModel.dart';
import 'package:h_flutter_example_project/services/PhoneService.dart';
import 'package:h_flutter_example_project/services/FavoriteService.dart';
import 'package:h_flutter_example_project/widgets/Layout.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/FavoriteItem.dart';
import 'models/NumberItem.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NumberItemAdapter());
  Hive.registerAdapter(FavoriteItemAdapter());

  // box 열기
  await Hive.openBox<FavoriteItem>("favoriteBox");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => NumberViewModel(NumberService())
      ),
      ChangeNotifierProvider(
          create: (context) => FavoriteViewModel(FavoriteService())
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget{

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면의 가장 자리까지 공간을 차지하겠다
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 오른쪽 상단의 띠를 제거함.
      title: "my number",
      theme: ThemeData(
        fontFamily: 'NanumSquareRound',
      ),
      darkTheme: ThemeData(
        fontFamily: 'NanumSquareRound',
      ),
      locale: const Locale('ko', 'KR'), // 기본 로케일을 한국어로 설정
      supportedLocales: const [
        Locale('ko', 'KR'), // 한국어 지원
        Locale('en', 'US'), // 영어 지원 (필요에 따라 추가)
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: "/",
      routes: {
        "/" : (context) => Layout(),
      },
    );
  }
}
