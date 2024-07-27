import 'package:flutter/material.dart';

class CustomImageSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String? darkImage;
  final String? lightImage;

  const CustomImageSwitch({
    Key? key,
    required this.value,
    this.darkImage,
    this.lightImage,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  CustomImageSwitchState createState() => CustomImageSwitchState();
}

class CustomImageSwitchState extends State<CustomImageSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _toggleValue() {
    setState(() {
      _value = !_value;
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleValue,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: _value ? widget.activeColor : widget.inactiveColor,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: _value
                  ? const EdgeInsets.only(left: 0, right: 28)
                  : const EdgeInsets.only(left: 2, right: 28),
              width: 26,
              height: 26,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _value ? Colors.transparent : widget.activeColor),
              child: widget.lightImage != null
                  ? Image.asset(
                      widget.lightImage!,
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                      color:
                          _value ? widget.inactiveColor : widget.inactiveColor,
                    )
                  : Container(),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: _value
                  ? const EdgeInsets.only(left: 31, right: 0)
                  : const EdgeInsets.only(left: 28, right: 0),
              width: 26,
              height: 26,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _value ? widget.inactiveColor : Colors.transparent,
              ),
              child: widget.darkImage != null
                  ? Image.asset(
                      widget.darkImage!,
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                      color: _value ? widget.activeColor : widget.activeColor,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _toggleValue() {
    setState(() {
      _value = !_value;
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: _toggleValue,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 57,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: _value ? widget.activeColor : widget.inactiveColor,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                      left: _value ? 26 : 0, right: _value ? 0 : 26),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _value ? widget.inactiveColor : widget.activeColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
