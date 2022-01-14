import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartstart/Constanst.dart';
import 'package:smartstart/PhoneNumberAuthScreen.dart';

class DrawerWidget extends StatefulWidget {

  DrawerWidget(
      {Key? key})
      : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: const DecorationImage(
                              image: const AssetImage('assets/images/Splash.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.black12,
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ListTile(
                        title: const Text(
                            'Jatin Balani',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,),
                        subtitle: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Edit Profile',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              // appStore.bookingStatus.toString(),
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            onTap: () {},
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text(
              'logout',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              showDialog(
                  builder: (ctxt) {
                    return AlertDialog(
                        title: const Text("Logout"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Do you Really want to logout?"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text("Logout"),
                                  onPressed: () {
                                    Constanst.setLogIn(false);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PhoneNumberAuthScreen(),));
                                  },
                                )
                              ],
                            ),
                          ],
                        ));
                  },
                  context: context);
            },
          ),
        ],
      ),
    );
  }
}

