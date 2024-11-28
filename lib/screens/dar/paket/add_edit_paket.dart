import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/management_user/management_user_cubit.dart';
import 'package:login/bloc/management_user/management_user_state.dart';
import 'package:login/bloc/paket/paket_cubit.dart';
import 'package:login/bloc/paket/paket_state.dart';
import 'package:login/model/detail_paket.dart';
import 'package:login/model/paket.dart';
import 'package:login/model/role.dart';

// Data model untuk UserType
const userTypeList = ['Admin', 'User', 'Manager'];

class AddEditPaket extends StatefulWidget {
  final String type;
  final DetailPaket paket;
  // final List<Pakets> listpaket;

  const AddEditPaket({
    super.key,
    required this.type,
    required this.paket,
    // required this.listpaket,
  });

  @override
  _AddEditPaketState createState() => _AddEditPaketState();
}

class _AddEditPaketState extends State<AddEditPaket> {
  final _formKey = GlobalKey<FormState>();

  List<Pakets> selectedPackages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ini data paket => ${widget.paket.id}");
    if (widget.type == "edit" || widget.type == "detail") {
      context.read<PaketCubit>().parsingData(widget.paket);
    } else {
      context.read<PaketCubit>().resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaketCubit, PaketState>(
      listener: (context, state) {
        if (state.message.isNotEmpty &&
            state.titleMessage.isNotEmpty &&
            state.typeMessage.isNotEmpty) {
          AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: state.typeMessage == 'success'
                ? DialogType.success
                : state.typeMessage == 'warning'
                    ? DialogType.warning
                    : DialogType.error,
            animType: AnimType.topSlide,
            title: state.titleMessage,
            desc: state.message,
            btnOkOnPress: () async {
              // profileCubit.refreshData(context);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.type == 'edit'
                ? 'Edit Paket'
                : widget.type == 'detail'
                    ? 'Detail Paket'
                    : 'Tambah Paket'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // buildTextField('User ID', userIdController),
                  buildTextField(
                      controller: state.kodepaketTextEditingController,
                      label: 'Kode Paket',
                      onChange: (String value) {},
                      isReadOnly: widget.type == 'detail'),
                  buildTextField(
                    controller: state.judulTextEditingController,
                    label: 'Judul',
                    isReadOnly: widget.type == 'detail',
                    onChange: (value) {},
                  ),
                  buildTextField(
                    controller: state.tahunTextEditingController,
                    label: 'Tahun',
                    isNumber: true,
                    isReadOnly: widget.type == 'detail',
                    onChange: (value) {},
                  ),
                  buildTextField(
                    controller: state.keteranganTextEditingController,
                    isReadOnly: widget.type == 'detail',
                    label: 'Keterangan',
                    maxLines: 3,
                    onChange: widget.type == 'detail' ? null : (value) {},
                  ),
                  const SizedBox(height: 20),
                  if (widget.type != 'detail')
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('tampilkan dialog');
                          AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.topSlide,
                            title: "Konfirmasi",
                            desc:
                                "Apakah anda yakin ingin ${widget.type == 'edit' ? 'Update' : 'Simpan'} paket ${state.judulTextEditingController.text} ???",
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              // profileCubit.refreshData(context);
                              switch (widget.type) {
                                case 'edit':
                                  context
                                      .read<PaketCubit>()
                                      .updatePaket(widget.paket);
                                  break;
                                case 'tambah':
                                  context
                                      .read<PaketCubit>()
                                      .savePaket();
                                  break;
                                default:
                              }
                            },
                          ).show();
                        }
                      },
                      child: Text(widget.type == 'edit' ? 'Update' : 'Simpan'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget untuk Dropdown UserType
  Widget buildUserTypeDropdown(List<Role> listRole, {bool isReadonly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocConsumer<ManagementUserCubit, ManagementUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          // Debugging
          print("Selected Role: ${state.selectedRole}");
          print("List Roles: ${listRole.map((role) => role.role).toList()}");
          return DropdownButtonFormField2<Role>(
            decoration: const InputDecoration(
              labelText: 'User Type',
              border: OutlineInputBorder(),
            ),
            items: listRole
                .map((role) => DropdownMenuItem<Role>(
                      value: role,
                      child: Text(role.role!),
                    ))
                .toList(),
            onChanged: isReadonly
                ? null // Set onChanged ke null untuk membuatnya readonly
                : (Role? value) {
                    context.read<ManagementUserCubit>().setSelectedRole(value!);
                  },
            value: state.selectedRole,
            validator: (value) => value == null ? 'Pilih User Type' : null,
          );
        },
      ),
    );
  }

  // Widget untuk Dropdown Project Leader
  Widget buildProjectLeaderDropdown({required bool isReadOnly}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocConsumer<ManagementUserCubit, ManagementUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DropdownButtonFormField2<Pakets>(
            decoration: const InputDecoration(
                labelText: 'Project Leader', border: OutlineInputBorder()),
            items: state.listPaket
                .map((paket) => DropdownMenuItem<Pakets>(
                      value: paket,
                      child: Tooltip(
                        message: paket.judul ?? '',
                        child: Text(
                          paket.judul ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: isReadOnly
                ? null
                : (value) {
                    context
                        .read<ManagementUserCubit>()
                        .setSelectedProjectLeader(value!);
                  },
            value: state.selectedProjectLeader,
            validator: (value) => value == null ? 'Pilih Project Leader' : null,
            isExpanded: true,
            dropdownStyleData: const DropdownStyleData(maxHeight: 200),
          );
        },
      ),
    );
  }

  Widget buildMultipleChoiceChips({required bool isReadOnly}) {
    return BlocConsumer<ManagementUserCubit, ManagementUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 5.0,
                children: List<Widget>.generate(
                  state.listPaket.length,
                  (int index) {
                    final item = state.listPaket[index];
                    final isSelected =
                        state.selectedPakets.contains(item.id.toString());

                    return InputChip(
                      label: Text(item.kodePaket ?? ''),
                      selected: isSelected,
                      backgroundColor:
                          Colors.white, // Warna chip ketika tidak dipilih
                      selectedColor: Colors.green,
                      onSelected: isReadOnly
                          ? null
                          : (bool selected) {
                              print(selected);
                              setState(() {
                                if (isSelected) {
                                  // Hapus dari array jika sudah dipilih
                                  state.selectedPakets
                                      .remove(item.id.toString());
                                } else {
                                  // Tambahkan ke array jika belum dipilih
                                  state.selectedPakets.add(item.id!.toString());
                                  print(state.selectedPakets);
                                }
                              });
                            },
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    state.selectedPakets.clear(); // Reset pilihan
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextField({
    required String label,
    required Null Function(String value)? onChange,
    required TextEditingController controller,
    bool isPassword = false,
    bool isNumber = false,
    bool isEmail = false,
    int maxLines = 1,
    int? maxLength,
    bool isReadOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        obscureText: isPassword,
        readOnly: isReadOnly,
        keyboardType: isNumber
            ? TextInputType.number
            : isEmail
                ? TextInputType.emailAddress
                : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          if (label == 'Email') {
            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (!emailRegex.hasMatch(value)) {
              return 'Email tidak valid';
            }
          }
          return null;
        },
        maxLines: maxLines,
        onChanged: onChange,
      ),
    );
  }

  Widget buildTextFieldDate({required String label, bool isReadonly = false}) {
    return BlocConsumer<ManagementUserCubit, ManagementUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return TextFormField(
            readOnly: true,
            controller: state.selectedHireDate,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label tidak boleh kosong';
              }
              return null;
            },
            // onChanged: onChange,
            onTap: isReadonly
                ? null
                : () async {
                    context.read<ManagementUserCubit>().selectDate(context);
                  },
          );
        });
  }
}
