import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_flutter_example_project/controllers/CoffeeViewModel.dart';
import 'package:h_flutter_example_project/models/CoffeeItem.dart';
import 'package:h_flutter_example_project/services/CoffeService.dart';
import 'package:h_flutter_example_project/themes/CoffeeTheme.dart';
import 'package:h_flutter_example_project/widgets/Layout.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

/// flutter pub add hive - 경량 NoSQL 데이터베이스 패키지
/// flutter pub add http - API 요청을 위한 패키지
/// flutter pub add provider - 상태 관리 패키지
/// flutter pub add path_provider - 어플리케이션 경로를 취득하기 위한 패키지
/// flutter pub add camera - 카메라 모듈을 위한 패키지
/// flutter pub add build_runner - 코드 생성기 실행을 위한 패키지
/// flutter pub add hive_generator - Hive 어댑터 생성을 위한 패키지

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(CoffeeItemAdapter());

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CoffeeViewModel(CoffeeService())
        ),
      ]
  ));
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면의 가장자리 까지 공간을 차지하겠다
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 오른쪽 상단의 디를 제거함.
      title: "my coffee",
      theme: CafeAppTheme.lightTheme,
      darkTheme: CafeAppTheme.darkTheme,
      initialRoute: "/",
      routes: {
        "/" : (context) => Layout()
      },
    );
  }
}