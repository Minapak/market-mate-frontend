import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/faq/models/faq_model.dart';

// FAQ CARD UI
class FaqItem extends StatefulWidget {
  final FaqModel faq;

  FaqItem({required this.faq});

  @override
  FaqItemState createState() => FaqItemState();
}


class FaqItemState extends State<FaqItem> {
  bool isExpanded = false;

  FaqItemState();

  void toggleExpandedState(bool expanded) {
    setState(() {
      isExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Text('Q',
                            style: TextStyle(
                                color: PRIMARY_DARK_BUTTON_COLOR,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(widget.faq.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: FIXED_WIDGET_BACKGROUNG_COLOR,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: CollapseIcon(
                          isExpanded: isExpanded,
                        ),
                      )
                    ]),
              )),
          BottomCollapse(
            contents:
            widget.faq.content,
            isExpanded: isExpanded,
            duration: Duration(milliseconds: 300),
            onToggle: toggleExpandedState,
          ),
        ],
      ),
    );
  }
}

class CollapseIcon extends StatefulWidget {
  final bool isExpanded;

  CollapseIcon({required this.isExpanded});

  @override
  _CollapseIconState createState() => _CollapseIconState();
}

class _CollapseIconState extends State<CollapseIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 0.5).animate(_controller);
    if (widget.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CollapseIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: SizedBox(
          width: 10,
          height: 5,
          child: SvgPicture.asset('assets/icons/icon_collapse_gray.svg',
              fit: BoxFit.cover)),
    );
  }
}

class BottomCollapse extends StatefulWidget {
  final String contents;
  final bool isExpanded;
  final Duration duration;
  final Function(bool) onToggle; // Callback function to handle toggling

  BottomCollapse({
    required this.contents,
    required this.isExpanded,
    required this.duration,
    required this.onToggle,
  });

  @override
  _BottomCollapseState createState() => _BottomCollapseState();
}

class _BottomCollapseState extends State<BottomCollapse>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void didUpdateWidget(BottomCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GRAY_TEXTAREA_COLOR,
        border: Border(
          bottom: BorderSide(
              color: BUTTON_GRAY_BORDER_COLOR, width: 1.0), // 하단 border 설정 제거
        ),
        // borderRadius: BorderRadius.circular(0),
      ),
      child: SizeTransition(
        sizeFactor: _animation,
        child: Container(
            decoration: BoxDecoration(color: GRAY_TEXTAREA_COLOR),
            padding: EdgeInsets.all(20),
            child: Text(widget.contents)),
      ),
    );
  }
}
