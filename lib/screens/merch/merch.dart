import 'package:flutter/material.dart';
import 'package:ecellapp/screens/home/home.dart';

void main() {
  runApp(MerchandiseApp());
}

class MerchandiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merchandise Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => HomeScreen(), // Home page route
        '/merchandise': (context) =>
            MerchandisePage(), // Merchandise page route
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
                context, '/merchandise'); // Navigate to Merchandise Page
          },
          child: Text('Go to Merchandise Page'),
        ),
      ),
    );
  }
}

class MerchandisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merchandise Store'),
      ),
      body: Center(
        child: Text('Welcome to the Merchandise Store!'),
      ),
    );
  }
}
