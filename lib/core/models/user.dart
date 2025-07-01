class LoginData {
  final bool? encrypted;
  final Data? data;

  LoginData({this.encrypted, this.data});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      encrypted: json['encrypted'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'encrypted': encrypted,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final String? token;
  final User? user;

  Data({this.token, this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }
}

class User {
  final Location? location;
  final String? id;
  final String? name;
  final String? email;
  final String? gender;
  final String? phone;
  final String? addressLane1;
  final String? addressLane2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool? isOnline;
  final List<String>? blockedUsers;
  final String? role;
  final bool? isVerified;
  final bool? isDeleted;
  final String? deletedMessage;
  final bool? isDisabled;
  final String? createdAt;
  final String? updatedAt;
  final int? version;
  final String? lastSeen;
  final String? profile;
  final String? deletedTime;
  final String? plan;
  final String? previousPlan;
  final String? createdForTTL;
  final List<PaymentHistory>? paymentHistory;
  final String? referralCode;
  final String? planEndDate;
  final List<String>? fcmTokens;

  User({
    this.location,
    this.id,
    this.name,
    this.email,
    this.gender,
    this.phone,
    this.addressLane1,
    this.addressLane2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isOnline,
    this.blockedUsers,
    this.role,
    this.isVerified,
    this.isDeleted,
    this.deletedMessage,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.lastSeen,
    this.profile,
    this.deletedTime,
    this.plan,
    this.previousPlan,
    this.createdForTTL,
    this.paymentHistory,
    this.referralCode,
    this.planEndDate,
    this.fcmTokens,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
      addressLane1: json['addressLane1'],
      addressLane2: json['addressLane2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
      isOnline: json['isOnline'],
      blockedUsers: json['blockedUsers'] != null ? List<String>.from(json['blockedUsers']) : null,
      role: json['role'],
      isVerified: json['isVerified'],
      isDeleted: json['isDeleted'],
      deletedMessage: json['deletedMessage'],
      isDisabled: json['isDisabled'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
      lastSeen: json['lastSeen'],
      profile: json['profile'],
      deletedTime: json['deletedTime'],
      plan: json['plan'],
      previousPlan: json['previousPlan'],
      createdForTTL: json['createdForTTL'],
      paymentHistory: json['paymentHistory'] != null
          ? (json['paymentHistory'] as List).map((e) => PaymentHistory.fromJson(e)).toList()
          : null,
      referralCode: json['referralCode'],
      planEndDate: json['planEndDate'],
      fcmTokens: json['fcmTokens'] != null ? List<String>.from(json['fcmTokens']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      '_id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'phone': phone,
      'addressLane1': addressLane1,
      'addressLane2': addressLane2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'isOnline': isOnline,
      'blockedUsers': blockedUsers,
      'role': role,
      'isVerified': isVerified,
      'isDeleted': isDeleted,
      'deletedMessage': deletedMessage,
      'isDisabled': isDisabled,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
      'lastSeen': lastSeen,
      'profile': profile,
      'deletedTime': deletedTime,
      'plan': plan,
      'previousPlan': previousPlan,
      'createdForTTL': createdForTTL,
      'paymentHistory': paymentHistory?.map((e) => e.toJson()).toList(),
      'referralCode': referralCode,
      'planEndDate': planEndDate,
      'fcmTokens': fcmTokens,
    };
  }
}

class Location {
  final double? latitude;
  final double? longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PaymentHistory {
  final String? orderId;
  final int? amount;
  final String? currency;
  final String? status;
  final Method? method;
  final String? paidAt;
  final String? id;

  PaymentHistory({
    this.orderId,
    this.amount,
    this.currency,
    this.status,
    this.method,
    this.paidAt,
    this.id,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      orderId: json['orderId'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      method: json['method'] != null ? Method.fromJson(json['method']) : null,
      paidAt: json['paidAt'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'method': method?.toJson(),
      'paidAt': paidAt,
      '_id': id,
    };
  }
}

class Method {
  final Upi? upi;

  Method({this.upi});

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      upi: json['upi'] != null ? Upi.fromJson(json['upi']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'upi': upi?.toJson(),
    };
  }
}

class Upi {
  final String? channel;
  final String? upiId;

  Upi({this.channel, this.upiId});

  factory Upi.fromJson(Map<String, dynamic> json) {
    return Upi(
      channel: json['channel'],
      upiId: json['upi_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'upi_id': upiId,
    };
  }
}
