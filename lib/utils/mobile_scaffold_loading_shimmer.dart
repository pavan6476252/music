import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class MobileScaffoldShimmer extends StatelessWidget {
  const MobileScaffoldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
      ),
      body: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 224, 224, 224),
        highlightColor: const Color.fromARGB(255, 245, 245, 245),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              width: double.maxFinite,
              height: 180,
            ),
            Expanded(
              child: ListView.builder(
                
                itemCount: 10, // Adjust the number of shimmering cards as needed
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 30,
                      ),
                      title: Container(
                        margin: const EdgeInsets.all(5),
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.all(5),
                        height: 10,
                        color: Colors.grey[300],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
