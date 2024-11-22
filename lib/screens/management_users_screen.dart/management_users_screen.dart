import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:login/bloc/dashboard/dahsboard_cubit.dart';
import 'package:login/bloc/management_user/management_user_cubit.dart';
import 'package:login/bloc/management_user/management_user_state.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/utils/constants/constantVar.dart';

class ManagementUsersScreen extends StatefulWidget {
  const ManagementUsersScreen({super.key});

  @override
  State<ManagementUsersScreen> createState() => _ManagementUsersScreenState();
}

class _ManagementUsersScreenState extends State<ManagementUsersScreen> {
  late ManagementUserCubit managementUserCubit;
  @override
  void initState() {
    super.initState();
    managementUserCubit = context.read<ManagementUserCubit>();
    managementUserCubit.initDataUsers();
    // final state = managementUserCubit.state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManagementUserCubit, ManagementUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        Color colorText = const Color(0XFFE8BCB9);
        Color cardColor = const Color(0XFF432E54);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Management Users"),
          ),
          body: state.isLoading
              ? const Center(child: LinearProgressIndicator())
              : AnimationLimiter(
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          // Panggil fungsi untuk mencari atau memfilter berdasarkan nilai 'value'
                          context
                              .read<ManagementUserCubit>()
                              .filterData(value); // contoh fungsi search
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.listUser.length,
                          itemBuilder: (context, index) {
                            final user = state.listUser[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    color: cardColor,
                                    child: ListTile(
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            color: colorText,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              size: 20,
                                            ),
                                            SizedBox(
                                                width: 60,
                                                child: Text(
                                                  user.jabatan ?? '-',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ),
                                      title: Text(user.name ?? '-',
                                          style: TextStyle(
                                              color: colorText,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email: ${user.email ?? '-'}",
                                            style: TextStyle(color: colorText),
                                          ),
                                          Text(
                                            "Hire Date: ${user.hireDate ?? '-'}",
                                            style: TextStyle(color: colorText),
                                          ),
                                          Text(
                                            "Role: ${user.roles!.description ?? '-'}",
                                            style: TextStyle(color: colorText),
                                          ),
                                        ],
                                      ),
                                      trailing: PopupMenuButton<String>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors
                                              .amber, // Ganti warna titik tiga di sini
                                        ),
                                        color: colorText,
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            context.go(
                                                "/${Routes.MAINPAGE}/${Routes.MANAGEMENTUSERS}/${Routes.ADDEDITUSERSCREEN}/true",
                                                extra: user);
                                            print(user);
                                            // Tambahkan aksi edit di sini
                                          } else if (value == 'delete') {
                                            print('delete invoked');
                                            // Tambahkan aksi delete di sini
                                          } else if (value == 'detail') {
                                            print('detail invoked');
                                            // Tambahkan aksi lihat detail di sini
                                          }
                                        },
                                        itemBuilder: (context) => const [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit,
                                                    color: Colors.blue),
                                                SizedBox(width: 8),
                                                Text("Edit"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete,
                                                    color: Colors.red),
                                                SizedBox(width: 8),
                                                Text("Delete"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'detail',
                                            child: Row(
                                              children: [
                                                Icon(Icons.info,
                                                    color: Colors.green),
                                                SizedBox(width: 8),
                                                Text("Detail"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0XFFAE445A),
            tooltip: 'Add User',
            onPressed: () {
              context.go(
                  "/${Routes.MAINPAGE}/${Routes.MANAGEMENTUSERS}/${Routes.ADDEDITUSERSCREEN}/false",
                  extra: {"isEditing": true});
            },
            child: const Icon(
              Icons.person_add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
