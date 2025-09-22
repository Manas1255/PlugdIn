import 'package:flutter/material.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';

class PaginatedBuilder<T> extends StatefulWidget {
  const PaginatedBuilder({
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMoreData,
    super.key,
    this.scrollDirection = Axis.vertical,
    this.isGrid = false,
    this.gridDelegate,
    this.separatorBuilder,
    this.emptyTitle = 'No items found',
    this.emptySubtitle = 'Check back later.',
    this.emptyIcon,
    this.errorMessage,
    this.onRetry,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.loadMoreThreshold = 200,
    this.useSlivers = false,
    this.enableRefreshIndicator = true,
    this.controller,
  });

  final List<T> items;
  final Widget Function(BuildContext, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMoreData;
  final bool isGrid;
  final SliverGridDelegate? gridDelegate;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final String emptyTitle;
  final String emptySubtitle;
  final String? emptyIcon;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double loadMoreThreshold;
  final Axis scrollDirection;
  final bool useSlivers;
  final bool enableRefreshIndicator;
  final ScrollController? controller;

  @override
  State<PaginatedBuilder<T>> createState() => _PaginatedBuilderState<T>();
}

class _PaginatedBuilderState<T> extends State<PaginatedBuilder<T>> {
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.useSlivers) {
      _controller = widget.controller ?? ScrollController();
      _controller!.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    if (!widget.useSlivers && widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_controller != null &&
        _controller!.position.pixels >=
            _controller!.position.maxScrollExtent - widget.loadMoreThreshold &&
        !widget.isLoadingMore &&
        widget.hasMoreData &&
        widget.items.isNotEmpty) {
      widget.onLoadMore();
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.emptyIcon != null)
            Image.asset(widget.emptyIcon!, height: 120),
          const SizedBox(height: 16),
          Text(
            widget.emptyTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.emptySubtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.errorMessage ?? 'Something went wrong'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: widget.onRetry ?? widget.onRefresh,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const LoadingWidget();
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsetsDirectional.all(16),
      child: LoadingWidget(),
    );
  }

  List<Widget> _buildSlivers() {
    final slivers = <Widget>[];

    if (widget.padding != null) {
      slivers.add(
        SliverPadding(
          padding: widget.padding!,
          sliver: _buildContentSliver(),
        ),
      );
    } else {
      slivers.add(_buildContentSliver());
    }

    // Add loading more indicator as a sliver
    if (widget.isLoadingMore) {
      slivers.add(
        SliverToBoxAdapter(
          child: _buildLoadingIndicator(),
        ),
      );
    }

    return slivers;
  }

  Widget _buildContentSliver() {
    final itemCount = widget.items.length;

    if (widget.isGrid) {
      return SliverGrid(
        gridDelegate: widget.gridDelegate!,
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return widget.itemBuilder(context, widget.items[index], index);
          },
          childCount: itemCount,
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (widget.separatorBuilder != null && index > 0) {
              // For separated list, we need to handle separators differently in slivers
              return Column(
                children: [
                  widget.separatorBuilder!(context, index - 1),
                  widget.itemBuilder(context, widget.items[index], index),
                ],
              );
            }
            return widget.itemBuilder(context, widget.items[index], index);
          },
          childCount: itemCount,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.errorMessage != null && widget.items.isEmpty) {
      return widget.useSlivers
          ? CustomScrollView(
              slivers: [SliverToBoxAdapter(child: _buildErrorState())],
            )
          : _buildErrorState();
    }

    if (widget.isLoading && widget.items.isEmpty) {
      return widget.useSlivers
          ? CustomScrollView(
              slivers: [SliverToBoxAdapter(child: _buildLoadingState())],
            )
          : _buildLoadingState();
    }

    if (widget.items.isEmpty) {
      return widget.useSlivers
          ? CustomScrollView(
              slivers: [SliverToBoxAdapter(child: _buildEmptyState())],
            )
          : _buildEmptyState();
    }

    // Build sliver-based version for NestedScrollView compatibility
    if (widget.useSlivers) {
      return CustomScrollView(
        physics: widget.physics,
        slivers: _buildSlivers(),
      );
    }

    // Build traditional scrollable version
    final itemCount = widget.items.length + (widget.isLoadingMore ? 1 : 0);
    final scrollableWidget = widget.isGrid
        ? GridView.builder(
            scrollDirection: widget.scrollDirection,
            controller: _controller,
            padding: widget.padding,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            gridDelegate: widget.gridDelegate!,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index >= widget.items.length) {
                return _buildLoadingIndicator();
              }
              return widget.itemBuilder(context, widget.items[index], index);
            },
          )
        : ListView.separated(
            scrollDirection: widget.scrollDirection,
            controller: _controller,
            padding: widget.padding,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index >= widget.items.length) {
                return _buildLoadingIndicator();
              }
              return widget.itemBuilder(context, widget.items[index], index);
            },
            separatorBuilder:
                widget.separatorBuilder ?? (_, _) => const SizedBox(height: 8),
          );

    return widget.enableRefreshIndicator
        ? RefreshIndicator.adaptive(
            onRefresh: widget.onRefresh,
            child: scrollableWidget,
          )
        : scrollableWidget;
  }
}
