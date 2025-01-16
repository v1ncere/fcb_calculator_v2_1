import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/home/home.dart';
import 'package:fcb_calculator_v2_1/pages/update_password/update_password.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

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
            accountName: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 3)
                    )
                  );
                }
                if (state.status.isSuccess) {
                  return Text(
                    state.user.employeeId!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  );
                }
                if (state.status.isFailure) {
                  return Center(child: Text(state.message));
                }
                else {
                  return const SizedBox.shrink();
                }
              },
            ),
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
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 3)
                  )
                );
              }
              if (state.status.isSuccess) {
                return ListTile(
                  leading: const Icon(Icons.calendar_month_rounded),
                  title: Text('Expiry: ${getDateString(state.user.expiry!)}')
                );
              }
              if (state.status.isFailure) {
                return Center(child: Text(state.message));
              }
              else {
                return const SizedBox.shrink();
              }
            },
          ),
          ListTile(
            title: const Text('update password'),
            leading: const Icon(FontAwesomeIcons.unlock),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const UpdatePasswordPage()));
            }
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app_rounded),
            onTap: () {
              context.read<AppBloc>().add(AppLogoutRequested());
            }
          )
        ]
      )
    );
  }
}