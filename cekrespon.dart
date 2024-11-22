// showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 builder: (context) {
//                   return BlocBuilder<DarCubit, DarState>(
//                     builder: (context, state) {
//                       // Cek jika selectedUserForTask tidak ada dalam daftar users
//                       User? validatedUser = state.selectedUserForTask;
//                       if (validatedUser != null &&
//                           !state.users.contains(validatedUser)) {
//                         // Set ke null jika user yang dipilih tidak ditemukan dalam daftar
//                         validatedUser = null;
//                         // Emit state baru dengan null jika diperlukan
//                         context
//                             .read<DarCubit>()
//                             .setSelectedUserForTask(null, context);
//                       }
//                       return Container(
//                         decoration: const BoxDecoration(
//                             color: ColorApp.basic,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10))),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Filter Data',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: const Text(
//                                     'Start Date Task',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   subtitle: Text(
//                                     '${state.fromDate} s/d ${state.toDate}',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                     ),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                   onTap: () => context
//                                       .read<DarCubit>()
//                                       .pickDateRange(context),
//                                 ),
//                                 ListTile(
//                                   title: const Text(
//                                     'Status',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   subtitle: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       ...state.listStatus.map((item) {
//                                         return Row(
//                                           children: [
//                                             Radio<String>(
//                                               fillColor: WidgetStateProperty
//                                                   .resolveWith<Color>(
//                                                 (Set<WidgetState> states) {
//                                                   return Colors.white;
//                                                 },
//                                               ),
//                                               value: item,
//                                               groupValue: state.selectedStatus,
//                                               onChanged: (String? value) {
//                                                 context
//                                                     .read<DarCubit>()
//                                                     .selectStatus(
//                                                         item, context);
//                                               },
//                                             ),
//                                             Text(
//                                               item,
//                                               style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 1.0),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton2<User>(
//                                       isExpanded: true,
//                                       hint: const Text(
//                                         'Filter Name',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           // color: Colors.white,
//                                         ),
//                                       ),
//                                       items: state.users
//                                           .map((item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item.name!,
//                                                   style: const TextStyle(
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                       value: validatedUser,
//                                       onChanged: (value) {
//                                         darCubit.setSelectedUserForTask(
//                                             value, context);
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10)),
//                                             color: Colors.white),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 200,
//                                       ),
//                                       dropdownStyleData:
//                                           const DropdownStyleData(
//                                         maxHeight: 200,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownSearchData: DropdownSearchData(
//                                         searchController: textEditingController,
//                                         searchInnerWidgetHeight: 50,
//                                         searchInnerWidget: Container(
//                                           height: 50,
//                                           padding: const EdgeInsets.only(
//                                             top: 8,
//                                             bottom: 4,
//                                             right: 8,
//                                             left: 8,
//                                           ),
//                                           child: TextFormField(
//                                             expands: true,
//                                             maxLines: null,
//                                             controller: textEditingController,
//                                             decoration: InputDecoration(
//                                               isDense: true,
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 10,
//                                                 vertical: 8,
//                                               ),
//                                               hintText: 'Search for name...',
//                                               hintStyle:
//                                                   const TextStyle(fontSize: 12),
//                                               border: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         searchMatchFn: (item, searchValue) {
//                                           return item.value
//                                               .toString()
//                                               .contains(searchValue);
//                                         },
//                                       ),
//                                       //This to clear the search value when you close the menu
//                                       onMenuStateChange: (isOpen) {
//                                         if (!isOpen) {
//                                           textEditingController.clear();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Text(state.role),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );