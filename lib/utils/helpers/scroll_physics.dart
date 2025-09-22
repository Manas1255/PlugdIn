import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Custom scroll physics that clamps at the top but allows bouncing at the bottom
class TopClampingScrollPhysics extends ScrollPhysics {
  const TopClampingScrollPhysics({super.parent});

  @override
  TopClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TopClampingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            '$runtimeType.applyBoundaryConditions() was called redundantly.',
          ),
          ErrorDescription(
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.',
          ),
          DiagnosticsProperty<ScrollPhysics>(
            'The physics object',
            this,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
          DiagnosticsProperty<ScrollMetrics>(
            'The position object',
            position,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
        ]);
      }
      return true;
    }());

    // Clamp at the top (prevent overscroll in negative direction)
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }

    // Allow bouncing at the bottom (don't clamp positive overscroll)
    if (value > position.pixels &&
        position.pixels >= position.maxScrollExtent) {
      return 0.0; // Don't clamp, allow the bounce
    }

    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final tolerance = toleranceFor(position);

    // At the top boundary, use clamping behavior
    if (position.outOfRange) {
      double? end;
      if (position.pixels > position.maxScrollExtent) {
        // At bottom, allow bouncing back
        end = position.maxScrollExtent;
      }
      if (position.pixels < position.minScrollExtent) {
        // At top, clamp immediately
        end = position.minScrollExtent;
      }
      if (end != null) {
        return ScrollSpringSimulation(
          spring,
          position.pixels,
          end,
          velocity,
          tolerance: tolerance,
        );
      }
    }

    // For normal scrolling, use the parent physics
    return super.createBallisticSimulation(position, velocity);
  }
}
