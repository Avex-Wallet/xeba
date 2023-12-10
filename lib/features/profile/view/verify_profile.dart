import 'package:avex_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class VerifyProfile extends StatefulWidget {
  const VerifyProfile({super.key});

  @override
  State<VerifyProfile> createState() => _VerifyProfileState();
}

class _VerifyProfileState extends State<VerifyProfile> {
  String name = 'maharsi.avex';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Your Profile'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  radius: 65.0,
                  backgroundColor: Color(0xFFD9D9D9),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                    child: Text(
                  name,
                  style: const TextStyle(fontSize: 34),
                )),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Enter you name',
                  style: inter.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40.0,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 30.0, color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Enter your age',
                  style: inter.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40.0,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[800]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Enter your Nationality',
                  style: inter.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40.0,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[800]),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2f89a6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(37.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      child: const Text('cancel',
                          style: TextStyle(color: Colors.white))),
                ),
                SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2f89a6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(37.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: const Text('verify',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
