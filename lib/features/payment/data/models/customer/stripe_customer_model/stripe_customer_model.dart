import 'package:json_annotation/json_annotation.dart';
import 'package:t_store/features/payment/data/models/customer/customer_model.dart';

import 'package:t_store/features/payment/data/models/customer/stripe_customer_model/invoice_settings.dart';
import 'package:t_store/features/payment/data/models/customer/stripe_customer_model/metadata.dart';

part 'stripe_customer_model.g.dart';

@JsonSerializable()
class StripeCustomerModel {
  final String? id;
  final String? object;
  final dynamic address;
  final int? balance;
  final int? created;
  final dynamic currency;
  @JsonKey(name: 'default_source')
  final dynamic defaultSource;
  final bool? delinquent;
  final dynamic description;
  final dynamic discount;
  final String? email;
  @JsonKey(name: 'invoice_prefix')
  final String? invoicePrefix;
  @JsonKey(name: 'invoice_settings')
  final InvoiceSettings? invoiceSettings;
  final bool? livemode;
  final Metadata? metadata;
  final String? name;
  @JsonKey(name: 'next_invoice_sequence')
  final int? nextInvoiceSequence;
  final dynamic phone;
  @JsonKey(name: 'preferred_locales')
  final List<dynamic>? preferredLocales;
  final dynamic shipping;
  @JsonKey(name: 'tax_exempt')
  final String? taxExempt;
  @JsonKey(name: 'test_clock')
  final dynamic testClock;

  const StripeCustomerModel({
    this.id,
    this.object,
    this.address,
    this.balance,
    this.created,
    this.currency,
    this.defaultSource,
    this.delinquent,
    this.description,
    this.discount,
    this.email,
    this.invoicePrefix,
    this.invoiceSettings,
    this.livemode,
    this.metadata,
    this.name,
    this.nextInvoiceSequence,
    this.phone,
    this.preferredLocales,
    this.shipping,
    this.taxExempt,
    this.testClock,
  });

  factory StripeCustomerModel.fromJson(Map<String, dynamic> json) {
    return _$StripeCustomerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StripeCustomerModelToJson(this);


  CustomerModel toCustomerModel() {
    return CustomerModel(
      id: id,
      email: email,
      name: name,
      defaultSource: defaultSource,
      defaultPaymentMethod: invoiceSettings?.defaultPaymentMethod,
      address: address != null
          ? Address(
              country: address['country'] ?? '',
              city: address['city'] ?? '',
              line1: address['line1'] ?? '',
            )
          : null,
    );
  }

  factory StripeCustomerModel.fromCustomerModel(CustomerModel model) {
    return StripeCustomerModel(
      id: model.id,
      email: model.email,
      name: model.name,
      defaultSource: model.defaultSource,
      address: model.address != null
          ? {
              'country': model.address!.country,
              'city': model.address!.city,
              'line1': model.address!.line1,
            }
          : null,
      invoiceSettings: model.defaultPaymentMethod != null
          ? InvoiceSettings(
              defaultPaymentMethod: model.defaultPaymentMethod,
            )
          : null,
    );
  }
}
