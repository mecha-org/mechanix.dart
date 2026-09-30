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

  /// Large single-row app bar with prominent display title and action icons (height 120.0 dp).
  ///
  /// Displays the title and actions in a single horizontally-spaced row
  /// with 120 dp height, vertical padding of 8 dp, and horizontal padding of 20 dp.
  largeIcon,

  /// App bar containing an embedded search bar container.
  search,
}

