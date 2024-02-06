import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String path;

  const CustomNetworkImage({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey.withOpacity(.3)),
          width: double.infinity,
          height: double.infinity,
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Some error occured while fetching image',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
