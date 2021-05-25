import 'package:flutter/material.dart';

/// Tree Node
/// A basic node that is part of the tree in a schedule builder
class ViewTreeBuilder extends StatelessWidget
{
  // portrait/landscape build separation
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.android),
      color: Colors.white,
      onPressed: () {},
    );
  }
}