import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../ui/input/input_field.dart';
import '../../../../../ui/widgets/custom_dropdown.dart';
import '../../../../../ui/widgets/on_click.dart';
import '../cubits/update_ticket/update_ticket_cubit.dart';
import '../models/all_support_response.dart';
import '../pages/support_page_mobile.dart';

class AddResponseDialogue extends StatefulWidget {
  const AddResponseDialogue({super.key, required this.model});

  final SupportResponseModel model;
  @override
  State<AddResponseDialogue> createState() => _AddResponseDialogueState();
}

class _AddResponseDialogueState extends State<AddResponseDialogue> {
  String? status;
  final TextEditingController responseMessageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),

      child: Container(
        padding: EdgeInsets.all(14.0),
        width:
            MediaQuery.of(context).size.width >= 1100
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width >= 850
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width >= 650
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Respond to Ticket",
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OnClick(
                  onTap: () {
                    NavRouter.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Icon(Icons.close, size: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            InputField(
              controller: responseMessageController,
              label: "Response Message",
              maxLines: 4,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 8.0),
            CustomDropDown(
              hint: "Select Status",
              items: ["Pending", "In Progress", "Resolved"],
              onSelect: (v) {
                status = returnStatus(v);
              },
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () async {
                      if (responseMessageController.text.isNotEmpty) {
                        await context
                            .read<UpdateTicketCubit>()
                            .addTicketResponse(
                              supportId: widget.model.id,
                              message: responseMessageController.text,
                            )
                            .then((v) async {
                              await context
                                  .read<UpdateTicketCubit>()
                                  .updateTicket(
                                    supportId: widget.model.id,
                                    status: status!,
                                  )
                                  .then((v) async {
                                    NavRouter.pop(context);
                                  });
                            });
                      }
                    },
                    title: "Save",
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: PrimaryOutlineButton(
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.black,
                    titleColor: Colors.black,
                    onPressed: () {
                      NavRouter.pop(context);
                    },
                    title: "Cancel",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
