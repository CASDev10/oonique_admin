import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:oonique/constants/app_colors.dart';

class CustomDropdownWidget extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String value) onChanged;
  final Color? bgColor;

  const CustomDropdownWidget({
    super.key,
    required this.items,
    required this.onChanged,
    this.bgColor,
    this.initialValue,
  });

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(top: 1),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: selectedValue,
          hint: const Text(
            'Select Status',
            style: TextStyle(color: AppColors.titlaTextColor),
            overflow: TextOverflow.ellipsis,
          ),
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.titlaTextColor),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedValue = value;
              });
              widget.onChanged(value);
            }
          },
          iconStyleData: IconStyleData(
            icon: Icon(Icons.expand_more, color: AppColors.titlaTextColor),
          ),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              color: widget.bgColor ?? AppColors.dialogBgColor,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: AppColors.borderColor,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              color: widget.bgColor ?? AppColors.dialogBgColor,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: AppColors.borderColor),
            ),
            offset: const Offset(0, 0),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ),
    );
  }
}
