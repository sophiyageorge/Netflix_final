import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget(
      {super.key,
      required this.id,
      required this.month,
      required this.day,
      required this.posterPath,
      required this.movieName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kGrayColor,
                ),
              ),
              Text(
                day,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(
                NewAndHotImage: posterPath,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        //letterSpacing: -2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //  const Spacer(),
                  customButtonWidget(
                    icon: Icons.alarm,
                    text: "Remind Me",
                    iconsize: 20,
                    textsize: 13,
                  ),
                  kwidth,
                  customButtonWidget(
                    icon: Icons.info,
                    text: "info",
                    iconsize: 20,
                    textsize: 13,
                  ),
                  kwidth,
                ],
              ),
              kheight,
              Text("Coming on $day $month"),
              kheight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                maxLines: 4,
                style: TextStyle(color: kGrayColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
