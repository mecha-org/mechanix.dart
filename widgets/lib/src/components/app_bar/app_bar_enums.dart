/// Visual styling and layout variants for [MechanixAppBar] and [MechanixSliverAppBar].
enum AppBarVariant {
  /// Standard single-row app bar (height 64.0 dp).
  ///
  /// Uses [TextTheme.headlineSmall] for the title label.
  small,

  /// Two-row flexible app bar (expanded height 112.0 dp).
  ///
  /// Features a prominent title placed below the navigation and action icons,
  /// using [TextTheme.headlineMedium].
  medium,

  /// Two-row large flexible app bar (expanded height 152.0 dp).
  ///
  /// Features an extra prominent display title placed below the navigation
  /// and action icons, using [TextTheme.displayMedium].
  large,

  /// App bar containing an embedded search bar container.
  search,
}
