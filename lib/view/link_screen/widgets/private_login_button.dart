import 'package:flutter/material.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/eums/link_page_state.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:new_started/view/link_screen/screens/all_link_screen.dart';
import 'package:new_started/view/link_screen/widgets/local_auth_api.dart';

Widget buildAuthenticate(BuildContext context) => GestureDetector(
      onTap: () async {
        final isAuthenticated = await LocalAuthApi.authenticate();

        if (isAuthenticated) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    AllLinkScreen(linkPageState: LinkPageState.private)),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(Dimens.medium),
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
            color: SolidColors.colorPrimary, shape: BoxShape.circle),
        child: Image.asset(
          Assets.images.fingerprint.path,
          scale: 3,
        ),
      ),
    );

Widget buildButton({
  required String text,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      icon: Icon(icon, size: 26),
      label: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      onPressed: onClicked,
    );
