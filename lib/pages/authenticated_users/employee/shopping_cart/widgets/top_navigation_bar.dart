import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/widgets/circle_icon_button.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key, required this.onTapBack}) : super(key: key);
  final VoidCallback onTapBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundImage(photoUrl: imagePath + sweetHomePNG),
        backgroundColor(primaryLightColorTransparent),
        CircleIconButton(
          onTap: () {
            Navigator.of(context).pop();
            onTapBack.call();
          },
          margin: const EdgeInsets.only(top: 40, left: 10),
          iconData: Icons.arrow_back_ios,
          size: 30,
          iconColor: Colors.white,
          backgroundColor: primaryLightColorTransparent,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Text(
              'Giỏ hàng',
              style: h5.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  notificationButton(VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.notifications_active_outlined,
          color: primaryLightColor,
          size: 15,
        ),
      );

  backgroundImage({required String photoUrl}) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(photoUrl),
            fit: BoxFit.cover,
          ),
        ),
      );

  backgroundColor(Color color) => Container(
        decoration: BoxDecoration(
          color: color,
        ),
      );
}
