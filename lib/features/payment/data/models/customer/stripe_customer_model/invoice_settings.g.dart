// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceSettings _$InvoiceSettingsFromJson(Map<String, dynamic> json) =>
    InvoiceSettings(
      customFields: json['custom_fields'],
      defaultPaymentMethod: json['default_payment_method'],
      footer: json['footer'],
      renderingOptions: json['rendering_options'],
    );

Map<String, dynamic> _$InvoiceSettingsToJson(InvoiceSettings instance) =>
    <String, dynamic>{
      'custom_fields': instance.customFields,
      'default_payment_method': instance.defaultPaymentMethod,
      'footer': instance.footer,
      'rendering_options': instance.renderingOptions,
    };
