import 'package:flutter/material.dart';
import 'package:six_cash/util/styles.dart';
import '../../util/dimensions.dart';

class CustomDropDownButton extends StatefulWidget {
  final String value;
  final List<String> itemList;
  final Function onChanged;
  const CustomDropDownButton({
    Key key,
    @required this.value,
    @required this.itemList,
    @required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
      ),
      child: DropdownButton<String>(
        value: widget.value,
        icon: const Icon(Icons.keyboard_arrow_down),
        style: TextStyle(color: Theme.of(context).hintColor),
        underline: SizedBox(),
        onChanged: widget.onChanged,
        items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value,
            style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),));
        }).toList(),
        isExpanded: true,
      ),
    );
  }
}
