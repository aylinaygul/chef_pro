import 'package:flutter/material.dart';

class MyDropdownButtonFormField<T> extends DropdownButtonFormField<T> {
  MyDropdownButtonFormField({
    Key? key,
    required String text,
    bool? isExpanded,
    String? validatorText,
    required super.items,
    required super.onChanged,
    super.value,
  }) : super(
          key: key,
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          isExpanded: isExpanded ?? false,
          decoration: InputDecoration(
            hintText: text,
            labelText: text,
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          ),
          validator: (value) {
            if (value == null) {
              return validatorText ?? 'Lütfen bir değer seçiniz';
            }

            return null;
          },
        );
}
