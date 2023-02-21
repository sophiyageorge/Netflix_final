import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class EveryonesWatching extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonesWatching(
      {super.key,
      required this.posterPath,
      required this.movieName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight,
        Text(
          movieName,
          style: const TextStyle(
            fontSize: 30,
            letterSpacing: -2,
            fontWeight: FontWeight.bold,
          ),
        ),
        kheight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: kGrayColor),
        ),
        kHeight50,
        VideoWidget(
          NewAndHotImage: posterPath,
        ),
        kheight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            customButtonWidget(
              icon: Icons.share,
              text: "Share",
              iconsize: 25,
              textsize: 16,
            ),
            kwidth,
            customButtonWidget(
              icon: Icons.add,
              text: "My List",
              iconsize: 25,
              textsize: 16,
            ),
            kwidth,
            customButtonWidget(
              icon: Icons.play_arrow,
              text: "Play",
              iconsize: 25,
              textsize: 16,
            ),
            kwidth,
          ],
        ),
      ],
    );
  }
}
