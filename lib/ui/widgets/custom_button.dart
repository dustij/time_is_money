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
  double highlight = 4;
  double space = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final outlineColor = switch (widget.color) {
      Variant.green => colors.onSecondary,
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
        highlight = 2;
        space = 4;
      }),
      onTapUp: (_) {
        setState(() {
          shadow = 6;
          highlight = 4;
          space = 0;
        });
        widget.onPressed();
      },
      onTapCancel: () => setState(() {
        shadow = 6;
        highlight = 4;
        space = 0;
      }),
      child: SizedBox(
        height: widget.height,
        child: AnimatedContainer(
          // shadow layer
          width: widget.width,
          duration: Durations.short1,
          padding: EdgeInsets.fromLTRB(0, space, 0, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(1, 1, 1, shadow),
            decoration: BoxDecoration(
              color: outlineColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              // highlight layer
              padding: EdgeInsets.fromLTRB(2, highlight, 1, 0),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(105),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                // original inner content
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
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
        ),
      ),
    );
  }
}
