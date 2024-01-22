import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text('${FirebaseAuth.instance.currentUser!.email}'),
            accountName: const Text('Hello'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color(0xFF00695C),
              child: ClipOval(
                child: Icon(
                  FontAwesomeIcons.faceSmile,
                  color: Colors.white,
                  size: 50
                )
              )
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/profile-bg.png')
              )
            )
          ),
          // const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              context.read<AppBloc>().add(AppLogoutRequested());
            }
          )
        ]
      )
    );
  }
}