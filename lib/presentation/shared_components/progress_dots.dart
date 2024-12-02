import 'package:flutter/material.dart';

class ProgressDots extends StatefulWidget {
  final int pageNumber;
  final int pages;

  const ProgressDots({Key? key, required this.pageNumber, required this.pages}) : super(key: key);

  @override
  State<ProgressDots> createState() => _ProgressDotsState();
}

class _ProgressDotsState extends State<ProgressDots> {
  Color activeColor = const Color(0xFFbb8e1a);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 480)).then((value) => setState(() {
      activeColor = const Color(0xFFbb8e1a);

      _dots = List<Widget>.generate(widget.pages, (index) {
        if(index == widget.pages){
          if(index == widget.pageNumber){
            return AnimatedContainer(
              constraints: const BoxConstraints(
                minHeight: 12.0,
                minWidth: 12.0,
              ),
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              duration: const Duration(milliseconds: 1420),
              curve: Curves.fastOutSlowIn,
            );
          }else {
            return AnimatedContainer(
              constraints: const BoxConstraints(
                minHeight: 8,
                minWidth: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: index < widget.pageNumber ? activeColor : const Color(0xFFc0c0c0), width: 1),
              ),
              duration: const Duration(milliseconds: 1420),
              curve: Curves.fastOutSlowIn,
            );
          }
        } else if(index == widget.pageNumber) {
          return Row(
            children: [
              AnimatedContainer(
                constraints: const BoxConstraints(
                  minHeight: 12.0,
                  minWidth: 12.0,
                ),
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                duration: const Duration(milliseconds: 1420),
                curve: Curves.fastOutSlowIn,
              ),
              const SizedBox(width: 6.4,),
            ],
          );
        } else {
          return Row(
            children: [
              AnimatedContainer(
                constraints: const BoxConstraints(
                  minHeight: 8,
                  minWidth: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: index < widget.pageNumber ? activeColor : const Color(0xFFc0c0c0), width: 1),
                ),
                duration: const Duration(milliseconds: 1420),
                curve: Curves.fastOutSlowIn,
              ),
              const SizedBox(width: 6.4,),
            ],
          );
        }
      });
    }));
  }

  late List<Widget> _dots = List<Widget>.generate(widget.pages, (index) {
    if(index == widget.pages){
      if(index == widget.pageNumber){
        return AnimatedContainer(
          constraints: const BoxConstraints(
            minHeight: 12.0,
            minWidth: 12.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0x40bb8e1a),
            borderRadius: BorderRadius.circular(6.0),
          ),
          duration: const Duration(milliseconds: 1420),
          curve: Curves.fastOutSlowIn,
        );
      }else {
        return AnimatedContainer(
          constraints: const BoxConstraints(
            minHeight: 8,
            minWidth: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: index < widget.pageNumber ? activeColor : const Color(0xFFc0c0c0), width: 1),
          ),
          duration: const Duration(milliseconds: 1420),
          curve: Curves.fastOutSlowIn,
        );
      }
    } else if(index == widget.pageNumber) {
      return Row(
        children: [
          AnimatedContainer(
            constraints: const BoxConstraints(
              minHeight: 12.0,
              minWidth: 12.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0x40bb8e1a),
              borderRadius: BorderRadius.circular(6.0),
            ),
            duration: const Duration(milliseconds: 1420),
            curve: Curves.fastOutSlowIn,
          ),
          const SizedBox(width: 6.4,),
        ],
      );
    } else {
      return Row(
        children: [
          AnimatedContainer(
            constraints: const BoxConstraints(
              minHeight: 8,
              minWidth: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: index < widget.pageNumber ? activeColor : const Color(0xFFc0c0c0), width: 1),
            ),
            duration: const Duration(milliseconds: 1420),
            curve: Curves.fastOutSlowIn,
          ),
          const SizedBox(width: 6.4,),
        ],
      );
    }
  });


  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _dots,
    );
  }
}


