import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A comprehensive design-system showcase demonstrating all variants,
/// states, and behaviors of the Mechanix List Component:
/// 1. Standard (Single-line and Multi-line)
/// 2. Segmented Filled
/// 3. Expandable with Accordion Button
/// 4. Draggable / Reorderable with specified elevation shadows
/// 5. Swipable Standard (with up to 3 actions and threshold indicators)
/// 6. Swipable Segmented
class ListPreview extends StatefulWidget {
  const ListPreview({super.key});

  @override
  State<ListPreview> createState() => _ListPreviewState();
}

class _ListPreviewState extends State<ListPreview> {
  // Playground interactive state
  bool _showOverline = true;
  bool _showSupportingText = true;
  bool _showLeading = true;
  bool _showTrailing = true;
  bool _isEnabled = true;

  // Draggable items state
  final List<String> _draggableItems = [
    'First item',
    'Second item',
    'Third item (drag me)',
    'Fourth item',
    'Fifth item',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(context),
          const SizedBox(height: 32),
          _buildDesignMatrixSection(context),
          const SizedBox(height: 48),
          _buildPlaygroundSection(context),
          const SizedBox(height: 48),
          _buildExpandableSection(context),
          const SizedBox(height: 48),
          _buildDraggableSection(context),
          const SizedBox(height: 48),
          _buildSwipableSection(context),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. Page Header
  // ---------------------------------------------------------------------------
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
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.view_list_rounded,
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
                'List Components',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'A versatile list suite featuring Standard, Segmented Filled, '
                'Expandable (Accordion button), Draggable (elevation shadows), '
                'and Swipable Standard & Segmented with reveal actions and '
                'progress indicators.',
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

  // ---------------------------------------------------------------------------
  // 2. Comprehensive Matrix Grid
  // ---------------------------------------------------------------------------
  Widget _buildDesignMatrixSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          title: 'Design Matrix Showcase',
          subtitle: 'Full grid comparison of Single-line and Multi-line variants across all styles.',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Single-Line List Tiles',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildPreviewColumnCard(
                    context,
                    title: '1. Standard',
                    children: [
                      MechanixListTile(
                        leading: const Icon(Icons.star_outline),
                        label: 'Label text',
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () {},
                            icon: Icons.chat_bubble_outline,
                          ),
                        ],
                        onTap: () {},
                      ),
                      const SizedBox(height: 8),
                      MechanixListTile(
                        leading: const Icon(Icons.star_outline),
                        label: 'Label text',
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () {},
                            icon: Icons.chat_bubble_outline,
                          ),
                        ],
                        onTap: () {},
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: '2. Segmented Filled',
                    children: [
                      MechanixSegmentedList(
                        children: [
                          MechanixListTile.segmented(
                            leading: const Icon(Icons.star_outline),
                            label: 'Label text',
                            trailingText: '⌘C',
                            trailingWidgets: [
                              MechanixIconButton.standard(
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () {},
                                icon: Icons.chat_bubble_outline,
                              ),
                            ],
                            onTap: () {},
                          ),
                          MechanixListTile.segmented(
                            leading: const Icon(Icons.star_outline),
                            label: 'Label text',
                            trailingText: '⌘C',
                            trailingWidgets: [
                              MechanixIconButton.standard(
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () {},
                                icon: Icons.chat_bubble_outline,
                              ),
                            ],
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: '3. Expandable',
                    children: [
                      const MechanixExpandableListTile(
                        leading: Icon(Icons.star_outline),
                        label: 'Label text',
                        trailingText: '⌘C',
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text('Nested child item 1'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: '4. Draggable (Resting vs Dragging)',
                    children: [
                      MechanixDraggableListTile(
                        index: 0,
                        leading: Icon(Icons.star_outline),
                        label: 'Label text',
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () {},
                            icon: Icons.chat_bubble_outline,
                          ),
                        ],
                        startDragOnLongPress: false,
                      ),
                      const SizedBox(height: 4),
                      MechanixDraggableListTile(
                        index: 1,
                        leading: Icon(Icons.star_outline),
                        label: 'Label text',
                        trailingText: '⌘C',
                        dragHandleIcon: Icons.drag_handle_rounded,
                        isDragging: true,
                        startDragOnLongPress: false,
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: '5. Swipable Standard',
                    children: [
                      MechanixSwipableList(
                        children: List.generate(5, (index) {
                          final isOpen = index == 2;

                          return MechanixSwipableListTile(
                            key: ValueKey('std_swipe_$index'),
                            leading: const Icon(Icons.star_outline),
                            label: 'Label text',
                            trailingText: '⌘C',
                            trailingWidgets: [
                              MechanixIconButton.standard(
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () {},
                                icon: Icons.more_vert,
                              ),
                            ],
                            initiallyOpen: isOpen,
                            actions: [
                              MechanixIconButton.standard(
                                icon: Icons.settings_outlined,
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () =>
                                    _showActionSnackBar('Settings tapped'),
                              ),
                              MechanixIconButton.standard(
                                icon: Icons.sensors,
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () =>
                                    _showActionSnackBar('Broadcast tapped'),
                              ),
                              MechanixIconButton.standard(
                                icon: Icons.chat_bubble_outline_rounded,
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () =>
                                    _showActionSnackBar('Chat tapped'),
                              ),
                            ],
                          );
                        }),
                        //   ),
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: '6. Swipable Segmented',
                    children: [
                      MechanixSwipableList(
                        children: [
                          MechanixSegmentedList(
                            children: List.generate(5, (index) {
                              final isOpen = index == 2;

                              return MechanixSwipableListTile.segmented(
                                key: ValueKey('seg_swipe_$index'),
                                leading: const Icon(Icons.star_outline),
                                label: 'Label text',
                                trailingText: '⌘C',
                                trailingWidgets: [
                                  MechanixIconButton.standard(
                                    size: IconButtonSize.small,
                                    type: IconButtonType.rounded,
                                    onPressed: () {},
                                    icon: Icons.more_vert,
                                  ),
                                ],
                                initiallyOpen: isOpen,
                                actions: [
                                  MechanixIconButton.standard(
                                    icon: Icons.settings_outlined,
                                    size: IconButtonSize.small,
                                    type: IconButtonType.rounded,
                                    onPressed: () =>
                                        _showActionSnackBar('Settings tapped'),
                                  ),
                                  MechanixIconButton.standard(
                                    icon: Icons.sensors,
                                    size: IconButtonSize.small,
                                    type: IconButtonType.rounded,
                                    onPressed: () =>
                                        _showActionSnackBar('Broadcast tapped'),
                                  ),
                                  MechanixIconButton.standard(
                                    icon: Icons.chat_bubble_outline_rounded,
                                    size: IconButtonSize.small,
                                    type: IconButtonType.rounded,
                                    onPressed: () =>
                                        _showActionSnackBar('Chat tapped'),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 40),
              Text(
                'Multi-Line List Tiles (Overline & Supporting Text with Ellipsis)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildPreviewColumnCard(
                    context,
                    title: 'Standard Multi-line',
                    children: [
                      MechanixListTile(
                        leading: const Icon(Icons.star_outline),
                        overline: 'Overline',
                        showOverline: true,
                        label: 'Label text',
                        supportingText:
                            'Supporting line text, lorem ipsum dolor sit amet',
                        showSupportingText: true,
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () => _showActionSnackBar('Chat tapped'),
                            icon: Icons.chat_bubble_outline,
                          ),
                        ],
                        onTap: () {},
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: 'Segmented Multi-line',
                    children: [
                      MechanixSegmentedList(
                        children: [
                          MechanixListTile.segmented(
                            leading: const Icon(Icons.star_outline),
                            overline: 'Overline',
                            showOverline: true,
                            label: 'Label text 1',
                            supportingText: 'Supporting line text, lorem ipsum dolor sit amet',
                            showSupportingText: true,
                            trailingText: '⌘C',
                            trailingWidgets: [
                              MechanixIconButton.standard(
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () {},
                                icon: Icons.chat_bubble_outline,
                              ),
                            ],
                            onTap: () {},
                          ),
                          MechanixListTile.segmented(
                            leading: const Icon(Icons.star_outline),
                            overline: 'Overline',
                            showOverline: true,
                            label: 'Label text 2',
                            supportingText:
                                'Second supporting line text with ellipsis',
                            showSupportingText: true,
                            trailingText: '⌘C',
                            trailingWidgets: [
                              MechanixIconButton.standard(
                                size: IconButtonSize.small,
                                type: IconButtonType.rounded,
                                onPressed: () {},
                                icon: Icons.chat_bubble_outline,
                              ),
                            ],
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildPreviewColumnCard(
                    context,
                    title: 'Expandable Multi-line',
                    children: [
                      const MechanixExpandableListTile.segmented(
                        leading: Icon(Icons.star_outline),
                        overline: 'Overline',
                        showOverline: true,
                        label: 'Label text',
                        supportingText:
                            'Supporting line text, lorem ipsum dolor',
                        showSupportingText: true,
                        trailingText: '⌘C',
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Additional detailed supporting content',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewColumnCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 320,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. Interactive Playground
  // ---------------------------------------------------------------------------
  Widget _buildPlaygroundSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          title: 'Interactive Playground',
          subtitle:
              'Configure label text properties, leading/trailing elements, '
              'interactive states, and theme styling.',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 24,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Show Overline'),
                    selected: _showOverline,
                    onSelected: (v) => setState(() => _showOverline = v),
                  ),
                  FilterChip(
                    label: const Text('Show Supporting Text'),
                    selected: _showSupportingText,
                    onSelected: (v) => setState(() => _showSupportingText = v),
                  ),
                  FilterChip(
                    label: const Text('Show Leading'),
                    selected: _showLeading,
                    onSelected: (v) => setState(() => _showLeading = v),
                  ),
                  FilterChip(
                    label: const Text('Show Trailing'),
                    selected: _showTrailing,
                    onSelected: (v) => setState(() => _showTrailing = v),
                  ),
                  FilterChip(
                    label: const Text('Enabled'),
                    selected: _isEnabled,
                    onSelected: (v) => setState(() => _isEnabled = v),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Standard Variant',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        MechanixListTile(
                          label: 'Label text',
                          overline: 'Overline',
                          showOverline: _showOverline,
                          supportingText: 'Supporting line text, lorem ipsum dolor sit amet',
                          showSupportingText: _showSupportingText,
                          leading: const Icon(Icons.star_outline),
                          showLeading: _showLeading,
                          trailingText: '⌘C',
                          trailingWidgets: [
                            MechanixIconButton.standard(
                              size: IconButtonSize.small,
                              type: IconButtonType.rounded,
                              onPressed: () {},
                              icon: Icons.more_vert,
                            ),
                          ],
                          showTrailing: _showTrailing,
                          enabled: _isEnabled,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Standard List Tile tapped!'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Segmented Filled Variant',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        MechanixListTile.segmented(
                          label: 'Label text',
                          overline: 'Overline',
                          showOverline: _showOverline,
                          supportingText: 'Supporting line text, lorem ipsum dolor sit amet',
                          showSupportingText: _showSupportingText,
                          leading: const Icon(Icons.star_outline),
                          showLeading: _showLeading,
                          trailingText: '⌘C',
                          trailingWidgets: [
                            MechanixIconButton.standard(
                              size: IconButtonSize.small,
                              type: IconButtonType.rounded,
                              onPressed: () {},
                              icon: Icons.more_vert,
                            ),
                          ],
                          showTrailing: _showTrailing,
                          enabled: _isEnabled,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Segmented List Tile tapped!'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. Expandable Lists Section
  // ---------------------------------------------------------------------------
  Widget _buildExpandableSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          title: 'Expandable Lists with Accordion Button',
          subtitle:
              'Collapsible accordion headers featuring circular animated '
              'chevrons and smooth expansion.',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              MechanixExpandableListTile(
                leading: Icon(Icons.folder_outlined),
                label: 'Documents & Files (Standard Expandable)',
                supportingText: 'Tap header or accordion button to view files',
                trailingText: '3 items',
                children: [
                  MechanixListTile(
                    leading: Icon(Icons.description_outlined),
                    label: 'Quarterly_Report_2026.pdf',
                    supportingText: '2.4 MB • Updated yesterday',
                  ),
                  MechanixListTile(
                    leading: Icon(Icons.image_outlined),
                    label: 'Design_System_Mockup.png',
                    supportingText: '5.1 MB • Updated 3 hours ago',
                  ),
                ],
              ),
              const Divider(height: 24),
              MechanixExpandableListTile.segmented(
                leading: Icon(Icons.security_rounded),
                label: 'Privacy & Security (Segmented Expandable)',
                supportingText:
                    'Manage credentials, permissions and biometric locks',
                trailingText: 'Active',
                children: [
                  MechanixSegmentedList(
                    children: [
                      MechanixListTile.segmented(
                        leading: Icon(Icons.fingerprint_rounded),
                        label: 'Biometric Authentication',
                        supportingText: 'Enabled with hardware enclave',
                      ),
                      MechanixListTile.segmented(
                        leading: Icon(Icons.vpn_key_rounded),
                        label: 'Two-Factor Authentication',
                        supportingText: 'Configured via Authenticator App',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. Draggable & Reorderable Section
  // ---------------------------------------------------------------------------
  Widget _buildDraggableSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          title: 'Draggable & Reorderable Lists',
          subtitle:
              'Drag-to-reorder list tiles rendered with the exact double '
              'box-shadow and onPrimaryFixedVariant background.',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interactive Reorderable List (Long-press on any item to drag; '
                'trailing icon switches to "="):',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              MechanixReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }

                    final item = _draggableItems.removeAt(oldIndex);
                    _draggableItems.insert(newIndex, item);
                  });
                },
                children: [
                  for (int i = 0; i < _draggableItems.length; i++)
                    Padding(
                      key: ValueKey(_draggableItems[i]),
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: MechanixDraggableListTile(
                        index: i,
                        variant: ListTileVariant.segmented,
                        leading: const Icon(Icons.star_outline),
                        label: _draggableItems[i],
                        supportingText:
                            'Position ${i + 1} of ${_draggableItems.length}',
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () {},
                            icon: Icons.more_vert,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 6. Swipable Lists (Standard & Segmented)
  // ---------------------------------------------------------------------------
  Widget _buildSwipableSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          title: 'Swipable Lists with Action Reveal',
          subtitle:
              'Swipe left on any item below to reveal action buttons '
              '(up to 3) with vertical pill indicators.',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Standard Swipable List Tiles:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              MechanixSwipableList(
                children: [
                  // 3 actions
                  MechanixSwipableListTile(
                    leading: const Icon(Icons.inbox_rounded),
                    label: 'Swipe to reveal 3 actions',
                    supportingText: 'Gear, sensor, and chat bubble buttons',
                    trailingText: '⌘C',
                    trailingWidgets: [
                      MechanixIconButton.standard(
                        size: IconButtonSize.small,
                        type: IconButtonType.rounded,
                        onPressed: () {},
                        icon: Icons.more_vert,
                      ),
                    ],
                    actions: [
                      MechanixIconButton.standard(
                        icon: Icons.settings_outlined,
                        size: IconButtonSize.medium,
                        type: IconButtonType.rounded,
                        onPressed: () => _showActionSnackBar('Settings tapped'),
                      ),
                      MechanixIconButton.standard(
                        icon: Icons.sensors,
                        size: IconButtonSize.medium,
                        type: IconButtonType.rounded,
                        onPressed: () =>
                            _showActionSnackBar('Broadcast tapped'),
                      ),
                      MechanixIconButton.standard(
                        icon: Icons.chat_bubble_outline,
                        size: IconButtonSize.medium,
                        type: IconButtonType.rounded,
                        onPressed: () => _showActionSnackBar('Chat tapped'),
                      ),
                    ],
                  ),

                  const Divider(height: 20),

                  // 2 actions
                  MechanixSwipableListTile(
                    leading: const Icon(Icons.share_outlined),
                    label: 'Swipe to reveal 2 actions',
                    supportingText: 'Share and pencil actions',
                    trailingText: '⌘C',
                    trailingWidgets: [
                      MechanixIconButton.standard(
                        size: IconButtonSize.small,
                        type: IconButtonType.rounded,
                        onPressed: () {},
                        icon: Icons.more_vert,
                      ),
                    ],
                    actions: [
                      MechanixIconButton.standard(
                        icon: Icons.share_outlined,
                        size: IconButtonSize.medium,
                        type: IconButtonType.rounded,
                        onPressed: () => _showActionSnackBar('Share tapped'),
                      ),
                      MechanixIconButton.standard(
                        icon: Icons.edit_outlined,
                        size: IconButtonSize.medium,
                        type: IconButtonType.rounded,
                        onPressed: () => _showActionSnackBar('Edit tapped'),
                      ),
                    ],
                  ),

                  const Divider(height: 20),

                  // 1 action
                  MechanixSwipableListTile(
                    leading: const Icon(Icons.sync_rounded),
                    label: 'Swipe to reveal 1 action',
                    supportingText: 'Single refresh / sync button',
                    trailingText: '⌘C',
                    trailingWidgets: [
                      MechanixIconButton.standard(
                        size: IconButtonSize.small,
                        type: IconButtonType.rounded,
                        onPressed: () {},
                        icon: Icons.more_vert,
                      ),
                    ],
                    actions: [
                      MechanixIconButton.standard(
                        icon: Icons.sync,
                        size: IconButtonSize.medium,
                        type: IconButtonType.rounded,
                        onPressed: () => _showActionSnackBar('Sync tapped'),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Text(
                'Segmented Swipable List Tiles:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              MechanixSwipableList(
                children: [
                  MechanixSegmentedList(
                    children: [
                      // 3 actions
                      MechanixSwipableListTile.segmented(
                        leading: const Icon(Icons.email_outlined),
                        overline: 'Mail',
                        label: 'Important Project Update',
                        supportingText: 'Swipe left to reveal archive, flag, and reply actions',
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () {},
                            icon: Icons.more_vert,
                          ),
                        ],
                        actions: [
                          MechanixIconButton.standard(
                            icon: Icons.archive_outlined,
                            size: IconButtonSize.medium,
                            type: IconButtonType.rounded,
                            onPressed: () =>
                                _showActionSnackBar('Archive tapped'),
                          ),
                          MechanixIconButton.standard(
                            icon: Icons.flag_outlined,
                            size: IconButtonSize.medium,
                            type: IconButtonType.rounded,
                            onPressed: () => _showActionSnackBar('Flag tapped'),
                          ),
                          MechanixIconButton.standard(
                            icon: Icons.reply_rounded,
                            size: IconButtonSize.medium,
                            type: IconButtonType.rounded,
                            onPressed: () =>
                                _showActionSnackBar('Reply tapped'),
                          ),
                        ],
                      ),

                      // 2 actions
                      MechanixSwipableListTile.segmented(
                        leading: const Icon(Icons.star_outline),
                        overline: 'Notifications',
                        label: 'Weekly Summary Available',
                        supportingText: 'Swipe left to refresh or dismiss',
                        trailingText: '⌘C',
                        trailingWidgets: [
                          MechanixIconButton.standard(
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () {},
                            icon: Icons.more_vert,
                          ),
                        ],
                        actions: [
                          MechanixIconButton.standard(
                            icon: Icons.delete_outline,
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () =>
                                _showActionSnackBar('Delete tapped'),
                          ),
                          MechanixIconButton.standard(
                            icon: Icons.refresh_rounded,
                            size: IconButtonSize.small,
                            type: IconButtonType.rounded,
                            onPressed: () =>
                                _showActionSnackBar('Refresh tapped'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------
  void _showActionSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
