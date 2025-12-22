import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/section_list/mechanix_section_list_theme.dart';
import 'package:widgets/widgets/section_list/section_list_items_type.dart';

class MechanixSectionList extends StatefulWidget {
  // Basic constructor for small lists (no infinite scroll)
  const MechanixSectionList({
    super.key,
    this.title,
    required this.sectionListItems,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.physics,
    this.controller,
    this.theme,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
    this.prototypeItem,
  })  : itemCount = null,
        enableInfiniteScroll = false,
        initialItemCount = null,
        batchSize = null,
        itemBuilder = null,
        separatorBuilder = null,
        isBuilderList = false,
        isSeparatedBuilderList = false,
        listBoxConstraints = null;

  // Constructor for large lists with infinite scroll
  const MechanixSectionList.lazy({
    super.key,
    this.title,
    required this.sectionListItems,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.physics,
    this.controller,
    this.theme,
    this.initialItemCount = 50,
    this.batchSize = 50,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
    this.listBoxConstraints,
    this.prototypeItem,
  })  : itemCount = null,
        itemBuilder = null,
        separatorBuilder = null,
        isBuilderList = false,
        isSeparatedBuilderList = false,
        enableInfiniteScroll = true;

  // Builder constructor for small lists
  const MechanixSectionList.builder({
    super.key,
    this.title,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.theme,
    this.controller,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
    this.prototypeItem,
  })  : separatorBuilder = null,
        sectionListItems = const [],
        enableInfiniteScroll = false,
        initialItemCount = null,
        batchSize = null,
        isBuilderList = true,
        isSeparatedBuilderList = false,
        listBoxConstraints = null;

  // Builder constructor for large lists with infinite scroll
  const MechanixSectionList.lazyBuilder({
    super.key,
    this.title,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.theme,
    this.controller,
    this.initialItemCount = 50,
    this.batchSize = 50,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
    this.listBoxConstraints,
    this.prototypeItem,
  })  : separatorBuilder = null,
        isBuilderList = true,
        isSeparatedBuilderList = false,
        sectionListItems = const [],
        enableInfiniteScroll = true;

  // Separated constructor for small lists
  const MechanixSectionList.separated({
    super.key,
    this.title,
    required this.sectionListItems,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.itemBuilder,
    required this.separatorBuilder,
    this.physics,
    this.controller,
    this.theme,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
  })  : itemCount = null,
        prototypeItem = null,
        enableInfiniteScroll = false,
        initialItemCount = null,
        batchSize = null,
        isBuilderList = false,
        isSeparatedBuilderList = true,
        listBoxConstraints = null;

  // Separated constructor for large lists with infinite scroll
  const MechanixSectionList.lazySeparated({
    super.key,
    this.title,
    required this.sectionListItems,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.physics,
    this.controller,
    this.theme,
    this.initialItemCount = 50,
    this.batchSize = 50,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
    this.listBoxConstraints,
  })  : itemCount = null,
        prototypeItem = null,
        isBuilderList = false,
        isSeparatedBuilderList = true,
        enableInfiniteScroll = true;

  final String? title;

  final int? itemCount;

  final List<SectionListItems> sectionListItems;

  final GestureTapCallback? onTap;

  final GestureTapUpCallback? onTapUp;

  final GestureTapDownCallback? onTapDown;

  final GestureTapCallback? onDoubleTap;

  final Widget? Function(BuildContext context, int index)? itemBuilder;

  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final ScrollPhysics? physics;

  final ScrollController? controller;

  final MechanixSectionListThemeData? theme;

  final bool enableInfiniteScroll;

  final int? initialItemCount;

  final int? batchSize;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final double? cacheExtent;

  final Clip clipBehavior;

  final DragStartBehavior dragStartBehavior;

  final HitTestBehavior hitTestBehavior;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final EdgeInsetsGeometry? padding;

  final bool? primary;

  final String? restorationId;

  final bool reverse;

  final Axis scrollDirection;

  final int? Function(Key key)? findChildIndexCallback;

  final bool shrinkWrap;

  final bool isBuilderList;

  final bool isSeparatedBuilderList;

  final BoxConstraints? listBoxConstraints;

  final Widget? prototypeItem;

  @override
  State<MechanixSectionList> createState() => _MechanixSectionListState();
}

class _MechanixSectionListState extends State<MechanixSectionList> {
  late int _visibleCount;
  late final ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final totalItems = widget.itemCount ?? widget.sectionListItems.length;

    // Initialize visible count based on whether infinite scroll is enabled
    if (widget.enableInfiniteScroll) {
      _visibleCount = widget.initialItemCount!;
      if (_visibleCount > totalItems) {
        _visibleCount = totalItems;
      }
    } else {
      _visibleCount = totalItems;
    }

    // Use provided controller or create our own
    _scrollController = widget.controller ?? ScrollController();

    // Add scroll listener only if infinite scroll is enabled and we have more items to load
    if (widget.enableInfiniteScroll && _visibleCount < totalItems) {
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    final totalItems = widget.itemCount ?? widget.sectionListItems.length;

    if (_isLoading || _visibleCount >= totalItems) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    final totalItems = widget.itemCount ?? widget.sectionListItems.length;

    if (_isLoading || _visibleCount >= totalItems) return;

    setState(() => _isLoading = true);

    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      _visibleCount += widget.batchSize!;
      if (_visibleCount > totalItems) {
        _visibleCount = totalItems;
      }
      _isLoading = false;
    });
  }

  Widget _buildSectionList(BuildContext context, SectionListItems item,
      MechanixSectionListThemeData listTheme) {
    final bool isDisabled = item.disabled;
    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: isDisabled ? null : item.onTap,
          onTapUp: isDisabled ? null : item.onTapUp,
          onTapDown: isDisabled ? null : item.onTapDown,
          onDoubleTap: isDisabled ? null : item.onDoubleTap,
          child: Container(
            height: listTheme.height,
            padding: listTheme.itemPadding,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (item.leading != null) item.leading!.padRight(),
                      Text(
                        item.title,
                        style: context.textTheme.labelMedium
                            ?.merge(item.titleTextStyle),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      if (item.trailing != null) item.trailing!,
                      if (item.defaultTrailingIcon)
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: SizedBox(
                              width: 10,
                              height: 17,
                              child: Image.asset(
                                MechanixIconImages.rightCaret,
                                package: 'widgets',
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultSeparator(BuildContext context, int index) {
    final listTheme =
        MechanixSectionListTheme.of(context).merge(widget.theme, context);
    if (listTheme.divider != null) {
      return listTheme.divider!;
    } else {
      return Padding(
        padding: listTheme.dividerPadding,
        child: Divider(
          thickness: listTheme.dividerThickness,
          height: listTheme.dividerHeight,
          color: listTheme.dividerColor,
        ),
      );
    }
  }

  Widget _buildListView({
    required BuildContext context,
    required MechanixSectionListThemeData listTheme,
  }) {
    final effectiveItemCount = _visibleCount;

    final shouldScroll = effectiveItemCount > 1;

    final effectivePhysics = shouldScroll
        ? (widget.physics ?? const ClampingScrollPhysics())
        : const NeverScrollableScrollPhysics();

    if (widget.isBuilderList) {
      return ListView.builder(
        physics: effectivePhysics,
        controller: _scrollController,
        itemCount: effectiveItemCount,
        prototypeItem: widget.prototypeItem,
        itemBuilder: (context, index) {
          return widget.itemBuilder?.call(context, index) ??
              _buildSectionList(
                  context, widget.sectionListItems[index], listTheme);
        },
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        shrinkWrap: widget.shrinkWrap,
      );
    } else if (widget.isSeparatedBuilderList) {
      return ListView.separated(
        physics: effectivePhysics,
        controller: _scrollController,
        itemCount: effectiveItemCount,
        itemBuilder: (context, index) {
          return widget.itemBuilder?.call(context, index) ??
              _buildSectionList(
                  context, widget.sectionListItems[index], listTheme);
        },
        separatorBuilder: widget.separatorBuilder ?? _buildDefaultSeparator,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        shrinkWrap: widget.shrinkWrap,
      );
    } else {
      return ListView(
        physics: effectivePhysics,
        controller: _scrollController,
        prototypeItem: widget.prototypeItem,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        shrinkWrap: widget.shrinkWrap,
        children: widget.sectionListItems
            .map((item) => _buildSectionList(context, item, listTheme))
            .toList(),
      );
    }
  }

  @override
  void dispose() {
    // Only dispose the controller if we created it
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableInfiniteScroll) {
      return _buildLazyListView(context);
    } else {
      return _buildRegularListView(context);
    }
  }

  Widget _buildLazyListView(BuildContext context) {
    final listTheme =
        MechanixSectionListTheme.of(context).merge(widget.theme, context);

    return Container(
      padding: listTheme.widgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: listTheme.titlePadding,
              child: Text(
                widget.title!,
                style: listTheme.titleTextStyle,
              ),
            ),
          ConstrainedBox(
            constraints: widget.listBoxConstraints ??
                BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: listTheme.widgetRadius,
                color: listTheme.backgroundColor?.resolve({}),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: _buildListView(
                      context: context,
                      listTheme: listTheme,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularListView(BuildContext context) {
    final listTheme =
        MechanixSectionListTheme.of(context).merge(widget.theme, context);

    return Container(
      padding: listTheme.widgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: listTheme.titlePadding,
              child: Text(
                widget.title!,
                style: listTheme.titleTextStyle,
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: listTheme.widgetRadius,
              color: listTheme.backgroundColor?.resolve({}),
            ),
            child: _buildListView(
              context: context,
              listTheme: listTheme,
            ),
          ),
        ],
      ),
    );
  }
}
