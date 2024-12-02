import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'shared/services/auth_service.dart';
import 'shared/storage/storage_service.dart';
import 'shared/network/api_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initServices();
  
  runApp(const MyApp());
}

Future<void> initServices() async {
  // Initialize Core Services
  await Get.putAsync(() => StorageService().init());
  Get.put(ApiProvider());
  await Get.putAsync(() => AuthService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracking App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}