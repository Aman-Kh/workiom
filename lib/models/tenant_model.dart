class Tenant {
  String? tenancyName;
  String? name;
  int? ownerId;
  String? logoUrl;
  String? watermarkUrl;
  String? creationTime;
  Edition? edition;
  bool? isInReadOnlyMode;
  bool? isSubscribed;
  String? paymentPeriodType;
  String? subscriptionEndDateUtc;
  String? subscriptionCancelDateUtc;
  bool? isSubscriptionCanceled;
  String? subscriptionCustomName;
  String? trialPeriodStartDateUtc;
  String? trialPeriodEndDateUtc;
  bool? allowExtendTrial;
  bool? isInTrialPeriod;
  bool? isUsingTrial;
  double? trialPeriodDaysDuration;
  bool? hasCoupon;
  bool? isInLastPaidEdition;
  int? waitingDayAfterExpire;
  bool? disableTenantAfterExpire;
  String? moveToEditionAfterExpire;
  bool? setInReadOnlyModeAfterExpire;
  String? templateCategoryId;
  String? apiUrl;
  String? dnsUrl;
  int? id;

  Tenant(
      {this.tenancyName,
        this.name,
        this.ownerId,
        this.logoUrl,
        this.watermarkUrl,
        this.creationTime,
        this.edition,
        this.isInReadOnlyMode,
        this.isSubscribed,
        this.paymentPeriodType,
        this.subscriptionEndDateUtc,
        this.subscriptionCancelDateUtc,
        this.isSubscriptionCanceled,
        this.subscriptionCustomName,
        this.trialPeriodStartDateUtc,
        this.trialPeriodEndDateUtc,
        this.allowExtendTrial,
        this.isInTrialPeriod,
        this.isUsingTrial,
        this.trialPeriodDaysDuration,
        this.hasCoupon,
        this.isInLastPaidEdition,
        this.waitingDayAfterExpire,
        this.disableTenantAfterExpire,
        this.moveToEditionAfterExpire,
        this.setInReadOnlyModeAfterExpire,
        this.templateCategoryId,
        this.apiUrl,
        this.dnsUrl,
        this.id});

  Tenant.fromJson(Map<String, dynamic> json) {
    tenancyName = json['tenancyName'];
    name = json['name'];
    ownerId = json['ownerId'];
    logoUrl = json['logoUrl'];
    watermarkUrl = json['watermarkUrl'];
    creationTime = json['creationTime'];
    edition =
    json['edition'] != null ? Edition.fromJson(json['edition']) : null;
    isInReadOnlyMode = json['isInReadOnlyMode'];
    isSubscribed = json['isSubscribed'];
    paymentPeriodType = json['paymentPeriodType'];
    subscriptionEndDateUtc = json['subscriptionEndDateUtc'];
    subscriptionCancelDateUtc = json['subscriptionCancelDateUtc'];
    isSubscriptionCanceled = json['isSubscriptionCanceled'];
    subscriptionCustomName = json['subscriptionCustomName'];
    trialPeriodStartDateUtc = json['trialPeriodStartDateUtc'];
    trialPeriodEndDateUtc = json['trialPeriodEndDateUtc'];
    allowExtendTrial = json['allowExtendTrial'];
    isInTrialPeriod = json['isInTrialPeriod'];
    isUsingTrial = json['isUsingTrial'];
    trialPeriodDaysDuration = json['trialPeriodDaysDuration'];
    hasCoupon = json['hasCoupon'];
    isInLastPaidEdition = json['isInLastPaidEdition'];
    waitingDayAfterExpire = json['waitingDayAfterExpire'];
    disableTenantAfterExpire = json['disableTenantAfterExpire'];
    moveToEditionAfterExpire = json['moveToEditionAfterExpire'];
    setInReadOnlyModeAfterExpire = json['setInReadOnlyModeAfterExpire'];
    templateCategoryId = json['templateCategoryId'];
    apiUrl = json['apiUrl'];
    dnsUrl = json['dnsUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenancyName'] = this.tenancyName;
    data['name'] = this.name;
    data['ownerId'] = this.ownerId;
    data['logoUrl'] = this.logoUrl;
    data['watermarkUrl'] = this.watermarkUrl;
    data['creationTime'] = this.creationTime;
    if (this.edition != null) {
      data['edition'] = this.edition!.toJson();
    }
    data['isInReadOnlyMode'] = this.isInReadOnlyMode;
    data['isSubscribed'] = this.isSubscribed;
    data['paymentPeriodType'] = this.paymentPeriodType;
    data['subscriptionEndDateUtc'] = this.subscriptionEndDateUtc;
    data['subscriptionCancelDateUtc'] = this.subscriptionCancelDateUtc;
    data['isSubscriptionCanceled'] = this.isSubscriptionCanceled;
    data['subscriptionCustomName'] = this.subscriptionCustomName;
    data['trialPeriodStartDateUtc'] = this.trialPeriodStartDateUtc;
    data['trialPeriodEndDateUtc'] = this.trialPeriodEndDateUtc;
    data['allowExtendTrial'] = this.allowExtendTrial;
    data['isInTrialPeriod'] = this.isInTrialPeriod;
    data['isUsingTrial'] = this.isUsingTrial;
    data['trialPeriodDaysDuration'] = this.trialPeriodDaysDuration;
    data['hasCoupon'] = this.hasCoupon;
    data['isInLastPaidEdition'] = this.isInLastPaidEdition;
    data['waitingDayAfterExpire'] = this.waitingDayAfterExpire;
    data['disableTenantAfterExpire'] = this.disableTenantAfterExpire;
    data['moveToEditionAfterExpire'] = this.moveToEditionAfterExpire;
    data['setInReadOnlyModeAfterExpire'] = this.setInReadOnlyModeAfterExpire;
    data['templateCategoryId'] = this.templateCategoryId;
    data['apiUrl'] = this.apiUrl;
    data['dnsUrl'] = this.dnsUrl;
    data['id'] = this.id;
    return data;
  }
}

class Edition {
  String? name;
  String? displayName;
  int? type;
  int? id;

  Edition({this.name, this.displayName, this.type, this.id});

  Edition.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}