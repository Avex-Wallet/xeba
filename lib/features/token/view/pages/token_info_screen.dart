import 'package:avex_mobile/model/token/token_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';

class TokenWikiPage extends StatefulWidget {
  const TokenWikiPage({required this.token, super.key});
  final TokenModel token;

  @override
  State<TokenWikiPage> createState() => _TokenWikiPageState();
}

class _TokenWikiPageState extends State<TokenWikiPage> {
  int chartIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AppBarSection(token: widget.token),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(bottom: 10),
                  child: Text(
                    'About',
                    style: inter.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '''
Tether (USDT) is an Ethereum token that pegged
to the value of a US, dollar (also known as a
stablecoin). Tether's issuer claims that USDT is
backed by bank reserves and Loans which match or
exceed the value of USDT in circulation. Important
note: at this time, Coinbase only supports USDT
on the Ethereum blockchain (ERC-20). Do not send
USDT on any other blockchain to Coinbase.
''',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 20),
                  child: Text(
                    'Market Stat',
                    style: inter.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  final titleStyle = GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.85),
                  );
                  final valueStyle = GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  );
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10)
                            .copyWith(left: 2),
                    child: Column(
                      children: [
                        ListTile(
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: -4),
                          leading: const Icon(
                            Icons.pin_invoke_outlined,
                            color: Color(0xff1D4DC5),
                          ),
                          title: Text('Market Cap', style: titleStyle),
                          trailing: Text('\$83,340,734,955', style: valueStyle),
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: -4),
                          leading: const Icon(
                            Icons.pin_invoke_outlined,
                            color: Color(0xff1D4DC5),
                          ),
                          title: Text('Volumn (24h)', style: titleStyle),
                          trailing: Text('\$25,578,593,118', style: valueStyle),
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: -4),
                          leading: const Icon(
                            Icons.pin_invoke_outlined,
                            color: Color(0xff1D4DC5),
                          ),
                          title: Text('Circulating Supply', style: titleStyle),
                          trailing:
                              Text('83,365,093,032 USDT', style: valueStyle),
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: -4),
                          leading: const Icon(
                            Icons.pin_invoke_outlined,
                            color: Color(0xff1D4DC5),
                          ),
                          title: Text('Total Supply', style: titleStyle),
                          trailing:
                              Text('86,425,711,834 USDT', style: valueStyle),
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: -4),
                          leading: const Icon(
                            Icons.pin_invoke_outlined,
                            color: Color(0xff1D4DC5),
                          ),
                          title:
                              Text('Fully Diluted M. Value', style: titleStyle),
                          trailing: Text('\$86,436,507,787', style: valueStyle),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 20),
                  child: Text(
                    'Links',
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      for (int i = 0; i < 6; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.pages_rounded),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            label: Text(
                                ['Whitepaper', 'Twitter', 'Website'][i % 3]),
                          ),
                        ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 20),
                  child: Text(
                    'Contract Address',
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  final titleStyle = GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  );
                  final valueStyle = GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  );
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: const NetworkAvatar(dimension: 20),
                          title: Text('Ethereum', style: titleStyle),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('0xdac1...1ec7', style: valueStyle),
                              const SizedBox(width: 8),
                              const Icon(Icons.copy, size: 16),
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: const NetworkAvatar(
                            dimension: 20,
                            chain: NetworkChain.polygonMainnet,
                          ),
                          title: Text('Polygon', style: titleStyle),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('0xc213...8e8f', style: valueStyle),
                              const SizedBox(width: 8),
                              const Icon(Icons.copy, size: 16),
                            ],
                          ),
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: const NetworkAvatar(
                            dimension: 20,
                            chain: NetworkChain.arbitrumMainnet,
                          ),
                          title: Text('Arbitron', style: titleStyle),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('0xfd08...cbb9', style: valueStyle),
                              const SizedBox(width: 8),
                              const Icon(Icons.copy, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection({required this.token});

  final TokenModel token;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: token.logo_url,
              height: 22,
              width: 22,
              errorWidget: (context, url, error) => const NetworkAvatar(),
            ),
          ),
          const SizedBox(width: 8),
          Text(token.contract_name),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    );
  }
}
