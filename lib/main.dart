import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String email = "email";
  late String firstName = "firstName";
  late String lastName = "lastName";
  late Map<String, dynamic> user;

  Future<String> getData(String url) async {
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      user = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        email = user['data']['email'];
        firstName = user['data']['first_name'];
        lastName = user['data']['last_name'];
      });
    } else {
      throw Exception('Failed to load album');
    }
    // print(user['data']['email']);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text('HTTP GET'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(email),
            Text(firstName),
            Text(lastName),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                await getData('https://reqres.in/api/users/2');
              },
              child: Text('GET DATA'),
            ),
          ],
        ),
      ),
    );
  }
}
