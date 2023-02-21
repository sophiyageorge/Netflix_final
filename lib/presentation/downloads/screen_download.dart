import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/downloads/widgets/app_bar_widget.dart';

import '../../core/string.dart';

class ScreenDownload extends StatelessWidget {
  ScreenDownload({super.key});

  final _widgetList = [
    kwidth,
    const _smartDownloads(),
    Section2(),
    const section3(),
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(title: " Downloads"),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, index) => _widgetList[index],
          separatorBuilder: (ctx, index) => SizedBox(height: 20),
          itemCount: _widgetList.length),
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(DownloadsEvent.getDownloadsImage());
    });

    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          'introducing downloads for you',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kwhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        kheight,
        const Text(
          'we will download a personalized selection of \n movies and shows for you, so there is\n always something to watch on your \ndevice',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        kheight,
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: Center(
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: size.width * 0.38,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          state.isLoading
                              ? SizedBox()
                              : DownloadsImageWidget(
                                  imageList:
                                      '$imageUrl${state.downloads[0].posterPath}',
                                  margin: EdgeInsets.only(
                                      left: 170, top: 50, bottom: 40),
                                  angle: 25,
                                  size: Size(
                                      size.width * 0.35, size.width * 0.55),
                                ),
                          state.isLoading
                              ? SizedBox()
                              : DownloadsImageWidget(
                                  imageList:
                                      '$imageUrl${state.downloads[1].posterPath}',
                                  margin: EdgeInsets.only(
                                      right: 170, top: 50, bottom: 40),
                                  angle: -25,
                                  size: Size(
                                      size.width * 0.35, size.width * 0.55)),
                          state.isLoading
                              ? SizedBox()
                              : DownloadsImageWidget(
                                  imageList:
                                      '$imageUrl${state.downloads[2].posterPath}',
                                  radius: 8,
                                  margin: EdgeInsets.only(bottom: 35, top: 50),
                                  size:
                                      Size(size.width * 0.4, size.width * 0.6)),
                        ],
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class section3 extends StatelessWidget {
  const section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Set up',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
        kheight,
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('See what you can download',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ],
    );
  }
}

class _smartDownloads extends StatelessWidget {
  const _smartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: kwhite,
        ),
        kwidth,
        Text('Smart Downloads'),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    Key? key,
    required this.imageList,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.radius = 5,
  }) : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRect(
        child: Container(
          margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imageList,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
