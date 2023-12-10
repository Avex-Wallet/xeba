// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:avex_mobile/features/advance_send/processing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/swap/controller/search.controller.dart';
import 'package:avex_mobile/features/swap/view/components/network_change.widget.dart';
import 'package:avex_mobile/features/swap/view/components/token_box_1.dart';
import 'package:avex_mobile/features/swap/view/components/token_box_2.dart';
import 'package:avex_mobile/features/swap/view/widgets/circular_swap_button.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final chainTabIndexProvider = StateProvider<int>((ref) => 0);
final token1Provider =
    StateProvider.autoDispose<(TokenModel, NetworkChain)?>((ref) => null);
final token2Provider =
    StateProvider.autoDispose<(TokenModel, NetworkChain)?>((ref) => null);
final valueToSwapProvider = StateProvider.autoDispose<double>((ref) => 0);

class SwapScreen extends ConsumerStatefulWidget {
  static const String name = 'swap';
  static const String path = '/swap';

  const SwapScreen({super.key});

  @override
  ConsumerState<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends ConsumerState<SwapScreen>
    with TickerProviderStateMixin {
  late TabController page;

  @override
  void initState() {
    super.initState();
    page = TabController(length: 2, vsync: this);
    ref.read(searchTokenProvider);
  }

  @override
  void dispose() {
    page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double slippagePercent = 0;
    Size size = MediaQuery.of(context).size;
    AppBar appBar = AppBar(
      title: const Text('SWAP'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Palette.background,
        appBar: appBar,
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SwapNetworkTab(),
                const SizedBox(height: 40),
                const Stack(
                  children: [
                    Column(
                      children: [
                        // * Token 1 Box
                        TokenBox1(),
                        SizedBox(height: 10),
                        // * Token 2 Box
                        TokenBox2(),
                      ],
                    ),
                    Positioned(
                      top: 85,
                      right: 100,
                      child: CircularSwapButton(),
                    ),
                  ],
                ),
                const Spacer(),
                TabBar(
                  controller: page,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Palette.primary,
                  tabs: [
                    Text(
                      'SLIPPAGE',
                      style: inter,
                    ),
                    Text(
                      'DETAILS',
                      style: inter,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width,
                  height: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(bottom: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Palette.secondary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StatefulBuilder(
                    builder: (context, newState) {
                      return TabBarView(
                        controller: page,
                        children: [
                          //!-slippage
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Card(),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  showValueIndicator: ShowValueIndicator.always,
                                  valueIndicatorColor: Palette.secondary,
                                  trackHeight: 10.0,
                                ),
                                child: Slider(
                                  min: 0.0,
                                  max: 5.0,
                                  value: slippagePercent,
                                  label:
                                      '${slippagePercent.toStringAsFixed(2)} %',
                                  activeColor: const Color(0xff37caf9),
                                  secondaryActiveColor: const Color(0xff151849),
                                  onChanged: (value) =>
                                      newState(() => slippagePercent = value),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Palette.secondary,
                                  ),
                                  child: Text(
                                      '${slippagePercent.toStringAsFixed(2)} %'),
                                ),
                              ),
                            ],
                          ),
                          //!-----Gas
                          Consumer(builder: (context, ef, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  title: const Text('Estimated Gas'),
                                  trailing: Text('0'.toString()),
                                ),
                              ],
                            );
                          })
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: size.width,
                  margin: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            textStyle: inter.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.white70,
                                width: 1,
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Cancel'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Consumer(builder: (context, ref, child) {
                        final token1 = ref.watch(token1Provider);
                        final token2 = ref.watch(token2Provider);
                        final swapValue = ref.watch(valueToSwapProvider);
                        bool validation() {
                          if (token1 == null || token2 == null)
                            return false;
                          else if (swapValue == 0)
                            return false;
                          else if (token1.$1.quote_rate == '0.0') return false;
                          return true;
                        }

                        final valid = validation();

                        return Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  valid ? Palette.primary : Palette.secondary,
                              textStyle: inter.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    width: 0.5,
                                    color:
                                        valid ? Palette.primary : Colors.grey),
                              ),
                            ),
                            onPressed: () async {
                              if (ref.read(swapNetworkProvider) ==
                                  NetworkChain.xdc) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProcessTxn(),
                                  ),
                                );
                                return;
                              } else
                                // if (valid) {
                                //   if (await verify(ref: ref, context: context)) {
                                SwapTxnProcessScreenRoute().push(context);
                              //   }
                              // } else {
                              //   showSnackBar(context, 'Invalid Swap');
                              // }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('Continue'),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
