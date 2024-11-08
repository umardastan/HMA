import 'package:accordion/accordion.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/bloc/profile/profile_cubit.dart';
import 'package:login/bloc/profile/profile_state.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/screens/components/buildInfoCard.dart';
import 'package:login/screens/components/default_button.dart';
import 'package:login/utils/constants/colors.dart';
import 'package:login/utils/constants/constantStyle.dart';
import 'package:login/utils/helper/helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late ProfileCubit profileCubit;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool isSectionOpen = false;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    profileCubit = context.read<ProfileCubit>();
    profileCubit.initData(context);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.isUpdateSuccess) {
          AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            desc: 'Data Berhasil Diupdate !!!',
            btnOkOnPress: () async {
              profileCubit.refreshData(context);
            },
          ).show();
        }

        if (state.isKeluar) {
          AwesomeDialog(
            // dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            desc: 'Data Berhasil Diupdate !!!',
            btnOkOnPress: () async {
              // profileCubit.refreshData(context);
            },
          ).show();
        }

        if (state.isUpdatePasswordSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            desc: 'Password Berhasil Diubah !!!',
            btnOkOnPress: () async {
              Navigator.pop(context);
            },
          ).show();
        }

        if(state.errorMessage.isNotEmpty){
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Failed',
            desc: state.errorMessage,
            btnOkOnPress: () async {
              // Navigator.pop(context);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: ColorApp.basic,
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        color: ColorApp.basic,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/300',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.user.name ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.user.email ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.user.jabatan ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Staff Info",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 15),
                          buildInfoCard(Icons.phone, 'Phone',
                              state.user.phone ?? 'Belum Ada'),
                          buildInfoCard(Icons.calendar_today, 'Hire Date',
                              state.user.hireDate ?? 'Belum Ada'),
                          buildInfoCard(Icons.person, 'NIK',
                              state.user.nik ?? 'Belum Ada'),
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  isSectionOpen ? ColorApp.basic : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Accordion(
                              headerBorderColor: Colors.yellow,
                              headerBackgroundColor: Colors.white,
                              headerBorderColorOpened: Colors.transparent,
                              headerBackgroundColorOpened: ColorApp.basic,
                              contentBackgroundColor: Colors.white,
                              contentBorderColor: ColorApp.basic,
                              contentBorderWidth: 3,
                              contentHorizontalPadding: 20,
                              scaleWhenAnimating: true,
                              openAndCloseAnimation: true,
                              paddingListTop: 0,
                              paddingListHorizontal: 0,
                              paddingListBottom: 0,
                              headerPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              children: [
                                AccordionSection(
                                  isOpen: isSectionOpen,
                                  header: Text(
                                    'More Info',
                                    style: ConstantStyle.defaultTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isSectionOpen
                                          ? Colors.white
                                          : Colors.black, // Ganti warna teks
                                    ),
                                  ),
                                  contentHorizontalPadding: 40,
                                  contentVerticalPadding: 20,
                                  content: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'User Name',
                                        style: ConstantStyle.textLB,
                                      ),
                                      Text(state.user.username == null
                                          ? "Belum Ada"
                                          : state.user.username!),
                                      const Gap(10),
                                      const Text(
                                        'User Type',
                                        style: ConstantStyle.textLB,
                                      ),
                                      Text(state.user.roles == null
                                          ? "Belum Ada"
                                          : state.user.roles!.role!),
                                      const Gap(10),
                                      const Text(
                                        'Project Leader',
                                        style: ConstantStyle.textLB,
                                      ),
                                      Text(state.user.projectLeader ?? '-'),
                                      const Gap(10),
                                      const Text(
                                        'Paket',
                                        style: ConstantStyle.textLB,
                                      ),
                                      // Text(state.user.pivotPakets!.isNotEmpty
                                      //     ? state
                                      //         .user.pivotPakets![0].pakets!.judul!
                                      //     : 'Belum Ada')
                                    ],
                                  ),
                                  onOpenSection: () =>
                                      setState(() => isSectionOpen = true),
                                  onCloseSection: () =>
                                      setState(() => isSectionOpen = false),
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(height: 30),
                          // ElevatedButton.icon(
                          //   onPressed: () {
                          //     // Aksi edit profil
                          //   },
                          //   icon: const Icon(Icons.edit),
                          //   label: const Text("Edit Profile"),
                          //   style: ElevatedButton.styleFrom(
                          //     minimumSize: const Size(double.infinity, 50),
                          //     backgroundColor: Colors.blueAccent,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(15),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 15),
                          Text("Action",
                              style: ConstantStyle.defaultTextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          DefaultButton(
                            fontSize: 16,
                            onPressed: () {
                              // Menampilkan BottomSheet saat tombol diklik
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                              color: ColorApp.basic,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          color: ColorApp.basic,
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          initialValue: state.name,
                                          onChanged: (value) {
                                            profileCubit.updateData(
                                                'name', value);
                                          },
                                          decoration: ConstantStyle
                                              .inputDecorationDefault("Name"),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          initialValue: state.email,
                                          onChanged: (value) {
                                            profileCubit.updateData(
                                                'email', value);
                                          },
                                          decoration: ConstantStyle
                                              .inputDecorationDefault("Email"),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          initialValue: state.phone,
                                          onChanged: (value) {
                                            profileCubit.updateData(
                                                'phone', value);
                                          },
                                          decoration: ConstantStyle
                                              .inputDecorationDefault(
                                            'Phone',
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          initialValue: state.keterangan,
                                          onChanged: (value) {
                                            profileCubit.updateData(
                                                'keterangan', value);
                                          },
                                          decoration: ConstantStyle
                                              .inputDecorationDefault(
                                                  "Keterangan"),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Tutup BottomSheet
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                              ),
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(
                                                    context); // Tutup BottomSheet
                                                profileCubit.updateProfile(
                                                    context); // Panggil fungsi logout
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorApp.button,
                                              ),
                                              child: const Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            label: "Edit Profile",
                            icon: Icons.edit_document,
                            alignment: Alignment.centerLeft,
                          ),
                          const SizedBox(height: 10),
                          DefaultButton(
                            fontSize: 16,
                            label: 'Change Password',
                            icon: Icons.key_sharp,
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Change Password',
                                          style: TextStyle(
                                              color: ColorApp.basic,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          color: ColorApp.basic,
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          initialValue: state.passwordLama,
                                          onChanged: (value) {
                                            profileCubit.updatePassword(
                                                'passwordLama', value);
                                          },
                                          decoration: ConstantStyle
                                              .inputDecorationDefault(
                                                  "Password Lama"),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          initialValue: state.passwordBaru,
                                          onChanged: (value) {
                                            profileCubit.updatePassword(
                                                'passwordBaru', value);
                                          },
                                          decoration: ConstantStyle
                                              .inputDecorationDefault(
                                                  "Password Baru"),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Tutup BottomSheet
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                              ),
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(
                                                    context); // Tutup BottomSheet
                                                profileCubit.saveUpdatePassword(
                                                    context); // Panggil fungsi logout
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorApp.button,
                                              ),
                                              child: const Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          DefaultButton(
                            fontSize: 16,
                            onPressed: () {
                              profileCubit.logout(context);
                            },
                            label: "Logout",
                            icon: Icons.logout,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
