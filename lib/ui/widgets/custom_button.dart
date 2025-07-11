import "package:flutter/material.dart";

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isVariant;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isVariant = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double shadow = 6;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final outlineColor = widget.isVariant ? colors.onError : colors.outline;
    final bgColor = widget.isVariant ? colors.error : colors.primary;

    return GestureDetector(
      onTapDown: (_) => setState(() {
        shadow = 2;
      }),
      onTapUp: (_) {
        setState(() {
          shadow = 6;
        });
        widget.onPressed();
      },
      child: AnimatedContainer(
        padding: EdgeInsets.fromLTRB(1, 1, 1, shadow),
        decoration: BoxDecoration(
          color: outlineColor,
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(microseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}
