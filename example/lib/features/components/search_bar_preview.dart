import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A design-system documentation and preview page demonstrating all
/// [MechanixSearchBar], [MechanixSearchAnchor], and [MechanixSearchView]
/// configurations following Material 3 search specs (docked and full-screen).
class SearchBarPreview extends StatefulWidget {
  const SearchBarPreview({super.key});

  @override
  State<SearchBarPreview> createState() => _SearchBarPreviewState();
}

class _SearchBarPreviewState extends State<SearchBarPreview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Search bar
        _buildSearchCard(
          context,
          title: 'Search bar with clear button',
          controller: TextEditingController(),
          hintText: 'Hinted search text',
        ),
        const SizedBox(height: 32),

        // 3. Search Bar Variants (From Figma)
        _buildVariantsSection(context),
        const SizedBox(height: 32),
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Icon(
            Icons.search_rounded,
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
                'Search',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Search allows users to enter a keyword or phrase and get relevant information. '
                "It's an alternative to other forms of navigation.",
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

  // --- SECTION 3: SEARCH BAR VARIANTS ---
  Widget _buildVariantsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Bar Variants',
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
                _buildVariantItem(
                  context,
                  title: 'Standard Search Bar',
                  description: 'Search bar with leading search icon, hint text, and trailing mic action',
                  child: MechanixSearchBar(
                    hintText: 'Hinted search text',
                    trailing: [
                      MechanixIconButton.standard(
                        icon: Icons.mic_none_outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(height: 32),
                _buildVariantItem(
                  context,
                  title: 'Search Bar with Avatar',
                  description: 'Search bar with leading icon, hint text, trailing mic action, and user profile avatar',
                  child: MechanixSearchBar(
                    hintText: 'Hinted search text',
                    trailing: [
                      MechanixIconButton.standard(
                        icon: Icons.mic_none_outlined,
                        onPressed: () {},
                      ),
                    ],
                    avatar: CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xFFF9640D),
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const Divider(height: 32),
                _buildVariantItem(
                  context,
                  title: 'Disabled Search Bar',
                  description:
                      'Search bar in disabled state with dimmed styling',
                  child: MechanixSearchBar(
                    enabled: false,
                    hintText: 'Hinted search text',
                    trailing: [
                      MechanixIconButton.standard(
                        icon: Icons.mic_none_outlined,
                        onPressed: () {},
                      ),
                    ],
                    avatar: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildVariantItem(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Align(alignment: Alignment.centerLeft, child: child),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildSearchCard(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    String? hintText,
  }) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          MechanixSearchBar(
            controller: controller,
            hintText: hintText ?? 'Search',
            leading: const Icon(Icons.search, size: 22),
            trailing: [
              MechanixIconButton.standard(
                type: IconButtonType.rounded,
                icon: Icons.close,
                onPressed: controller.clear,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
