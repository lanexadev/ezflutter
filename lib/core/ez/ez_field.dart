import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A declarative field definition used in `EzDetailPage` and `EzFormPage`.
///
/// Defines both how to display and how to input data for a field.
///
/// ```dart
/// EzField.text('name', label: 'Product Name', required: true)
/// EzField.currency('price', label: 'Price', symbol: '€')
/// EzField.select('status', label: 'Status', options: ['active', 'draft'])
/// ```
class EzField {
  const EzField._({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.readOnly = false,
    this.hint,
    this.icon,
    this.options,
    this.symbol,
    this.obscure = false,
    this.maxLines = 1,
    this.validator,
  });

  /// A text field.
  factory EzField.text(
    String key, {
    required String label,
    bool required = false,
    bool readOnly = false,
    String? hint,
    IconData? icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.text,
        required: required,
        readOnly: readOnly,
        hint: hint,
        icon: icon,
        maxLines: maxLines,
        validator: validator,
      );

  /// An email field with email keyboard and validation.
  factory EzField.email(
    String key, {
    String label = 'Email',
    bool required = true,
    IconData icon = Icons.email,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.email,
        required: required,
        icon: icon,
      );

  /// A password field (obscured).
  factory EzField.password(
    String key, {
    String label = 'Password',
    bool required = true,
    IconData icon = Icons.lock,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.password,
        required: required,
        icon: icon,
        obscure: true,
      );

  /// A number field.
  factory EzField.number(
    String key, {
    required String label,
    bool required = false,
    IconData? icon,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.number,
        required: required,
        icon: icon,
      );

  /// A currency field with symbol.
  factory EzField.currency(
    String key, {
    required String label,
    String symbol = r'$',
    bool required = false,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.currency,
        required: required,
        symbol: symbol,
      );

  /// A dropdown/select field.
  factory EzField.select(
    String key, {
    required String label,
    required List<String> options,
    bool required = false,
    IconData? icon,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.select,
        required: required,
        icon: icon,
        options: options,
      );

  /// A toggle/boolean field.
  factory EzField.toggle(
    String key, {
    required String label,
    IconData? icon,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.toggle,
        icon: icon,
      );

  /// A date field.
  factory EzField.date(
    String key, {
    required String label,
    bool required = false,
    bool readOnly = false,
    IconData icon = Icons.calendar_today,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.date,
        required: required,
        readOnly: readOnly,
        icon: icon,
      );

  /// A multi-line text area.
  factory EzField.textArea(
    String key, {
    required String label,
    bool required = false,
    int maxLines = 5,
    String? hint,
  }) =>
      EzField._(
        key: key,
        label: label,
        type: EzFieldType.text,
        required: required,
        hint: hint,
        maxLines: maxLines,
      );

  /// The key in the data map (must match the model field name).
  final String key;

  /// Display label.
  final String label;

  /// Field type.
  final EzFieldType type;

  /// Whether the field is required in forms.
  final bool required;

  /// Whether the field is read-only in forms.
  final bool readOnly;

  /// Hint text for input fields.
  final String? hint;

  /// Leading icon.
  final IconData? icon;

  /// Options for select/dropdown fields.
  final List<String>? options;

  /// Currency symbol for currency fields.
  final String? symbol;

  /// Whether to obscure text (for passwords).
  final bool obscure;

  /// Max lines for text areas.
  final int maxLines;

  /// Custom validator.
  final String? Function(String?)? validator;

  // ---- Rendering ----

  /// Build a display-mode widget (for detail pages).
  Widget buildDisplay(BuildContext context, Map<String, dynamic> data) {
    final value = data[key];
    final displayValue = _formatValue(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          if (type == EzFieldType.toggle)
            Icon(
              value == true ? Icons.check_circle : Icons.cancel,
              color: value == true ? Colors.green : Colors.grey,
            )
          else
            Text(
              displayValue,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
        ],
      ),
    );
  }

  /// Build an input-mode widget (for form pages).
  Widget buildInput(BuildContext context, Map<String, dynamic> data) {
    return switch (type) {
      EzFieldType.text || EzFieldType.email || EzFieldType.password =>
        _buildTextInput(data),
      EzFieldType.number || EzFieldType.currency => _buildNumberInput(data),
      EzFieldType.select => _buildSelectInput(data),
      EzFieldType.toggle => _buildToggleInput(data),
      EzFieldType.date => _buildDateInput(context, data),
    };
  }

  Widget _buildTextInput(Map<String, dynamic> data) {
    return TextFormField(
      initialValue: data[key]?.toString(),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      obscureText: obscure,
      maxLines: obscure ? 1 : maxLines,
      readOnly: readOnly,
      keyboardType:
          type == EzFieldType.email ? TextInputType.emailAddress : null,
      validator: _getValidator(),
      onSaved: (value) => data[key] = value?.trim(),
    );
  }

  Widget _buildNumberInput(Map<String, dynamic> data) {
    return TextFormField(
      initialValue: data[key]?.toString(),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        prefixText: symbol != null ? '$symbol ' : null,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
      ],
      readOnly: readOnly,
      validator: _getValidator(),
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          data[key] = double.tryParse(value);
        }
      },
    );
  }

  Widget _buildSelectInput(Map<String, dynamic> data) {
    return DropdownButtonFormField<String>(
      initialValue: data[key]?.toString(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      items: options
              ?.map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList() ??
          [],
      validator:
          required ? (v) => v == null ? '$label is required' : null : null,
      onChanged: readOnly ? null : (value) => data[key] = value,
      onSaved: (value) => data[key] = value,
    );
  }

  Widget _buildToggleInput(Map<String, dynamic> data) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SwitchListTile(
          title: Text(label),
          secondary: icon != null ? Icon(icon) : null,
          value: data[key] as bool? ?? false,
          onChanged: readOnly
              ? null
              : (value) {
                  setState(() => data[key] = value);
                },
        );
      },
    );
  }

  Widget _buildDateInput(BuildContext context, Map<String, dynamic> data) {
    return StatefulBuilder(
      builder: (context, setState) {
        final currentValue = data[key];
        final date = currentValue is DateTime ? currentValue : null;
        final displayText =
            date != null ? '${date.day}/${date.month}/${date.year}' : '';

        return TextFormField(
          readOnly: true,
          controller: TextEditingController(text: displayText),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon ?? Icons.calendar_today),
          ),
          validator: _getValidator(),
          onTap: readOnly
              ? null
              : () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => data[key] = picked);
                  }
                },
        );
      },
    );
  }

  String? Function(String?)? _getValidator() {
    if (validator != null) return validator;
    if (required) {
      return (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      };
    }
    return null;
  }

  String _formatValue(dynamic value) {
    if (value == null) return '—';
    if (type == EzFieldType.currency) {
      return '${symbol ?? r'$'}${value is num ? value.toStringAsFixed(2) : value}';
    }
    if (type == EzFieldType.date && value is DateTime) {
      return '${value.day}/${value.month}/${value.year}';
    }
    return value.toString();
  }
}

/// Field types supported by [EzField].
enum EzFieldType {
  text,
  email,
  password,
  number,
  currency,
  select,
  toggle,
  date,
}
