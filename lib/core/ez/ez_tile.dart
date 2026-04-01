import 'package:flutter/material.dart';

/// A pre-styled list tile for use in [EzListPage].
///
/// ```dart
/// EzTile(
///   title: product.name,
///   subtitle: '${product.price} €',
///   leading: EzTile.avatar(product.imageUrl),
///   trailing: EzTile.badge('New'),
/// )
/// ```
class EzTile extends StatelessWidget {
  const EzTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.dense = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dense;

  /// Creates a circular avatar from a network image URL.
  static Widget avatar(String? imageUrl, {double radius = 20}) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return CircleAvatar(radius: radius, child: const Icon(Icons.person));
    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
    );
  }

  /// Creates a small colored badge.
  static Widget badge(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  /// Creates a trailing chevron icon.
  static Widget get chevron =>
      const Icon(Icons.chevron_right, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leading,
      trailing: trailing,
      dense: dense,
      onTap: onTap,
    );
  }
}
