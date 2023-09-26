import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (isLoading) ...[
          Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.grey,),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ],
    );
  }
}