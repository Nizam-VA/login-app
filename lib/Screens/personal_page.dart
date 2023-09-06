import 'package:flutter/material.dart';

class ScreenPersonal extends StatelessWidget {
  final name;
  final image;
  const ScreenPersonal({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          toolbarHeight: 70,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: image,
              ),
              SizedBox(
                width: 10,
              ),
              Text(name),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Image.asset(
            'assets/images/whatsapp.jpg',
            fit: BoxFit.cover,
          ),
        ));
  }
}
