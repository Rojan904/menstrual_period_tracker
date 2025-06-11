import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/theme.dart';

class StarRatingMultiChip extends StatefulWidget {
  // var resetChip;
  const StarRatingMultiChip({
    Key? key,
    required this.onSelectionChanged,
    required this.filtertype,
    // this.resetChip,
  }) : super(key: key);
  final Function(List<String>) onSelectionChanged;
  final List filtertype;
  @override
  State<StarRatingMultiChip> createState() => _MultiSelectFilterChipState();
}

class _MultiSelectFilterChipState extends State<StarRatingMultiChip> {
  List<String> selected = [];

  buildFilterList() {
    List<Widget> choices = [];
    for (var item in widget.filtertype) {
      // void resetChip(String choices) {
      //   setState(() {
      //     selected.clear();
      //   });
      // }

      choices.add(Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 4, top: 4),
        child: Theme(
          data: ThemeData(),
          child: ChoiceChip(
            selectedColor: kPrimaryColor,
            backgroundColor: Colors.transparent,
            side: BorderSide(
                color: selected.contains(item.filterType!)
                    ? Colors.transparent
                    : kDarkGreyColor,
                width: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            label: Text(
              item.filterText!,
              style: const TextStyle(fontSize: 12),
            ),
            labelStyle: TextStyle(
              color: selected.contains(item.filterText!) == true
                  ? Colors.white
                  : kDarkGreyColor,
            ),
            labelPadding: item.icon
                ? const EdgeInsets.fromLTRB(0, 6, 6, 6)
                : const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            selected: selected.contains(item.filterText),
            onSelected: (select) {
              setState(() {
                selected.contains(item.filterText)
                    ? selected.remove(item.filterText)
                    : selected.add(item.filterText!);
                widget.onSelectionChanged(selected);
              });
            },
          ),
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: buildFilterList(),
    );
  }
}
