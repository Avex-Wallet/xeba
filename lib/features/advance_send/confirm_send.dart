import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/advance_send/processing_screen.dart';
import 'package:flutter/material.dart';

class ConfirmSend extends StatelessWidget {
  const ConfirmSend({super.key});

  @override
  Widget build(BuildContext context) {
    List send = ['0.1 ETH'];
    List deduct = ['98.2 USDT', '55.8 MATIC', '0.243 BNB'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Advanced Send'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Token to be sent to the recipient',
                  style: inter.copyWith(
                    color: const Color.fromARGB(255, 111, 193, 220),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                for (var name in send)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [const Text('\$  '), Text('$name')],
                      ),
                      const SizedBox(
                        height: 15.0,
                      )
                    ],
                  ),
                Text('Token to be deducted',
                    style: inter.copyWith(
                      color: const Color.fromARGB(255, 111, 193, 220),
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                for (var name in deduct)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('\$  '),
                          Text(
                            '$name',
                            style: inter.copyWith(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      )
                    ],
                  ),
              ],
            ),
            Column(
              children: [
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
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                        child: Text(
                          'Reset',
                          style: inter.copyWith(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 111, 193, 220)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 163.0,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ProcessTxn();
                            },
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2f89a6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                        child: Text(
                          'Continue',
                          style: inter.copyWith(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
