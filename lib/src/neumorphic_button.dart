import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    this.child,
    required this.padding,
    required this.backgroundColor,
    required this.onTap,
    this.brightShadowColor,
    this.darkShadowColor,
    this.height,
    this.width,
    this.borderRadius = 0,
    this.shouldClip = true,
    this.lightSource = Alignment.topLeft,
    this.shadowBlurRadius = 2.0,
    this.shadowOffsetMultiplier = 2.0,
  });

  /// Child of neumorphic
  final Widget? child;

  ///
  final VoidCallback onTap;

  /// Color of neumorphic preferably the color of background
  final Color backgroundColor;

  /// Color of brighter shadow
  final Color? brightShadowColor;

  /// Color of drakrer shadow
  final Color? darkShadowColor;

  /// constrain height of neumorphic
  final double? height;

  /// constrain width of neumorphic
  final double? width;

  final EdgeInsetsGeometry padding;

  /// specifies radius of neumorphic area
  final double borderRadius;

  /// specifies if content should be clipped along the edge
  final bool shouldClip;

  /// Placement of light source. Be aware that center placement is not supported.
  final Alignment lightSource;

  final double shadowOffsetMultiplier;
  final double shadowBlurRadius;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButton();
}

class _NeumorphicButton extends State<NeumorphicButton> {
  // ignore: non_constant_identifier_names
  bool _is_beeing_pressed = false;

  Color brightenColor(Color source, double value) {
    // Extract the individual color components (r, g, b) and alpha from the source color
    int r = source.red;
    int g = source.green;
    int b = source.blue;
    int alpha = source.alpha;

    // Calculate the brightened color components by multiplying each component with the value
    r = (r + ((255 - r) * value)).round();
    g = (g + ((255 - g) * value)).round();
    b = (b + ((255 - b) * value)).round();

    // Clip the color components to the range [0, 255]
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    // Return the brightened color as a new Color object
    return Color.fromARGB(alpha, r, g, b);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _is_beeing_pressed = true),
        onTapUp: (_) => setState(() => _is_beeing_pressed = false),
        onTapCancel: () => setState(() => _is_beeing_pressed = false),
        onTap: () => widget.onTap(),
        child: Container(
          // clipping content
          clipBehavior: widget.shouldClip ? Clip.hardEdge : Clip.none,
          // apply size
          constraints: BoxConstraints.expand(
            width: widget.width,
            height: widget.height,
          ),
          // apply radius
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
            boxShadow: shadowGeneration(),
          ),

          child: Center(child: widget.child!),
        ),
      ),
    );
  }

  List<BoxShadow> shadowGeneration() {
    // make sure that brightShadowColor and darkShadowColor arent null
    final brightShadowColor = widget.brightShadowColor == null ? brightenColor(widget.backgroundColor, 0.1) : widget.brightShadowColor!;
    final darkShadowColor = widget.darkShadowColor == null ? brightenColor(widget.backgroundColor, -0.1) : widget.darkShadowColor!;

    // calculate offset based on light alignment
    final Map<Alignment, Offset> offsetMap = {
      Alignment.topLeft: const Offset(-1, -1),
      Alignment.topRight: const Offset(1, -1),
      Alignment.bottomRight: const Offset(1, 1),
      Alignment.bottomLeft: const Offset(-1, 1),
    };
    Offset? offset = offsetMap[widget.lightSource];
    if (offset == null) return [];

    // elongate the shadow by some factor
    offset *= widget.shadowOffsetMultiplier;

    return [
      BoxShadow(
        color: brightShadowColor,
        offset: offset,
        blurRadius: widget.shadowBlurRadius,
        inset: _is_beeing_pressed,
      ),
      BoxShadow(
        color: darkShadowColor,
        offset: -offset,
        blurRadius: widget.shadowBlurRadius,
        inset: _is_beeing_pressed,
      ),
    ];
  }
}
