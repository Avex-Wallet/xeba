import 'package:avex_mobile/features/profile/view/verify_profile.dart';
import 'package:flutter/material.dart';

class YourProfile extends StatefulWidget {
  const YourProfile({super.key});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  String name = 'maharsi.avex';

  int age = 20;

  String nationality = 'Indian';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const VerifyProfile();
              },
            )),
          ),
          const SizedBox(
            width: 10.0,
          )
        ],
        title: const Text('Your Profile'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: Column(
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
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name : $name',
                  style: const TextStyle(fontSize: 18.0),
                ),
                // const Text(
                //   'Verified',
                //   style: TextStyle(color: Colors.blue, fontSize: 18.0),
                // )
                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Age : $age',
                  style: const TextStyle(fontSize: 18.0),
                ),
                // const Text(
                //   'Verified',
                //   style: TextStyle(color: Colors.blue, fontSize: 18.0),
                // )
                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nationality : $nationality',
                  style: const TextStyle(fontSize: 18.0),
                ),
                // const Text(
                //   'Verified',
                //   style: TextStyle(color: Colors.blue, fontSize: 18.0),
                // )
                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
