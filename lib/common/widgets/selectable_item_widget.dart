import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/model/role/role.dart';

class SelectableItemWidget<T> extends StatefulWidget {
  final T item;
  final VoidCallback? onLongPress;
  final VoidCallback? onRemovePhobiaState;

  const SelectableItemWidget(
      {Key? key,
      required this.item,
      this.onLongPress,
      this.onRemovePhobiaState})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectableItemWidgetState();
}

class SelectableItemWidgetState extends State<SelectableItemWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool isInPhobiaState = false;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 333), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: -0.133, end: 0.133)
        .chain(CurveTween(curve: Curves.easeInOutSine))
        .animate(controller!);

    return GestureDetector(
      onLongPress: () {
        widget.onLongPress?.call();
      },
      onTapUp: (d) {
        if (isInPhobiaState) {
          widget.onRemovePhobiaState?.call();
        } else {
          setState(() {
            widget.item.isSelected = !widget.item.isSelected;
          });
        }
      },
      child: AnimatedBuilder(
        animation: offsetAnimation,
        builder: (BuildContext context, child) {
          return Transform.rotate(
            angle: isInPhobiaState ? offsetAnimation.value : 0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.item is Role
                      ? widget.item.group.id == 1
                          ? widget.item.isSelected
                              ? Colors.red
                              : Colors.red.shade100
                          : widget.item.group.id == 2
                              ? widget.item.isSelected
                                  ? Colors.green
                                  : Colors.green.shade100
                              : widget.item.isSelected
                                  ? Colors.yellow
                                  : Colors.yellow.shade100
                      : widget.item is Player
                          ? widget.item.isSelected
                              ? Colors.blueGrey
                              : Colors.blueGrey.shade100
                          : Colors.black,
                  border: Border(),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "${widget.item is Role ? widget.item.name.toString().tr() : widget.item is Player ? widget.item.name : ""}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.item is Role
                        ? widget.item.group.id == 1
                            ? widget.item.isSelected
                                ? Colors.white
                                : Colors.grey.shade700
                            : widget.item.group.id == 2
                                ? widget.item.isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700
                                : widget.item.isSelected
                                    ? Colors.blue
                                    : Colors.grey.shade700
                        : widget.item is Player
                            ? widget.item.isSelected
                                ? Colors.white
                                : Colors.grey.shade700
                            : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void changeStateToPhobia() {
    changePhobiaState(true);
  }

  void removePhobiaState() {
    changePhobiaState(false);
  }

  void changePhobiaState(bool isInPhobiaState) {
    setState(() {
      this.isInPhobiaState = isInPhobiaState;
    });
    if (isInPhobiaState) {
      controller?.repeat(reverse: true);
    } else {
      controller?.stop(canceled: true);
    }
  }
}
