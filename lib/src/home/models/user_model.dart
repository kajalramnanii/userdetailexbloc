class UserModel {
  UserModel({
    this.items,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  UserModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }
  List<Items>? items;
  bool? hasMore;
  num? quotaMax;
  num? quotaRemaining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['has_more'] = hasMore;
    map['quota_max'] = quotaMax;
    map['quota_remaining'] = quotaRemaining;
    return map;
  }
}

class Items {
  Items({
    this.owner,
    this.isAccepted,
    this.score,
    this.lastActivityDate,
    this.lastEditDate,
    this.creationDate,
    this.answerId,
    this.questionId,
    this.contentLicense,
  });

  Items.fromJson(dynamic json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    isAccepted = json['is_accepted'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    lastEditDate = json['last_edit_date'];
    creationDate = json['creation_date'];
    answerId = json['answer_id'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
  }

  Owner? owner;
  bool? isAccepted;
  num? score;
  num? lastActivityDate;
  num? lastEditDate;
  num? creationDate;
  num? answerId;
  num? questionId;
  String? contentLicense;
  bool isFav = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['is_accepted'] = isAccepted;
    map['score'] = score;
    map['last_activity_date'] = lastActivityDate;
    map['last_edit_date'] = lastEditDate;
    map['creation_date'] = creationDate;
    map['answer_id'] = answerId;
    map['question_id'] = questionId;
    map['content_license'] = contentLicense;
    return map;
  }
}

class Owner {
  Owner({
    this.reputation,
    this.userId,
    this.userType,
    this.acceptRate,
    this.profileImage,
    this.displayName,
    this.link,
  });

  Owner.fromJson(dynamic json) {
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    acceptRate = json['accept_rate'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }
  num? reputation;
  num? userId;
  String? userType;
  num? acceptRate;
  String? profileImage;
  String? displayName;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reputation'] = reputation;
    map['user_id'] = userId;
    map['user_type'] = userType;
    map['accept_rate'] = acceptRate;
    map['profile_image'] = profileImage;
    map['display_name'] = displayName;
    map['link'] = link;
    return map;
  }
}
