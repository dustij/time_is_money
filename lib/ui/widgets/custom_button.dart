import "package:flutter/material.dart";

enum Variant { green, red, blue }

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Variant color;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = Variant.green,
    this.width = 200,
    this.height = 86,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double shadow = 6;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final outlineColor = switch (widget.color) {
      Variant.green => colors.onPrimary,
      Variant.red => colors.onError,
      Variant.blue => colors.onTertiary,
    };

    final bgColor = switch (widget.color) {
      Variant.green => colors.primary,
      Variant.red => colors.error,
      Variant.blue => colors.tertiary,
    };

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
      child: SizedBox(
        height: widget.height,
        child: AnimatedContainer(
          width: widget.width,
          padding: EdgeInsets.fromLTRB(1, 1, 1, shadow),
          decoration: BoxDecoration(
            color: outlineColor,
            borderRadius: BorderRadius.circular(8),
          ),
          duration: Durations.short1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
