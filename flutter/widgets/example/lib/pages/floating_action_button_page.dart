import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/floatingActionButton/mechanix_fab_item_theme.dart';
import 'package:widgets/widgets/floatingActionButton/mechanix_fab_items.dart';
import 'package:widgets/widgets/floatingActionButton/mechanix_fab_theme.dart';
import 'package:widgets/widgets/menu/mechanix_menu_item_theme.dart';
import 'package:widgets/widgets/menu/mechanix_menu_theme.dart';

class FabExamplePage extends StatefulWidget {
  const FabExamplePage({super.key});

  @override
  State<FabExamplePage> createState() => _FabExamplePageState();
}

class _FabExamplePageState extends State<FabExamplePage> {
  final GlobalKey _overlayButtonKey = GlobalKey();
  OverlayEntry? _fabOverlay;
  bool showBottomFAB = false;
  final LayerLink _menuLink = LayerLink();
  bool isChecked = true;
  OverlayEntry? _menuEntry;
  bool _isMenuOpen = false;

  void _showOverlayFab() {
    setState(() {
      showBottomFAB = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _overlayButtonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      _fabOverlay?.remove();
      _fabOverlay = OverlayEntry(
        builder: (_) => Positioned(
          left: position.dx,
          top: position.dy + size.height + 8,
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: Theme.of(context).copyWith(
                extensions: [
                  MechanixFabThemeData(
                    backgroundColor: WidgetStateProperty.all(Colors.grey[800]),
                    size: 40,
                    borderRadius: 8,
                    shadowColor: WidgetStateProperty.all(Colors.black54),
                  ),
                  MechanixFabItemThemeData(iconSize: 20),
                ],
              ),
              child: MechanixFloatingActionMenu(
                items: [
                  MechanixFabItem(
                    iconWidget: Icon(Icons.copy),
                    label: "Copy",
                    onTap: () {
                      debugPrint("Overlay FAB: Copy tapped");
                      _hideOverlayFab();
                    },
                  ),
                  MechanixFabItem(
                    iconWidget: Icon(Icons.cut),
                    label: "Cut",
                    onTap: () {
                      debugPrint("Overlay FAB: Cut tapped");
                      _hideOverlayFab();
                    },
                  ),
                  MechanixFabItem(
                    iconWidget: Icon(Icons.paste),
                    label: "Paste",
                    onTap: () {
                      debugPrint("Overlay FAB: Paste tapped");
                      _hideOverlayFab();
                    },
                  ),
                  MechanixFabItem(
                    iconWidget: Icon(Icons.select_all_rounded),
                    label: "Select All",
                    onTap: () {
                      debugPrint("Overlay FAB: Select All tapped");
                      _hideOverlayFab();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      Overlay.of(context, rootOverlay: true).insert(_fabOverlay!);
    });
  }

  void _hideOverlayFab() {
    _fabOverlay?.remove();
    _fabOverlay = null;
  }

  void _triggerBottomFabAction() {
    debugPrint("Bottom FAB: triggered via button");
    setState(() {
      showBottomFAB = true;
    });
  }

  void _showAttachedMenuAbove(BuildContext context) {
    _menuEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _hideMenu();
              },
            ),
            CompositedTransformFollower(
              link: _menuLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.topLeft,
              followerAnchor: Alignment.bottomLeft,
              offset: const Offset(0, -8),
              child: Material(
                color: Colors.transparent,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    extensions: [
                      const MechanixMenuThemeData(
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0xFF424242)),
                        borderRadius: 12,
                        shadowColor: WidgetStatePropertyAll(Colors.black54),
                      ),
                      const MechanixMenuItemThemeData(
                        iconColor: WidgetStatePropertyAll(Colors.white70),
                        textStyle: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  child: MechanixMenu(
                    items: [
                      MechanixMenuItem(
                        leadingWidget: Icon(Icons.edit),
                        label: "Rename",
                        onTap: () => debugPrint("Rename tapped"),
                      ),
                      MechanixMenuDivider(color: Colors.white24),
                      MechanixMenuItem(
                        leadingWidget: Icon(Icons.delete),
                        label: "Delete",
                        onTap: () => debugPrint("Delete tapped"),
                      ),
                      MechanixMenuDivider(
                          thickness: 1.2, color: Colors.white24),
                      MechanixMenuItem(
                        leadingWidget: Icon(Icons.visibility),
                        label: "Show hidden files",
                        onTap: () => debugPrint("Show hidden files tapped"),
                      ),
                      MechanixMenuDivider(
                          thickness: 1.2, color: Colors.white24),
                      MechanixMenuItem(
                        label: "Sort by Name",
                        checkValue: true,
                        onCheckChanged: (val) {
                          debugPrint("Checkbox changed: $val");
                        },
                        trailingWidget: const Icon(Icons.sort),
                        layout: MenuItemLayout.bothSides,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_menuEntry!);
    setState(() {
      _isMenuOpen = true;
    });
  }

  void _hideMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
    setState(() {
      _isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        extensions: [
          MechanixFabThemeData(
            backgroundColor: WidgetStateProperty.all(Colors.grey[800]),
            size: 56,
            shadowColor: WidgetStateProperty.all(Colors.black54),
          ),
          MechanixFabItemThemeData(iconSize: 24),
        ],
      ),
      child: GestureDetector(
        onTap: _hideOverlayFab,
        child: Scaffold(
          appBar: AppBar(title: const Text("Overlay & Bottom FAB")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  key: _overlayButtonKey,
                  onPressed: _showOverlayFab,
                  child: const Text("Show Overlay FAB"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _triggerBottomFabAction,
                  child: const Text("Trigger Bottom FAB Action"),
                ),
              ],
            ),
          ),
          floatingActionButton: showBottomFAB
              ? MechanixFloatingActionMenu(
                  height: 40,
                  items: [
                    MechanixFabItem(
                      anchorLink: _menuLink,
                      iconWidget: Icon(Icons.menu_rounded),
                      onTap: () {
                        if (_isMenuOpen) {
                          _hideMenu();
                        } else {
                          _showAttachedMenuAbove(context);
                        }
                      },
                    ),
                    MechanixFabItem(
                      iconWidget: Icon(Icons.add),
                      onTap: () => debugPrint("Bottom FAB: Add tapped"),
                    ),
                    MechanixFabItem(
                      iconWidget: Icon(Icons.copy),
                      onTap: () => debugPrint("Bottom FAB: Copy tapped"),
                    ),
                    MechanixFabItem(
                      iconWidget: Icon(Icons.delete),
                      label: "Delete",
                      onTap: () => debugPrint("Bottom FAB: Delete tapped"),
                    ),
                  ],
                ).padHorizontal(200)
              : null,
        ),
      ),
    );
  }
}
