import 'package:flutter/material.dart';

class IconFav extends StatefulWidget {
  const IconFav({super.key});

  @override
  State<IconFav> createState() => _IconFavState();
}

class _IconFavState extends State<IconFav> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Color?> colorAnim;
  late Animation<double> sizeAnim;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // _animationController.drive(child)
    colorAnim = ColorTween(
      begin: Colors.grey,
      end: Colors.red,
    ).animate(_animationController);

    sizeAnim = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 40, end: 50), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 50, end: 40), weight: 1),
    ]).animate(_animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return IconButton(
          onPressed: () {
            _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward();
          },
          icon: Icon(
            Icons.favorite,
            size: sizeAnim.value,
            color: colorAnim.value,
          ),
        );
      },
    );
  }
}
