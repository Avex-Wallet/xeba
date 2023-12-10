import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/advance_send/confirm_send.dart';
import 'package:avex_mobile/features/auth/username/service/user_service.dart';
import 'package:avex_mobile/model/token/token_hits.dart';
import 'package:avex_mobile/features/send_transaction/views/components/select_asset_bottomsheet.dart';
import 'package:avex_mobile/features/send_transaction/views/pages/send_transaction.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../send_transaction/controllers/function.dart';
import '../send_transaction/views/widgets/label.widget.dart';

class AdvancedSend extends ConsumerStatefulWidget {
  const AdvancedSend({super.key});

  @override
  ConsumerState<AdvancedSend> createState() => _AdvancedSendState();
}

class _AdvancedSendState extends ConsumerState<AdvancedSend> {
  String dropdownValue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  TokenHits? token;
  String? accessToken;
  final controller = TextEditingController();
  final toAddress = TextEditingController();

  final value = TextEditingController();
  @override
  void initState() {
    super.initState();
    ref.read(assetIndexProvider);
  }

  @override
  void dispose() {
    value.dispose();
    controller.dispose();
    toAddress.dispose();
    super.dispose();
  }

  int modeIndex = 2;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // actions: const [
          //   Icon(Icons.edit),
          //   SizedBox(
          //     width: 10.0,
          //   )
          // ],
          title: const Text('Advanced Send'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mq.size.height - 50 - mq.padding.top,
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Label(label: 'To'),
              Container(
                height: 50,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2C2B32)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width - 100,
                      child: Center(
                        child: TextField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          magnifierConfiguration:
                              const TextMagnifierConfiguration(
                            shouldDisplayHandlesInMagnifier: false,
                          ),
                          controller: toAddress,
                          onSubmitted: (v) async {
                            if (v.contains('.eth')) {
                              final addr = await getAddressFromEns(v);
                              toAddress.text = addr ?? toAddress.text;
                            } else if (v.startsWith('@')) {
                              final accessToken =
                                  await SecureStorage.accessToken.value;
                              final res = await ref
                                  .read(userServiceProvider)
                                  .getAddressByUsername(
                                    username: v.substring(1),
                                    accessToken: accessToken,
                                  );
                              res.fold((l) => toAddress.text = l, (r) => null);
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            border: InputBorder.none,
                            hintText: 'Enter ENS or Address',
                            hintStyle: inter.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Card(
                      color: Colors.white12,
                      shape: const CircleBorder(),
                      child: SizedBox.square(
                        dimension: 45,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(45 / 2),
                          onTap: () async {
                            final address =
                                await QrScreenRoute(title: 'Scan QR Code')
                                    .push(context);
                            // final address = await context.pushNamed(
                            //   RouterConstant.qrScreen.name,
                            //   extra: 'Scan QR Code',
                            // );
                            if (address == null || address.toString() == '') {
                              return;
                            }
                            toAddress.text = address.toString();
                          },
                          child: const Center(
                            child: Icon(Icons.qr_code_2_rounded),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Label(label: 'What the recipients want'),
              Container(
                height: 50,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2C2B32)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        showBottomScrollAssetsSheet(context);
                        setState(() {});
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Consumer(builder: (context, ref, child) {
                              return ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: token?.logoURI ??
                                      ref
                                          .watch(currentNetworkChainProvider)
                                          .coinLogoURI,
                                  errorWidget: (context, url, error) =>
                                      const NetworkAvatar(),
                                ),
                              );
                            }),
                            Consumer(builder: (context, ref, child) {
                              return Text(
                                '  ${token?.symbol ?? ref.watch(currentNetworkChainProvider).coinSymbol} ',
                                style: inter.copyWith(),
                              );
                            }),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          magnifierConfiguration:
                              const TextMagnifierConfiguration(
                            shouldDisplayHandlesInMagnifier: false,
                          ),
                          controller: value,
                          onTapOutside: (v) => FocusScope.of(context).unfocus(),
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            border: InputBorder.none,
                            hintText: '0',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance: 1.5',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(102, 99, 99, 1),
                          fontFamily: 'Inter',
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Text(
                      'MAX',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )
                  ],
                ),
              ),
              const Label(label: 'Mode'),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => modeIndex = 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modeIndex == 0
                          ? const Color(0xFF2f89a6)
                          : const Color(0xFF2C2B32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(37.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: Text(
                      'Fastest',
                      style: inter.copyWith(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => modeIndex = 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modeIndex == 1
                          ? const Color(0xFF2f89a6)
                          : const Color(0xFF2C2B32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(37.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: const Text('Cheapest'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => modeIndex = 2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modeIndex == 2
                          ? const Color(0xFF2f89a6)
                          : const Color(0xFF2C2B32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(37.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: const Text('Recommended'),
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 163.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2f89a6)),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Color(0xFF2f89a6)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 163.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConfirmSend(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2f89a6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      child: const Text('Continue'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
