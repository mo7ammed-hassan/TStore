import 'package:json_annotation/json_annotation.dart';

part 'invoice_settings.g.dart';

@JsonSerializable()
class InvoiceSettings {
  @JsonKey(name: 'custom_fields')
  final dynamic customFields;
  @JsonKey(name: 'default_payment_method')
  final dynamic defaultPaymentMethod;
  final dynamic footer;
  @JsonKey(name: 'rendering_options')
  final dynamic renderingOptions;

  const InvoiceSettings({
    this.customFields,
    this.defaultPaymentMethod,
    this.footer,
    this.renderingOptions,
  });

  factory InvoiceSettings.fromJson(Map<String, dynamic> json) {
    return _$InvoiceSettingsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceSettingsToJson(this);
}
