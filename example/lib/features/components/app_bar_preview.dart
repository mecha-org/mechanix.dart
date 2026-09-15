import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A design-system documentation page demonstrating all
/// [MechanixAppBar] variants and common configurations.
class AppBarPreview extends StatelessWidget {
  const AppBarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. App Bar Variants
        _buildVariantsSection(context),
        const SizedBox(height: 32),

        // 3. Navigation & Actions
        _buildNavigationSection(context),
        const SizedBox(height: 32),

        // 4. Search App Bar
        _buildSearchSection(context),
        const SizedBox(height: 32),

        // 5. Custom Styling
        _buildStylingSection(context),
        const SizedBox(height: 32),

        // 6. Bottom Content
        _buildBottomSection(context),
      ],
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.web_asset_rounded,
            size: 28,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App Bars',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanix App Bar variants, navigation, actions, search, '
                'sizing, and customization',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- SECTION 2: APP BAR VARIANTS ---
  Widget _buildVariantsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final items = [
      _AppBarVariantItem(
        title: 'Small',
        description: 'Single-row app bar with a 64px toolbar height',
        variant: AppBarVariant.small,
      ),
      _AppBarVariantItem(
        title: 'Small (Centered)',
        description: 'Single-row app bar with a centered title',
        variant: AppBarVariant.small,
        centerTitle: true,
      ),
      _AppBarVariantItem(
        title: 'Medium',
        description: 'Two-row app bar with a prominent title',
        variant: AppBarVariant.medium,
      ),
      _AppBarVariantItem(
        title: 'Large',
        description: 'Two-row app bar with an extra-large display title',
        variant: AppBarVariant.large,
      ),
      _AppBarVariantItem(
        title: 'Search',
        description: 'Single-row app bar with an embedded search field',
        variant: AppBarVariant.search,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Variants',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                _buildVariantRow(context, items[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVariantRow(BuildContext context, _AppBarVariantItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    final appBar = _buildAppBarPreview(context, item.variant, item.centerTitle);

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(child: appBar),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          appBar,
        ],
      ),
    );
  }

  Widget _buildAppBarPreview(
    BuildContext context,
    AppBarVariant variant,
    bool centerTitle,
  ) {
    switch (variant) {
      case AppBarVariant.small:
        return MechanixAppBar.small(
          primary: false,
          centerTitle: centerTitle,
          title: const Text('Settings'),
          leading: MechanixIconButton.standard(
            icon: Icons.arrow_back,
            onPressed: () {},
          ),
          actions: [
            MechanixIconButton.standard(icon: Icons.search, onPressed: () {}),
            MechanixIconButton.standard(
              icon: Icons.more_vert,
              onPressed: () {},
            ),
          ],
        );

      case AppBarVariant.medium:
        return MechanixAppBar.medium(
          primary: false,
          title: const Text('Settings'),
          leading: MechanixIconButton.standard(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: [
            MechanixIconButton.standard(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            MechanixIconButton.standard(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        );

      case AppBarVariant.large:
        return MechanixAppBar.large(
          primary: false,
          title: const Text('Settings'),
          leading: MechanixIconButton.standard(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: [
            MechanixIconButton.standard(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            MechanixIconButton.standard(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        );

      case AppBarVariant.search:
        return MechanixAppBar.search(
          primary: false,
          leading: MechanixIconButton.standard(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          searchHint: 'Search settings',
          searchTrailing: MechanixIconButton.standard(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        );
    }
  }

  // --- SECTION 3: NAVIGATION & ACTIONS ---
  Widget _buildNavigationSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Navigation & Actions',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 24,
              runSpacing: 20,
              children: [
                _buildNavigationExample(
                  context,
                  'Back Navigation',
                  MechanixAppBar.small(
                    primary: false,
                    title: const Text('Details'),
                    leading: MechanixIconButton.standard(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                  ),
                ),
                _buildNavigationExample(
                  context,
                  'Menu Navigation',
                  MechanixAppBar.small(
                    primary: false,
                    title: const Text('Home'),
                    leading: MechanixIconButton.standard(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                  ),
                ),
                _buildNavigationExample(
                  context,
                  'Multiple Actions',
                  MechanixAppBar.small(
                    primary: false,
                    title: const Text('Files'),
                    actions: [
                      MechanixIconButton.standard(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      MechanixIconButton.standard(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationExample(
    BuildContext context,
    String label,
    Widget appBar,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          appBar,
          const SizedBox(height: 4),
          Text(
            'Leading and trailing controls',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // --- SECTION 4: SEARCH ---
  Widget _buildSearchSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search App Bar',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Built-in Search',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                MechanixAppBar.search(
                  primary: false,
                  searchHint: 'Search products',
                  searchTrailing: MechanixIconButton.standard(
                    icon: const Icon(Icons.close),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Custom Search Widget',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                MechanixAppBar.search(
                  primary: false,
                  searchWidget: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Search anything',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- SECTION 5: CUSTOM STYLING ---
  Widget _buildStylingSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Styling',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 320,
                      child: MechanixAppBar.small(
                        primary: false,
                        title: const Text('Primary'),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: MechanixAppBar.small(
                        primary: false,
                        title: const Text('Dark Surface'),
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        foregroundColor: colorScheme.onSurface,
                        elevation: 2,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: MechanixAppBar.small(
                        primary: false,
                        title: const Text('Custom Actions'),
                        actionsPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        actions: [
                          MechanixIconButton.standard(
                            icon: const Icon(Icons.favorite),
                            onPressed: () {},
                          ),
                          MechanixIconButton.standard(
                            icon: const Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- SECTION 6: BOTTOM ---
  Widget _buildBottomSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bottom Content',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: MechanixAppBar.small(
              primary: false,
              title: const Text('With Bottom'),
              actions: [
                MechanixIconButton.standard(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Additional bottom content',
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppBarVariantItem {
  final String title;
  final String description;
  final AppBarVariant variant;
  final bool centerTitle;

  const _AppBarVariantItem({
    required this.title,
    required this.description,
    required this.variant,
    this.centerTitle = false,
  });
}
