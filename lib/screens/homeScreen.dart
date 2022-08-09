import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04), //dynamic hight on any device 
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          // padding: const EdgeInsets.only(
          //     top: 40.0, left: 20.0, right: 20.0, bottom: 20.0), better way with midia Query
          padding: const EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Per Person',
                    style: TextStyle(
                        color: Colors.purple.shade400,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Text(
                    '\$ 90.9',
                    style: TextStyle(
                        color: Colors.purple.shade400,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
