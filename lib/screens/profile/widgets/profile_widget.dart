import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/profile-icon.svg'),
          const SizedBox(width: 20),
          const Text('Olá, Supermercados Alvorada'),
        ],
      ),
    );
  }
}