import 'package:flutter_stripe/flutter_stripe.dart';

class SetupIntentModel {
  String? id;
  String? object;
  String? application;
  String? clientSecret;
  int? created;
  String? customer;
  bool? livemode;
  String? paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  PaymentIntentsStatus? status;
  String? usage;

  SetupIntentModel({
    this.id,
    this.object,
    this.application,
    this.clientSecret,
    this.created,
    this.customer,
    this.livemode,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.status,
    this.usage,
  });

  factory SetupIntentModel.fromJson(Map<String, dynamic> json) {
    return SetupIntentModel(
      id: json['id'] as String?,
      object: json['object'] as String?,
      application: json['application'] as String?,
      clientSecret: json['client_secret'] as String?,
      created: json['created'] as int?,
      customer: json['customer'] as String?,
      livemode: json['livemode'] as bool?,
      paymentMethod: json['payment_method'] as String?,
      paymentMethodOptions: json['payment_method_options'] != null
          ? PaymentMethodOptions.fromJson(
              Map<String, dynamic>.from(json['payment_method_options']),
            )
          : null,
      paymentMethodTypes: (json['payment_method_types'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      status: json['status'] != null
          ? PaymentIntentsStatus.values.firstWhere(
              (s) => s.toString() == 'PaymentIntentsStatus.${json['status']}',
              orElse: () => PaymentIntentsStatus.Unknown,
            )
          : null,
      usage: json['usage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'application': application,
      'client_secret': clientSecret,
      'created': created,
      'customer': customer,
      'livemode': livemode,
      'payment_method': paymentMethod,
      'payment_method_options': paymentMethodOptions?.toJson(),
      'payment_method_types': paymentMethodTypes,
      'status': status?.name,
      'usage': usage,
    };
  }
}
