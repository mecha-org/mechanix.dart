import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MechanixNavigationBar(
          title: "Home Page",
          height: 50,
          actionWidgets: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
            IconButton(onPressed: () {}, icon: Icon(Icons.rotate_left)),
            Text("2 items selected"),
            IconButton(onPressed: () {}, icon: Icon(Icons.three_k_outlined))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/navigation-second-route");
              },
              child: Text("Go to second page")),
        ));
  }
}
