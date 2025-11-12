import 'package:flutter/material.dart';

class DetailArticlePage extends StatelessWidget {
  final int id;
  const DetailArticlePage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail News'), centerTitle: true),
      body: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                // backgroundImage:
                //     NetworkImage('https://via.placeholder.com/150')
                //         as ImageProvider,
              ),
              Text('Detail Article Page for Article ID: $id'),
            ],
          ),
        ),
      ),
    );
  }
}
