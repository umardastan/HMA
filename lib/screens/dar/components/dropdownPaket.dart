import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/management_user/management_user_cubit.dart';
import 'package:login/bloc/management_user/management_user_state.dart';
import 'package:login/model/paket.dart';

class DropdownPaket extends StatelessWidget {
  final bool isReadOnly;
  final String label;
  const DropdownPaket(
      {super.key, required this.isReadOnly, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocConsumer<ManagementUserCubit, ManagementUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DropdownButtonFormField2<Pakets>(
            decoration: InputDecoration(
                labelText: label, border: const OutlineInputBorder()),
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
}
