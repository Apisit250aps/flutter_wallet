import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shared/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Services
  await initServices();
  
  runApp(const MyApp());
}

Future<void> initServices() async {
  // Initialize Storage Service
  await Get.putAsync(() => StorageService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO: Add initial route and routing configuration
    );
  }
}