import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children:  [
            const SizedBox(
              height: 70.0,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'City',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: Container(
                width: w * 0.8,
                height: h * 0.3,
                child: Column(
                  children:  [
                    const Text(
                      '37.30',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 90,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    // Row(
                    //   children: [
                    //
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
