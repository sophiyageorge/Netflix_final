import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/colors/colors.dart';
import '../../core/constants.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(kMainImage),
            ),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButtonWidget(
                text: "My List",
                icon: Icons.add,
              ),
              kwidth50,
              _PlayButton(),
              kwidth50,
              customButtonWidget(
                text: "info",
                icon: Icons.info,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class customButtonWidget extends StatelessWidget {
  const customButtonWidget(
      {Key? key,
      required this.icon,
      required this.text,
      this.iconsize = 30,
      this.textsize = 10})
      : super(key: key);
  final icon;
  final text;
  final double iconsize;
  final double textsize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kwhite,
          size: iconsize,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: textsize,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 28,
      child: TextButton.icon(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kwhite.withOpacity(0.4)),
        ),
        icon: const Icon(
          Icons.play_arrow,
          size: 10,
          color: kBlackColor,
        ),
        label: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Text(
            "Play",
            style: TextStyle(
              fontSize: 7,
              color: kBlackColor,
            ),
          ),
        ),
      ),
    );
  }
}
