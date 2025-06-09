import 'package:flutter/material.dart';

/// Enum for different presentation types
enum PresentationType {
  text,
  card,
  chip,
  badge,
  progress,
}

/// Data column configuration
class TableColumn<T> {
  final String header;
  final String Function(T item) dataExtractor;
  final PresentationType presentationType;
  final double? width;
  final TextStyle? headerStyle;
  final TextStyle? dataStyle;
  final Color? backgroundColor;
  final Color? borderColor;

  const TableColumn({
    required this.header,
    required this.dataExtractor,
    required this.presentationType,
    this.width,
    this.headerStyle,
    this.dataStyle,
    this.backgroundColor,
    this.borderColor,
  });
}

/// A dynamic table widget that can present records of a business entity
/// with different presentation types for each data type
class DynamicTable<T> extends StatelessWidget {
  final List<T> records;
  final List<TableColumn<T>> columns;
  final bool showHeader;
  final bool bordered;
  final Color? headerBackgroundColor;
  final Color? rowBackgroundColor;
  final Color? alternateRowBackgroundColor;
  final double? rowHeight;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final VoidCallback? onRowTap;
  final int? Function(T item)? onRowTapCallback;

  const DynamicTable({
    super.key,
    required this.records,
    required this.columns,
    this.showHeader = true,
    this.bordered = true,
    this.headerBackgroundColor,
    this.rowBackgroundColor,
    this.alternateRowBackgroundColor,
    this.rowHeight,
    this.padding,
    this.borderRadius,
    this.border,
    this.onRowTap,
    this.onRowTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border ?? (bordered ? Border.all(color: Colors.grey.shade300) : null),
          ),
          child: Column(
            children: [
              // Header
              if (showHeader) _buildHeader(context),
              // Scrollable body
              Expanded(
                child: records.isEmpty
                    ? const Center(child: Text('No data'))
                    : ListView.builder(
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          final record = records[index];
                          return _buildRow(context, record, index);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: rowHeight ?? 50,
      color: headerBackgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
      child: Row(
        children: columns.map((column) {
          return Expanded(
            flex: column.width?.toInt() ?? 1,
            child: Container(
              padding: padding ?? const EdgeInsets.all(12),
              decoration: bordered
                  ? BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    )
                  : null,
              child: Text(
                column.header,
                style: column.headerStyle ??
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRow(BuildContext context, T record, int index) {
    final isAlternate = index % 2 == 1;
    final backgroundColor = isAlternate
        ? (alternateRowBackgroundColor ?? Colors.grey.shade50)
        : (rowBackgroundColor ?? Colors.white);

    return GestureDetector(
      onTap: () {
        if (onRowTap != null) {
          onRowTap!();
        }
        if (onRowTapCallback != null) {
          onRowTapCallback!(record);
        }
      },
      child: Container(
        height: rowHeight ?? 60,
        color: backgroundColor,
        child: Row(
          children: columns.map((column) {
            return Expanded(
              flex: column.width?.toInt() ?? 1,
              child: Container(
                padding: padding ?? const EdgeInsets.all(12),
                decoration: bordered
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                          left: BorderSide(color: Colors.grey.shade300),
                          right: BorderSide(color: Colors.grey.shade300),
                        ),
                      )
                    : null,
                child: _buildCell(context, record, column),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCell(BuildContext context, T record, TableColumn<T> column) {
    final data = column.dataExtractor(record);
    
    switch (column.presentationType) {
      case PresentationType.text:
        return _buildTextCell(data, column);
      case PresentationType.card:
        return _buildCardCell(data, column);
      case PresentationType.chip:
        return _buildChipCell(data, column);
      case PresentationType.badge:
        return _buildBadgeCell(data, column);
      case PresentationType.progress:
        return _buildProgressCell(data, column);
    }
  }

  Widget _buildTextCell(String data, TableColumn<T> column) {
    return Center(
      child: Text(
        data,
        style: column.dataStyle ?? const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCardCell(String data, TableColumn<T> column) {
    return Card(
      elevation: 2,
      color: column.backgroundColor ?? Colors.blue.shade50,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          data,
          style: column.dataStyle ?? const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildChipCell(String data, TableColumn<T> column) {
    return Center(
      child: Chip(
        label: Text(
          data,
          style: column.dataStyle ?? const TextStyle(fontSize: 12),
        ),
        backgroundColor: column.backgroundColor ?? Colors.blue.shade100,
        side: column.borderColor != null
            ? BorderSide(color: column.borderColor!)
            : null,
      ),
    );
  }

  Widget _buildBadgeCell(String data, TableColumn<T> column) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: column.backgroundColor ?? Colors.orange.shade100,
          borderRadius: BorderRadius.circular(20),
          border: column.borderColor != null
              ? Border.all(color: column.borderColor!)
              : null,
        ),
        child: Text(
          data,
          style: column.dataStyle ?? const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProgressCell(String data, TableColumn<T> column) {
    // For level data (1-10), create a progress indicator
    final level = int.tryParse(data) ?? 0;
    final progress = level / 10.0;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          data,
          style: column.dataStyle ?? const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(
            column.backgroundColor ?? Colors.blue,
          ),
        ),
      ],
    );
  }
}

/// Helper class for creating common column configurations
class TableColumnHelper {
  /// Create a text column for full names
  static TableColumn<T> fullName<T>({
    required String Function(T item) dataExtractor,
    double? width,
    TextStyle? headerStyle,
    TextStyle? dataStyle,
  }) {
    return TableColumn<T>(
      header: 'Full Name',
      dataExtractor: dataExtractor,
      presentationType: PresentationType.text,
      width: width,
      headerStyle: headerStyle,
      dataStyle: dataStyle,
    );
  }

  /// Create a date column for date of birth
  static TableColumn<T> dateOfBirth<T>({
    required String Function(T item) dataExtractor,
    double? width,
    TextStyle? headerStyle,
    TextStyle? dataStyle,
  }) {
    return TableColumn<T>(
      header: 'Date of Birth',
      dataExtractor: dataExtractor,
      presentationType: PresentationType.chip,
      width: width,
      headerStyle: headerStyle,
      dataStyle: dataStyle,
      backgroundColor: Colors.green.shade100,
    );
  }

  /// Create a level column for numbers 1-10
  static TableColumn<T> level<T>({
    required String Function(T item) dataExtractor,
    double? width,
    TextStyle? headerStyle,
    TextStyle? dataStyle,
  }) {
    return TableColumn<T>(
      header: 'Level',
      dataExtractor: dataExtractor,
      presentationType: PresentationType.progress,
      width: width,
      headerStyle: headerStyle,
      dataStyle: dataStyle,
      backgroundColor: Colors.blue,
    );
  }
} 