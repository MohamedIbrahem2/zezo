import 'package:flutter/material.dart';

class MyOfficialPapers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Official Papers',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.add_a_photo)
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '* COMMERCIAL REGISTER',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 35,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '* VAT number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 35,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '* Shop photo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 35,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '* Order documents',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 35,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
