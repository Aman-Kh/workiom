class EditionsWithFeatures {
  Edition? edition;
  List<FeatureValues>? featureValues;

  EditionsWithFeatures({this.edition, this.featureValues});

  EditionsWithFeatures.fromJson(Map<String, dynamic> json) {
    edition =
    json['edition'] != null ? Edition.fromJson(json['edition']) : null;
    if (json['featureValues'] != null) {
      featureValues = <FeatureValues>[];
      json['featureValues'].forEach((v) {
        featureValues!.add(FeatureValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (edition != null) {
      data['edition'] = edition!.toJson();
    }
    if (featureValues != null) {
      data['featureValues'] =
          featureValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeatureValues {
  String? name;
  String? value;

  FeatureValues({this.name, this.value});

  FeatureValues.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Edition {
  String? name;
  String? displayName;
  String? publicDescription;
  String? internalDescription;
  bool? isPublished;
  bool? isRegistrable;
  int? type;
  int? minimumUsersCount;
  double? monthlyPrice;
  double? annualPrice;
  int? waitingDayAfterExpire;
  int? trialDayCount;
  int? countAllowExtendTrial;
  bool? hasTrial;
  bool? disableWorkspaceAfterExpire;
  String? isMostPopular;
  String? doNotSendVerifyEmail;
  ExpiringEdition? expiringEdition;
  int? id;

  Edition(
      {this.name,
        this.displayName,
        this.publicDescription,
        this.internalDescription,
        this.isPublished,
        this.isRegistrable,
        this.type,
        this.minimumUsersCount,
        this.monthlyPrice,
        this.annualPrice,
        this.waitingDayAfterExpire,
        this.trialDayCount,
        this.countAllowExtendTrial,
        this.hasTrial,
        this.disableWorkspaceAfterExpire,
        this.isMostPopular,
        this.doNotSendVerifyEmail,
        this.expiringEdition,
        this.id});

  Edition.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    publicDescription = json['publicDescription'];
    internalDescription = json['internalDescription'];
    isPublished = json['isPublished'];
    isRegistrable = json['isRegistrable'];
    type = json['type'];
    minimumUsersCount = json['minimumUsersCount'];
    monthlyPrice = json['monthlyPrice'];
    annualPrice = json['annualPrice'];
    waitingDayAfterExpire = json['waitingDayAfterExpire'];
    trialDayCount = json['trialDayCount'];
    countAllowExtendTrial = json['countAllowExtendTrial'];
    hasTrial = json['hasTrial'];
    disableWorkspaceAfterExpire = json['disableWorkspaceAfterExpire'];
    isMostPopular = json['isMostPopular'];
    doNotSendVerifyEmail = json['doNotSendVerifyEmail'];
    expiringEdition = json['expiringEdition'] != null
        ?  ExpiringEdition.fromJson(json['expiringEdition'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['publicDescription'] = this.publicDescription;
    data['internalDescription'] = this.internalDescription;
    data['isPublished'] = this.isPublished;
    data['isRegistrable'] = this.isRegistrable;
    data['type'] = this.type;
    data['minimumUsersCount'] = this.minimumUsersCount;
    data['monthlyPrice'] = this.monthlyPrice;
    data['annualPrice'] = this.annualPrice;
    data['waitingDayAfterExpire'] = this.waitingDayAfterExpire;
    data['trialDayCount'] = this.trialDayCount;
    data['countAllowExtendTrial'] = this.countAllowExtendTrial;
    data['hasTrial'] = this.hasTrial;
    data['disableWorkspaceAfterExpire'] = this.disableWorkspaceAfterExpire;
    data['isMostPopular'] = this.isMostPopular;
    data['doNotSendVerifyEmail'] = this.doNotSendVerifyEmail;
    if (this.expiringEdition != null) {
      data['expiringEdition'] = this.expiringEdition!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class ExpiringEdition {
  String? name;
  String? displayName;
  int? id;

  ExpiringEdition({this.name, this.displayName, this.id});

  ExpiringEdition.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['displayName'] = displayName;
    data['id'] = id;
    return data;
  }
}