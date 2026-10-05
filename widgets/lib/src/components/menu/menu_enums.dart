/// Size variants for Mechanix menus and menu items.
enum MechanixMenuSize {
  /// Standard menu size with full padding and standard typography.
  regular,

  /// Compact menu size with reduced vertical height and smaller typography.
  ///
  /// On touch platforms (e.g. Android/iOS), the interactive tap target
  /// is maintained at >= 48dp to satisfy accessibility standards.
  small,
}

/// Alignment strategies for positioning a menu relative to its anchor widget.
enum MechanixMenuAlignment {
  /// Aligns the start edge of the menu with the start edge of the anchor.
  start,

  /// Centers the menu horizontally relative to the anchor.
  center,

  /// Aligns the end edge of the menu with the end edge of the anchor.
  end,
}
