class ViewChat {
  String? sId;
  bool? isGroupChat;
  List<Participants>? participants;
  String? createdAt;
  String? updatedAt;
  int? iV;
  LastMessage? lastMessage;

  ViewChat(
      {this.sId,
      this.isGroupChat,
      this.participants,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.lastMessage});

  ViewChat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isGroupChat = json['isGroupChat'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isGroupChat'] = this.isGroupChat;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    return data;
  }
}

class Participants {
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? phone;
  String? addressLane1;
  String? addressLane2;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  bool? isOnline;
  List<Null>? blockedUsers;
  String? role;
  bool? isVerified;
  bool? isDeleted;
  String? deletedMessage;
  bool? isDisabled;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastSeen;
  String? profile;
  String? deletedTime;
  String? plan;
  String? previousPlan;
  String? createdForTTL;
  List<PaymentHistory>? paymentHistory;
  String? referralCode;
  String? planEndDate;
  List<dynamic>? fcmTokens;

  Participants(
      {this.location,
      this.sId,
      this.name,
      this.email,
      this.password,
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
      this.iV,
      this.lastSeen,
      this.profile,
      this.deletedTime,
      this.plan,
      this.previousPlan,
      this.createdForTTL,
      this.paymentHistory,
      this.referralCode,
      this.planEndDate,
      this.fcmTokens});

  Participants.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    phone = json['phone'];
    addressLane1 = json['addressLane1'];
    addressLane2 = json['addressLane2'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
    isOnline = json['isOnline'];
    if (json['blockedUsers'] != null) {
      blockedUsers = <Null>[];
      json['blockedUsers'].forEach((v) {
        blockedUsers!.add(v);
      });
    }
    role = json['role'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    deletedMessage = json['deletedMessage'];
    isDisabled = json['isDisabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastSeen = json['lastSeen'];
    profile = json['profile'];
    deletedTime = json['deletedTime'];
    plan = json['plan'];
    previousPlan = json['previousPlan'];
    createdForTTL = json['createdForTTL'];
    if (json['paymentHistory'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['paymentHistory'].forEach((v) {
        paymentHistory!.add(new PaymentHistory.fromJson(v));
      });
    }
    referralCode = json['referralCode'];
    planEndDate = json['planEndDate'];
    fcmTokens = json['fcmTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['addressLane1'] = this.addressLane1;
    data['addressLane2'] = this.addressLane2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    data['isOnline'] = this.isOnline;
    if (this.blockedUsers != null) {
      data['blockedUsers'] = this.blockedUsers;
    }
    data['role'] = this.role;
    data['isVerified'] = this.isVerified;
    data['isDeleted'] = this.isDeleted;
    data['deletedMessage'] = this.deletedMessage;
    data['isDisabled'] = this.isDisabled;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['lastSeen'] = this.lastSeen;
    data['profile'] = this.profile;
    data['deletedTime'] = this.deletedTime;
    data['plan'] = this.plan;
    data['previousPlan'] = this.previousPlan;
    data['createdForTTL'] = this.createdForTTL;
    if (this.paymentHistory != null) {
      data['paymentHistory'] =
          this.paymentHistory!.map((v) => v.toJson()).toList();
    }
    data['referralCode'] = this.referralCode;
    data['planEndDate'] = this.planEndDate;
    data['fcmTokens'] = this.fcmTokens;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class PaymentHistory {
  String? orderId;
  int? amount;
  String? currency;
  String? status;
  Method? method;
  String? paidAt;
  String? sId;

  PaymentHistory(
      {this.orderId,
      this.amount,
      this.currency,
      this.status,
      this.method,
      this.paidAt,
      this.sId});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    method =
        json['method'] != null ? new Method.fromJson(json['method']) : null;
    paidAt = json['paidAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    if (this.method != null) {
      data['method'] = this.method!.toJson();
    }
    data['paidAt'] = this.paidAt;
    data['_id'] = this.sId;
    return data;
  }
}

class Method {
  Upi? upi;

  Method({this.upi});

  Method.fromJson(Map<String, dynamic> json) {
    upi = json['upi'] != null ? new Upi.fromJson(json['upi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upi != null) {
      data['upi'] = this.upi!.toJson();
    }
    return data;
  }
}

class Upi {
  String? channel;
  String? upiId;

  Upi({this.channel, this.upiId});

  Upi.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel'] = this.channel;
    data['upi_id'] = this.upiId;
    return data;
  }
}

class LastMessage {
  String? sId;
  String? senderId;
  String? content;
  String? messageType;
  String? fileUrl;
  String? createdAt;

  LastMessage(
      {this.sId,
      this.senderId,
      this.content,
      this.messageType,
      this.fileUrl,
      this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'];
    content = json['content'];
    messageType = json['messageType'];
    fileUrl = json['fileUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['senderId'] = this.senderId;
    data['content'] = this.content;
    data['messageType'] = this.messageType;
    data['fileUrl'] = this.fileUrl;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
