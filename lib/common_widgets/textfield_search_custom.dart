import 'package:bloc_project_structure/common_widgets/common_text.dart';
import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:bloc_project_structure/until/app_strings.dart';
import 'package:bloc_project_structure/until/fonts_constant.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class TextFieldSearch extends StatefulWidget {
  final List? initialList;

  final String? label;

  final TextEditingController controller;

  final Function? future;

  final Function? getSelectedValue;

  final InputDecoration? decoration;

  final TextStyle? textStyle;

  final ScrollbarDecoration? scrollbarDecoration;

  final int minStringLength;

  final int itemsInView;

  final FocusNode focusNodeController;

  final Function()? onTabFunction;

  final TextInputAction? textInputAction;

  final TextInputType? keyboardType;

  final void Function(String)? onChange;

  final Function(String val)? onSelectValue;

  final String? Function(String?)? validatorFunc;

  final bool Function(bool isOpen)? isMatching;

  const TextFieldSearch(
      {Key? key,
      this.isMatching,
      this.initialList,
      this.validatorFunc,
      this.onChange,
      this.keyboardType,
      this.textInputAction,
      required this.focusNodeController,
      this.onTabFunction,
      this.label,
      required this.controller,
      this.textStyle,
      this.future,
      this.getSelectedValue,
      this.onSelectValue,
      this.decoration,
      this.scrollbarDecoration,
      this.itemsInView = 3,
      this.minStringLength = 2})
      : super(key: key);

  @override
  TextFieldSearchState createState() => TextFieldSearchState();
}

class TextFieldSearchState extends State<TextFieldSearch> {
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List? filteredList = <dynamic>[];
  bool hasFuture = false;
  bool loading = false;
  final debouncer = Debouncer(milliseconds: 1000);
  static const itemHeight = 55;
  bool? itemsFound;
  ScrollController _scrollController = ScrollController();

  void resetList() {
    List tempList = <dynamic>[];
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      filteredList = tempList;
      loading = false;
    });
    // mark that the overlay widget needs to be rebuilt
    _overlayEntry.markNeedsBuild();
  }

  void setLoading() {
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
  }

  void resetState(List tempList) {
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      filteredList = tempList;
      loading = false;
      // if no items are found, add message none found
      itemsFound =
          tempList.isEmpty && widget.controller.text.isNotEmpty ? false : true;
      if(tempList.isEmpty && widget.controller.text.isNotEmpty){
        widget.isMatching!(false);
      }
    });
    // mark that the overlay widget needs to be rebuilt so results can show
    _overlayEntry.markNeedsBuild();
  }

  void updateGetItems() {
    // mark that the overlay widget needs to be rebuilt
    // so loader can show
    _overlayEntry.markNeedsBuild();
    if (widget.controller.text.length > widget.minStringLength) {
      setLoading();
      widget.future!().then((value) {
        filteredList = value;
        // create an empty temp list
        List tempList = <dynamic>[];
        // loop through each item in filtered items
        for (int i = 0; i < filteredList!.length; i++) {
          // lowercase the item and see if the item contains the string of text from the lowercase search
          if (widget.getSelectedValue != null) {
            if (filteredList![i]
                .label
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(filteredList![i]);
            }
          } else {
            if (filteredList![i]
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(filteredList![i]);
            }
          }
        }
        // helper function to set tempList and other state props
        resetState(tempList);
      });
    } else {
      // reset the list if we ever have less than 2 characters
      resetList();
    }
  }

  void updateList() {
    setLoading();
    // set the filtered list using the initial list
    filteredList = widget.initialList;

    // create an empty temp list
    List tempList = <dynamic>[];
    // loop through each item in filtered items
    for (int i = 0; i < filteredList!.length; i++) {
      // lowercase the item and see if the item contains the string of text from the lowercase search
      if (filteredList![i]
          .toLowerCase()
          .contains(widget.controller.text.toLowerCase())) {
        // if there is a match, add to the temp list
        tempList.add(filteredList![i]);
      }
    }
    // helper function to set tempList and other state props
    resetState(tempList);
  }

  @override
  void initState() {
    super.initState();

    if (widget.scrollbarDecoration?.controller != null) {
      _scrollController = widget.scrollbarDecoration!.controller;
    }

    // throw error if we don't have an initial list or a future
    if (widget.initialList == null && widget.future == null) {
      throw ('Error: Missing required initial list or future that returns list');
    }
    if (widget.future != null) {
      setState(() {
        hasFuture = true;
      });
    }
    // add event listener to the focus node and only give an overlay if an entry
    // has focus and insert the overlay into Overlay context otherwise remove it
    widget.focusNodeController.addListener(() {
      if (widget.focusNodeController.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
        // check to see if itemsFound is false, if it is clear the input
        // check to see if we are currently loading items when keyboard exists, and clear the input
        if (itemsFound == false || loading == true) {
          // reset the list so it's empty and not visible
          resetList();
          // widget.controller.clear();
          widget.isMatching!(false);
        }
        // if we have a list of items, make sure the text input matches one of them
        // if not, clear the input
        if (filteredList!.isNotEmpty) {
          bool textMatchesItem = false;
          if (widget.getSelectedValue != null) {
            widget.isMatching!(true);
            // try to match the label against what is set on controller
            textMatchesItem = filteredList!
                .any((item) => item.label == widget.controller.text);
          } else {
            widget.isMatching!(true);
            textMatchesItem = filteredList!.contains(widget.controller.text);
          }
          // if (textMatchesItem == false) widget.controller.clear();

          if (textMatchesItem == false) {
            widget.isMatching!(false);
          }
          resetList();
        }
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // widget.controller.dispose();
    super.dispose();
  }

  ListView _listViewBuilder(context) {
    if (itemsFound == false) {
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        controller: _scrollController,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // clear the text field controller to reset it
              // widget.controller.clear();
              widget.isMatching!(false);
              setState(() {
                itemsFound = false;
              });
              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: const ListTile(
              title: CommonAppText(
                text: AppStrings.noMatchingItems,
                fontSize: FontSizeConstant.font_15,
                fontWeight: FontWeightConstant.medium,
                textAlignment: TextAlign.start,
              ),
              trailing: Icon(Icons.cancel,color: AppColors.blackTextColor,),
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: filteredList!.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              // set the controller value to what was selected
              setState(() {
                // if we have a label property, and getSelectedValue function
                // send getSelectedValue to parent widget using the label property
                if (widget.getSelectedValue != null) {
                  widget.controller.text = filteredList![i].label;
                  widget.getSelectedValue!(filteredList![i]);
                  widget.onSelectValue!(filteredList![i].label);
                  widget.isMatching!(true);
                } else {
                  widget.isMatching!(true);
                  widget.controller.text = filteredList![i];
                  widget.onSelectValue!(filteredList![i]);
                }
              });

              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: ListTile(
                title: widget.getSelectedValue != null
                    ? CommonAppText(
                  text: filteredList![i].label,
                  fontSize: FontSizeConstant.font_15,
                  fontWeight: FontWeightConstant.semiBold,
                  textAlignment: TextAlign.start,
                )
                : CommonAppText(
                  text: filteredList![i],
                  fontSize: FontSizeConstant.font_15,
                  fontWeight: FontWeightConstant.semiBold,
                  textAlignment: TextAlign.start,
                )
            )
        );

      },
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  /// A default loading indicator to display when executing a Future
  Widget _loadingIndicator() {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  Widget decoratedScrollbar(child) {
    if (widget.scrollbarDecoration is ScrollbarDecoration) {
      return Theme(
        data: Theme.of(context)
            .copyWith(scrollbarTheme: widget.scrollbarDecoration!.theme),
        child: Scrollbar(child: child, controller: _scrollController),
      );
    }

    return Scrollbar(child: child);
  }

  Widget? _listViewContainer(context) {
    if (itemsFound == true && filteredList!.isNotEmpty ||
        itemsFound == false && widget.controller.text.isNotEmpty) {
      return Container(
          height: calculateHeight().toDouble(),
          color: AppColors.whiteColor,
          child: decoratedScrollbar(_listViewBuilder(context)));
    }
    return null;
  }

  num heightByLength(int length) {
    return itemHeight * length;
  }

  num calculateHeight() {
    if (filteredList!.length > 1) {
      if (widget.itemsInView <= filteredList!.length) {
        return heightByLength(widget.itemsInView);
      }

      return heightByLength(filteredList!.length);
    }

    return itemHeight;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size overlaySize = renderBox.size;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: overlaySize.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, overlaySize.height + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: screenWidth,
                        maxWidth: screenWidth,
                        minHeight: 0,
                        maxHeight: calculateHeight().toDouble(),
                      ),
                      child: loading
                          ? _loadingIndicator()
                          : _listViewContainer(context)),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        onTap: widget.onTabFunction,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        // onChanged: widget.onChange,
        validator: widget.validatorFunc,
        controller: widget.controller,
        focusNode: widget.focusNodeController,
        decoration:
            widget.decoration ?? InputDecoration(labelText: widget.label),
        style: widget.textStyle,
        onChanged: (String value) {
          // every time we make a change to the input, update the list
          debouncer.run(() {
            setState(() {
              if (hasFuture) {
                updateGetItems();
              } else {
                updateList();
              }
            });
          });
        },
      ),
    );
  }
}

class Debouncer {
  /// A length of time in milliseconds used to delay a function call
  final int? milliseconds;

  /// A callback function to execute
  VoidCallback? action;

  /// A count-down timer that can be configured to fire once or repeatedly.
  Timer? _timer;

  /// Creates a Debouncer that executes a function after a certain length of time in milliseconds
  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}

class ScrollbarDecoration {
  const ScrollbarDecoration({
    required this.controller,
    required this.theme,
  });

  /// {@macro flutter.widgets.Scrollbar.controller}
  final ScrollController controller;

  /// {@macro flutter.widgets.ScrollbarThemeData}
  final ScrollbarThemeData theme;
}