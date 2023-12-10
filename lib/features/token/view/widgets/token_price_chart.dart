import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/core/enums/chart_enum.dart';
import 'package:avex_mobile/features/token/controller/chart_controller.dart';
import 'package:avex_mobile/model/token/token_model.dart';

class TokenPriceChart extends ConsumerStatefulWidget {
  const TokenPriceChart({super.key, required this.token});
  final TokenModel token;

  @override
  ConsumerState<TokenPriceChart> createState() => _TokenPriceChartState();
}

class _TokenPriceChartState extends ConsumerState<TokenPriceChart> {
  ChartDay page = ChartDay.D;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < ChartDay.values.length; i++)
            Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: () {
                  ref
                      .read(chartTabIndex.notifier)
                      .update((state) => ChartDay.values.elementAt(i));
                  setState(() => page = ChartDay.values.elementAt(i));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ChartDay.values.elementAt(i) == page
                        ? Colors.white12
                        : null,
                  ),
                  child: Center(
                      child: Text(
                    ChartDay.values.elementAt(i).label,
                    style: inter.copyWith(
                      fontWeight: ChartDay.values.elementAt(i) == page
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: ChartDay.values.elementAt(i) != page
                          ? Colors.white54
                          : null,
                    ),
                  )),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class ChartSectionWidget extends ConsumerWidget {
  const ChartSectionWidget(this.token, {super.key});
  final TokenModel token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ref.watch(chartDataProvider(token)).when(
            error: (error, stackTrace) {
              return Center(
                child: Text('$error'),
              );
            },
            loading: () => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Sparkline(
                      data: const [],
                      // fillMode: FillMode.below,
                      // fillColor: Colors.indigo.withOpacity(0.2),
                      lineColor: const Color(0xff7f52d8),
                    ),
                  ),
                  const LinearProgressIndicator(
                    color: Color(0xff7f52d8),
                  ),
                ],
              ),
            ),
            data: (data) => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Sparkline(
                      data: (data),
                      fillMode: FillMode.below,
                      fillColor: Colors.indigo.withOpacity(0.2),
                      lineColor: const Color(0xff7f52d8),
                    ),
                  ),
                  // ListTile(
                  //   contentPadding:
                  //       const EdgeInsets.only(top: 10, left: 20, right: 20),
                  //   title: Text(
                  //     '\$ ${data?.last.toStringAsFixed(4) ?? '0'}',
                  //     style: inter.copyWith(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 25,
                  //     ),
                  //   ),
                  //   subtitle: Padding(
                  //     padding: const EdgeInsets.only(top: 2),
                  //     child: Builder(
                  //       builder: (context) {
                  //         final start = data?.first ?? 0;
                  //         final end = data?.last ?? 0;
                  //         final diff = end - start;
                  //         double diffPercentage = 0;
                  //         if (start != 0) {
                  //           diffPercentage = (diff / start) * 100;
                  //         }
                  //         return Text(
                  //           '${diff < 0 ? '- ' : ''}\$${(diff >= 0 ? diff : -diff).toStringAsFixed(4)} (${(diffPercentage >= 0 ? diffPercentage : -diffPercentage).toStringAsFixed(4)}%)',
                  //           style: TextStyle(
                  //             color: diff == 0
                  //                 ? Colors.grey
                  //                 : (diff > 0
                  //                     ? Colors.green
                  //                     : Colors.redAccent),
                  //             fontSize: 18,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  //   trailing: const Icon(Icons.star_border),
                  // ),
                ],
              ),
            ),
          ),
    );
  }
}
