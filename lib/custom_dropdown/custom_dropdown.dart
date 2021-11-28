import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'animated_section.dart';
part 'dropdown_field.dart';
part 'dropdown_overlay.dart';
part 'overlay_builder.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? selectedStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final TextStyle? listItemStyle;
  final BorderSide? borderSide;
  final BorderSide? errorBorderSide;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool? excludeSelected;
  final Color? fillColor;

  CustomDropdown({
    Key? key,
    required this.items,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.selectedStyle,
    this.errorText,
    this.errorStyle,
    this.listItemStyle,
    this.errorBorderSide,
    this.borderRadius,
    this.borderSide,
    this.suffixIcon,
    this.onChanged,
    this.excludeSelected = true,
    this.fillColor = Colors.white,
  })  : assert(
          controller.text.isEmpty || items.contains(controller.text),
          'Controller value must match with one of the item in items list.',
        ),
        super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    /// hint text
    final hintText = widget.hintText ?? 'Select value';

    // hint style :: if provided then merge with default
    final hintStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xFFA7A7A7),
      fontWeight: FontWeight.w400,
    ).merge(widget.hintStyle);

    // selected item style :: if provided then merge with default
    final selectedStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ).merge(widget.selectedStyle);

    return _OverlayBuilder(
      overlay: (size, hideCallback) {
        return _DropdownOverlay(
          items: widget.items,
          controller: widget.controller,
          size: size,
          layerLink: layerLink,
          hideOverlay: hideCallback,
          headerStyle: widget.controller.text.isNotEmpty ? selectedStyle : hintStyle,
          suffixIcon: widget.suffixIcon,
          hintText: hintText,
          listItemStyle: widget.listItemStyle,
          excludeSelected: widget.excludeSelected,
          borderRadius: widget.borderRadius,
        );
      },
      child: (showCallback) {
        return CompositedTransformTarget(
          link: layerLink,
          child: _DropDownField(
            controller: widget.controller,
            onTap: showCallback,
            style: selectedStyle,
            borderRadius: widget.borderRadius,
            borderSide: widget.borderSide,
            errorBorderSide: widget.errorBorderSide,
            errorStyle: widget.errorStyle,
            errorText: widget.errorText,
            hintStyle: hintStyle,
            hintText: hintText,
            suffixIcon: widget.suffixIcon,
            onChanged: widget.onChanged,
            fillColor: widget.fillColor,
          ),
        );
      },
    );
  }
}
