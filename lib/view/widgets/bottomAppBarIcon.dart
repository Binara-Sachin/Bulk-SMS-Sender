import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:flutter/material.dart';

class BottomAppBarIcon extends StatefulWidget {
  final IconData icon;
  final int index;
  final int pageIndex;
  final Function onPressed;
  final String title;
  final bool showText;

  const BottomAppBarIcon(
      {Key key,
      this.icon,
      this.index,
      this.onPressed,
      this.pageIndex,
      this.title,
      this.showText})
      : super(key: key);

  @override
  _BottomAppBarIconState createState() => _BottomAppBarIconState();
}

class _BottomAppBarIconState extends State<BottomAppBarIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.showText
          ? Text(
              widget.title,
              style: widget.index == widget.pageIndex
                  ? AppTextStyles.blue_body01
                  : AppTextStyles.grey_body01,
            )
          : Icon(
              widget.icon,
              color:
                  widget.index == widget.pageIndex ? Colors.blue : Colors.grey,
            ),
      onTap: widget.onPressed,
    );
  }
}
