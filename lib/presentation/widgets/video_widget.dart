import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix_app/core/string.dart';

import '../../core/colors/colors.dart';
import '../../core/constants.dart';

class VideoWidget extends StatelessWidget {
  final String NewAndHotImage;
  const VideoWidget({super.key, required this.NewAndHotImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            '$imageUrl$NewAndHotImage',
            fit: BoxFit.cover,
            loadingBuilder:
                (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
            errorBuilder: ((BuildContext _, Object a, StackTrace? trace) {
              return const Center(
                child: Icon(
                  Icons.wifi,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.volume_off,
                color: kwhite,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
