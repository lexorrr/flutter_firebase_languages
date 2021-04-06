import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_languages/widgets/favorite_list_widget.dart';

void main() async {
  // FirebaseFirestore.instance.settings = Settings(
  //   persistenceEnabled: false,
  //   cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED
  // );
  //
  // await FirebaseFirestore.instance.clearPersistence();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite languages'),
      ),
      body: Center(
        child: FutureBuilder<FirebaseApp>(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return const FavoriteList();
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


