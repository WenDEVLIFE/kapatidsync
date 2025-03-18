import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';

class CustomDropdown<T> extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final T selectedItem;
  final List<T> itemList;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabel;

  const CustomDropdown({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.selectedItem,
    required this.itemList,
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ColorUtils.secondaryColor,
        ),
        child: DropdownButton<T>(
          value: selectedItem,
          items: itemList.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                itemLabel(value),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: ColorUtils.primaryColor,
          iconEnabledColor: ColorUtils.accentColor,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          selectedItemBuilder: (BuildContext context) {
            return itemList.map<Widget>((T item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  itemLabel(item),
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList();
          },
          isExpanded: true,
          alignment: Alignment.bottomLeft,
        ),
      ),
    );
  }
}