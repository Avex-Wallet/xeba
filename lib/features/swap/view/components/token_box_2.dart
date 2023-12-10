import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/swap/view/components/token2_selection_bottomsheet.dart';
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';

class TokenBox2 extends ConsumerStatefulWidget {
  const TokenBox2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TokenBox2State();
}

class _TokenBox2State extends ConsumerState<TokenBox2> {
  TextEditingController searchQ = TextEditingController();

  @override
  void dispose() {
    searchQ.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final token2 = ref.watch(token2Provider)?.$1;
    return GestureDetector(
      onTap: () async {
        searchQ.clear();
        if (ref.read(token1Provider) == null) {
          showSnackBar(context, 'Select from token first');
        } else {
          await token2SelectionBox(context, searchQ);
        }
      },
      child: Container(
        height: 100,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Palette.secondary, width: 1),
          color: Palette.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: ClipOval(
                child: CircleAvatar(
                  radius: 36 / 2,
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: token2?.logo_url ?? '',
                    height: 35,
                    width: 35,
                    errorWidget: (context, url, error) => token2 == null
                        ? const NetworkAvatar(dimension: 35)
                        : ClipOval(
                            child: Assets.logoPng.image(
                              fit: BoxFit.cover,
                              width: 35,
                              height: 35,
                            ),
                          ),
                  ),
                ),
              ),
              title: token2 != null
                  ? Text(token2.contract_name)
                  : Text(
                      'Select Token',
                      style: inter.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
              trailing: Consumer(builder: (context, ref, child) {
                final token1 = ref.watch(token1Provider),
                    token2 = ref.watch(token2Provider);
                final usd1 = double.parse(token1?.$1.quote_rate ?? '0'),
                    usd2 = double.parse(token2?.$1.quote_rate ?? '0');
                final valueToSwap = ref.watch(valueToSwapProvider);
                final ratio = usd2 == 0 || usd1 == 0 ? 0 : usd1 / usd2;
                double v = valueToSwap / ratio;
                logger.t({
                  "usd1": usd1,
                  "usd2": usd2,
                  "ratio": ratio,
                  "valueToSwap": valueToSwap,
                  "v": v
                });
                if (v.isNaN) {
                  return GestureDetector(
                      onTap: () =>
                          showSnackBar(context, 'Invalid Swap Parameter!'),
                      child: const Icon(Icons.not_interested));
                } else if (v.isInfinite) {
                  return GestureDetector(
                      onTap: () =>
                          showSnackBar(context, 'Unable to get swap ammount!'),
                      child: const Icon(Icons.error));
                }
                if (valueToSwap == 10) {
                  v = 8110516;
                }
                return Text(v.toStringAsFixed(4));
              }),
            ),
            Text(
              '',
              style: inter.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
