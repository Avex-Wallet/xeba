// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/auth/username/service/user_service.dart';
import 'package:avex_mobile/features/send_nft/functions/nft_transfer_function.dart';
import 'package:avex_mobile/features/send_nft/view/nft_trans_processing_screen.dart';
import 'package:avex_mobile/features/send_transaction/controllers/function.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

enum TransactionSpeed { fast, standard, slow }

final speedProvider = StateProvider.autoDispose<TransactionSpeed>(
    (ref) => TransactionSpeed.standard);

class SendNFTScreen extends StatefulWidget {
  const SendNFTScreen({super.key, required this.nftData});
  final NFTModel nftData;

  @override
  State<SendNFTScreen> createState() => _SendNFTScreenState();
}

class _SendNFTScreenState extends State<SendNFTScreen> {
  late NetworkChain chain;
  bool get verified {
    if (toAddress.text.length >= 42)
      return true;
    else if (toAddress.text.endsWith('.eth'))
      return true;
    else
      return false;
  }

  bool enabled = false;

  final toAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    chain = getFromNetworkString(widget.nftData.chain!);
  }

  @override
  void dispose() {
    toAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Palette.background,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(verified ? 'Send NFT' : 'Confirm Send'),
                actions: [
                  IconButton(
                    onPressed: () => toAddress.clear(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: mq.size.height - mq.padding.top - 50,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: verified,
                              replacement: NetworkAvatar(
                                dimension: 40,
                                chain:
                                    getFromNetworkString(widget.nftData.chain!),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      Gravatar('send${toAddress.text}@avex.com')
                                          .imageUrl(),
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              magnifierConfiguration:
                                  const TextMagnifierConfiguration(
                                shouldDisplayHandlesInMagnifier: false,
                              ),
                              controller: toAddress,
                              onSubmitted: (v) async {
                                if (v.contains('.eth')) {
                                  final addr = await getAddressFromEns(v);
                                  toAddress.text = addr ?? toAddress.text;
                                } else if (!v.contains('.eth') &&
                                    !v.startsWith('0x')) {
                                  final accessToken =
                                      await SecureStorage.accessToken.value;
                                  final res = await ref
                                      .read(userServiceProvider)
                                      .getAddressByUsername(
                                          username: v,
                                          accessToken: accessToken);
                                  logger.t(res);
                                  res.fold(
                                      (l) => toAddress.text = l, (r) => null);
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
                          ],
                        ),
                      );
                    }),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          SendNftInfoTile(
                            title: 'NFTs',
                            value: '1x NFTs',
                            icon: CachedNetworkImage(
                                imageUrl: widget.nftData.image_url ?? '',
                                width: 25,
                                height: 25),
                          ),
                          const SendNftInfoTile(
                            title: 'Total Value',
                            icon: SizedBox(),
                          ),
                          Consumer(builder: (context, ref, child) {
                            final address = ref.watch(accountProvider
                                .select((value) => value.address));
                            return SendNftInfoTile(
                              title: 'From',
                              value: shortAddress(address),
                              icon: const Icon(Icons.wallet_sharp,
                                  color: Colors.pink),
                            );
                          }),
                          Visibility(
                            visible: widget.nftData.chain != null,
                            child: SendNftInfoTile(
                              title: 'Network',
                              value: getFromNetworkString(widget.nftData.chain!)
                                  .name,
                              icon: NetworkAvatar(
                                dimension: 15,
                                chain:
                                    getFromNetworkString(widget.nftData.chain!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.white10),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer(builder: (context, ref, child) {
                            final speed = ref.watch(speedProvider);
                            return GestureDetector(
                              onTap: () => ref
                                  .read(speedProvider.notifier)
                                  .state = switch (speed) {
                                TransactionSpeed.slow =>
                                  TransactionSpeed.standard,
                                TransactionSpeed.standard =>
                                  TransactionSpeed.fast,
                                TransactionSpeed.fast => TransactionSpeed.slow,
                              },
                              child: FutureBuilder<BigInt?>(
                                future: getGas(
                                  ref: ref,
                                  transactionSpeed: speed.index,
                                  chainId: chain.chainId,
                                  nftContractAddress:
                                      widget.nftData.contract_address ?? '',
                                  tokenId: int.parse(widget.nftData.token_id!),
                                  to: toAddress.text,
                                ),
                                builder: (context, snapshot) {
                                  if (!verified) {
                                    return Text(
                                      snapshot.data?.toString() ?? 'N/A',
                                      style: inter.copyWith(
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.blueGrey,
                                      child: const Text('Loading...'),
                                    );
                                  } else {
                                    return Text(
                                      snapshot.data?.toString() ?? 'N/A',
                                      style: inter.copyWith(
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                          Consumer(builder: (context, ref, child) {
                            final speed = ref.watch(speedProvider);
                            return GestureDetector(
                              onTap: () => ref
                                  .read(speedProvider.notifier)
                                  .state = switch (speed) {
                                TransactionSpeed.slow =>
                                  TransactionSpeed.standard,
                                TransactionSpeed.standard =>
                                  TransactionSpeed.fast,
                                TransactionSpeed.fast => TransactionSpeed.slow,
                              },
                              child: Text(
                                speed.name.toUpperCase(),
                                style:
                                    inter.copyWith(fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                        ],
                      ),
                      subtitle: Consumer(builder: (context, ref, child) {
                        final speed = ref.watch(speedProvider);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Gas Fees'),
                            GestureDetector(
                              onTap: () => ref
                                  .read(speedProvider.notifier)
                                  .state = switch (speed) {
                                TransactionSpeed.slow =>
                                  TransactionSpeed.standard,
                                TransactionSpeed.standard =>
                                  TransactionSpeed.fast,
                                TransactionSpeed.fast => TransactionSpeed.slow,
                              },
                              child: Text(switch (speed) {
                                TransactionSpeed.standard => '~30 secs',
                                TransactionSpeed.fast => '~15 secs',
                                TransactionSpeed.slow => '>30 secs'
                              }),
                            ),
                          ],
                        );
                      }),
                      trailing: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Consumer(builder: (context, ref, child) {
                          final speed = ref.watch(speedProvider);
                          return GestureDetector(
                            onTap: () {
                              ref.read(speedProvider.notifier).state =
                                  switch (speed) {
                                TransactionSpeed.slow =>
                                  TransactionSpeed.standard,
                                TransactionSpeed.standard =>
                                  TransactionSpeed.fast,
                                TransactionSpeed.fast => TransactionSpeed.slow,
                              };
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius:
                                      speed != TransactionSpeed.slow ? 3 : 6,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  radius: speed != TransactionSpeed.standard
                                      ? 3
                                      : 6,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius:
                                      speed != TransactionSpeed.fast ? 3 : 6,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Review the above before confirming.',
                      style: urbunist.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Once made, your transaction is irreversible.',
                      style: urbunist.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.fingerprint),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            verified ? Palette.primary : Palette.secondary,
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enableFeedback: false,
                      ),
                      onPressed: () {
                        if (!verified) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NFTTxnProcessScreen(
                              chain: chain,
                              nft: widget.nftData,
                              toAddress: toAddress.text,
                            ),
                          ),
                        );
                      },
                      label: const Text('Confirm'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: enabled,
            child: Container(
              color: Colors.black38,
              child: const Loader(size: 60),
            ),
          ),
        ],
      ),
    );
  }
}

class SendNftInfoTile extends StatelessWidget {
  const SendNftInfoTile({
    super.key,
    required this.title,
    this.value,
    required this.icon,
  });

  final String title;
  final String? value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            title,
            style: inter.copyWith(
              fontSize: 16,
              color: Colors.white54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          ClipOval(
            child: icon,
          ),
          const SizedBox(width: 7),
          Text(
            value ?? 'N/A',
            style: inter.copyWith(
              fontSize: 16,
              color: value == null ? Colors.white54 : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
