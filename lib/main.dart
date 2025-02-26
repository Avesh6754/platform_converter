import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/homeController.dart';

void main() {
  runApp(AppSwitcher());
}
var getController=Get.put(HomeController());


class AppSwitcher extends StatefulWidget {
  @override
  _AppSwitcherState createState() => _AppSwitcherState();
}

class _AppSwitcherState extends State<AppSwitcher> {
  bool useMaterial = true;

  @override
  Widget build(BuildContext context) {
    return  useMaterial? buildMaterialApp() : buildCupertinoApp();
  }

  Widget buildMaterialApp() {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MaterialHome(toggleApp: toggleApp),
    );
  }

  Widget buildCupertinoApp() {
    return CupertinoApp(
      title: 'Cupertino App',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
      home: CupertinoHome(toggleApp: toggleApp),
    );
  }

  void toggleApp() {
    setState(() {
      useMaterial = !useMaterial;
    });
  }
}

class MaterialHome extends StatelessWidget {

  MaterialHome({required this.toggleApp});
  final VoidCallback toggleApp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is a Material App', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleApp,
              child: Text('Switch to Cupertino'),
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoHome extends StatelessWidget {
  final VoidCallback toggleApp;
  CupertinoHome({required this.toggleApp});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Cupertino App')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is a Cupertino App', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: toggleApp,
              child: Text('Switch to Material'),
            ),
          ],
        ),
      ),
    );
  }
}