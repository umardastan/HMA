import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:login/bloc/dashboard/dahsboard_cubit.dart';
import 'package:login/bloc/dashboard/dashboard_state.dart';
import 'package:login/screens/components/dashboard_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardCubit dashboardCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    dashboardCubit = context.read<DashboardCubit>();
    dashboardCubit.cekExpiredToken();
    dashboardCubit.initRole();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
      if (state.isExpired) {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          title: 'Warning',
          desc: 'Token Expired !!!',
          btnOkOnPress: () async {
            dashboardCubit.logout(context);
          },
        ).show();
      }
      if (state.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logout gagal !!!'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian Card di bawah
              AnimationLimiter(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: state.menu.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    // Kondisi untuk mengabaikan item jika role == '4' dan title == 'Management Users'
                    if (state.role == '4' && item.title == "Management Users") {
                      return const SizedBox
                          .shrink(); // Mengembalikan widget kosong
                    }
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        curve: Curves.bounceIn,
                        verticalOffset: 100.0,
                        child: // atur disini
                            DashboardCard(
                                icon: item.icon,
                                title: item.title,
                                subtitle: '',
                                color: item.color,
                                onClick: () {
                                  context
                                      .read<DashboardCubit>()
                                      .clickMenu(item.title, context);
                                }),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ));
    });
  }
}
