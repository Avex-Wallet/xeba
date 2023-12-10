import 'package:avex_mobile/core/themes/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:avex_mobile/features/connected_app/utils/constants.dart';
import 'package:avex_mobile/features/connected_app/utils/string_constants.dart';
import 'package:avex_mobile/features/connected_app/widgets/custom_button.dart';

class UriInputPopup extends StatelessWidget {
  UriInputPopup({
    Key? key,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: StyleConstants.layerColor1NoAlpha,
      icon: ClipOval(
        child: CachedNetworkImage(
          imageUrl:
              'https://1000logos.net/wp-content/uploads/2022/05/WalletConnect-Logo.png',
          height: 40,
          width: 40,
        ),
      ),
      title: Text(
        StringConstants.enterUri,
        style: inter.copyWith(
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - StyleConstants.linear8,
        // height: 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringConstants.enterUriMessage,
              style: urbunist.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: 14.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: StyleConstants.magic10,
            ),
            TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: controller,
              decoration: const InputDecoration(
                hintStyle: StyleConstants.layerTextStyle3,
                hintText: StringConstants.textFieldPlaceholder,
                fillColor: StyleConstants.layerColor2,
                labelStyle: StyleConstants.layerTextStyle3,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      StyleConstants.magic10,
                    ),
                  ),
                ),
              ),
              autofocus: true,
            ),
            const SizedBox(
              height: StyleConstants.linear16,
            ),
            Row(
              children: [
                CustomButton(
                  type: CustomButtonType.normal,
                  onTap: () {
                    Navigator.of(context).pop(
                      controller.text,
                    );
                  },
                  child: const Text(
                    StringConstants.connect,
                    style: StyleConstants.buttonText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: StyleConstants.linear16,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                StringConstants.cancel,
                style: StyleConstants.buttonText.copyWith(
                  color: Palette.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
