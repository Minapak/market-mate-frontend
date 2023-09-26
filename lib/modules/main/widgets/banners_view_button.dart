import 'package:flutter/material.dart';
import 'package:sip_app/modules/main/models/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sip_app/constants/colors.dart';

class BannerViewButton extends StatelessWidget {
  final BannerModel banner;
  final int index;
  final int bannersLength;

  const BannerViewButton({
    required this.banner,
    required this.index,
    required this.bannersLength,
    Key? key,
  }) : super(key: key);

  void _launchURL() async {
    if (await canLaunch(banner.link)) {
      await launch(banner.link);
    } else {
      throw 'Could not launch ${banner.link}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL, // 탭 시 _launchURL 함수 호출
      child: BannerItem(
        banner: banner,
        index: index,
        bannersLength: bannersLength,
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final BannerModel banner;
  final int index;
  final int bannersLength;

  const BannerItem({
    required this.banner,
    required this.index,
    required this.bannersLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: containerHeight,
      // margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: CachedNetworkImage(
        imageUrl: banner.thumbnail,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
          ),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          color: FIXED_WIDGET_BACKGROUNG_COLOR.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                          textAlign: TextAlign.center,
                          '${index.toString()} / ${bannersLength.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))))),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: GRAY_COLOR_FONT),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          color: FIXED_WIDGET_BACKGROUNG_COLOR.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                          textAlign: TextAlign.center,
                          '${index.toString()} / ${bannersLength.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))))),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: GRAY_COLOR_FONT),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          color: FIXED_WIDGET_BACKGROUNG_COLOR.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                          textAlign: TextAlign.center,
                          '${index.toString()} / ${bannersLength.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))))),
        ),
      ),
    );
  }
}