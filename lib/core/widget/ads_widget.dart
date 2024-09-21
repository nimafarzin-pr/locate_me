import 'package:adivery/adivery.dart';
import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';

class AdsWidget extends StatefulWidget {
  const AdsWidget({
    super.key,
  });

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  void initState() {
    super.initState();
    AdiveryPlugin.initialize("590d563d-6919-4461-b22d-97d79588acf6");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: 50,
      // width: 200,
      child: BannerAd(
        "a4e70a70-35ba-465e-bc7e-314cd9751f2b",
        BannerAdSize.BANNER,
        onAdLoaded: (ad) {
          ad.loadAd();
          ad.show();
        },
        onAdClicked: (ad) {
          ad.loadAd();
          ad.show();
        },
      ),
    );
  }
}
