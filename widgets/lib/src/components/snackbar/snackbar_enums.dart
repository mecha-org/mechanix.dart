/// Defines the layout strategy for a [MechanixSnackbar].
enum SnackbarLayout {
  /// Automatically decides between [inline] and [stacked] layout
  /// based on message length, action label length, and available width.
  auto,

  /// Forces the message, action, and dismiss button onto a single horizontal row.
  inline,

  /// Forces the action and dismiss button onto a second row below the message,
  /// right-aligned according to Material 3 multiline guidelines.
  stacked,
}

/// Defines the vertical positioning strategy for a [MechanixSnackbar].
enum MechanixSnackbarPosition {
  /// Floats at the top of the screen below status and app bars.
  top,

  /// Floats at the bottom of the screen above navigation bars (default).
  bottom,
}

