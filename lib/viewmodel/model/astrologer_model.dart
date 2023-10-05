class AstrologerModel {
  bool? status;
  Data? data;

  AstrologerModel({this.status, this.data});

  AstrologerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Category>? category;
  List<Languages>? languages;
  List<AstrologerProfileModel>? astrologer;

  Data({this.category, this.languages, this.astrologer});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    if (json['astrologer'] != null) {
      astrologer = <AstrologerProfileModel>[];
      json['astrologer'].forEach((v) {
        astrologer!.add(new AstrologerProfileModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.astrologer != null) {
      data['astrologer'] = this.astrologer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? catName;
  String? slug;
  String? description;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.catName,
      this.slug,
      this.description,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_name'] = this.catName;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Languages {
  int? id;
  String? languageName;
  int? status;
  String? createdAt;
  String? updatedAt;

  Languages(
      {this.id,
      this.languageName,
      this.status,
      this.createdAt,
      this.updatedAt});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_name'] = this.languageName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AstrologerProfileModel {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? isVerifyMobile; 
  String? password;
  String? roleType;
  int? loginstatus;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? nToken;
  String? gender;
  int? astrologerId;
  String? longBio;
  String? photo;
  String? dob;
  String? experience;
  String? categories;
  String? language;
  String? call;
  String? chat;
  String? callPrice;
  String? chatPrice;
  String? availableCall;
  String? isBusy;
  String? availableChat;
  String? isRecommended;
  String? isOnboard;
  String? hoursContribute;
  String? howToTalk;
  String? onboardYou;
  String? interviewTime;
  String? city;
  String? business;
  String? highestQualification;
  String? diplomaDegree;
  String? university;
  String? workingPlatform;
  String? learnAstrology;
  String? instagram;
  String? facebook;
  String? linkedin;
  String? youtube;
  String? website;
  String? minEarning;
  String? maxEarning;
  String? travel;
  String? fullTime;
  String? astroQual; 
  String? sameQuery;
  String? accountNumber;
  String? ifsc;
  String? twintyMinPrice;
  String? thirdtyMinPrice;
  String? adharCard;
  String? panCard;

  AstrologerProfileModel(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.isVerifyMobile, 
      this.password,
      this.roleType,
      this.loginstatus,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.nToken,
      this.gender,
      this.astrologerId,
      this.longBio,
      this.photo,
      this.dob,
      this.experience,
      this.categories,
      this.language,
      this.call,
      this.chat,
      this.callPrice,
      this.chatPrice,
      this.availableCall,
      this.isBusy,
      this.availableChat,
      this.isRecommended,
      this.isOnboard,
      this.hoursContribute,
      this.howToTalk,
      this.onboardYou,
      this.interviewTime,
      this.city,
      this.business,
      this.highestQualification,
      this.diplomaDegree,
      this.university,
      this.workingPlatform,
      this.learnAstrology,
      this.instagram,
      this.facebook,
      this.linkedin,
      this.youtube,
      this.website,
      this.minEarning,
      this.maxEarning,
      this.travel,
      this.fullTime,
      this.astroQual, 
      this.sameQuery,
      this.accountNumber,
      this.ifsc,
      this.twintyMinPrice,
      this.thirdtyMinPrice,
      this.adharCard,
      this.panCard});

  AstrologerProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    isVerifyMobile = json['is_verify_mobile']; 
    password = json['password'];
    roleType = json['role_type'];
    loginstatus = json['loginstatus'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nToken = json['nToken'];
    gender = json['gender'];
    astrologerId = json['astrologer_id'];
    longBio = json['long_bio'];
    photo = json['photo'];
    dob = json['dob'];
    experience = json['experience'];
    categories = json['categories'];
    language = json['language'];
    call = json['call'];
    chat = json['chat'];
    callPrice = json['call_price'];
    chatPrice = json['chat_price'];
    availableCall = json['available_call'];
    isBusy = json['is_busy'];
    availableChat = json['available_chat'];
    isRecommended = json['is_recommended'];
    isOnboard = json['is_onboard'];
    hoursContribute = json['hours_contribute'];
    howToTalk = json['how_to_talk'];
    onboardYou = json['onboard_you'];
    interviewTime = json['interview_time'];
    city = json['city'];
    business = json['business'];
    highestQualification = json['highest_qualification'];
    diplomaDegree = json['diploma_degree'];
    university = json['university'];
    workingPlatform = json['working_platform'];
    learnAstrology = json['learn_astrology'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    website = json['website'];
    minEarning = json['min_earning'];
    maxEarning = json['max_earning'];
    travel = json['travel'];
    fullTime = json['fullTime'];
    astroQual = json['astroQual']; 
    sameQuery = json['sameQuery'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    twintyMinPrice = json['twinty_min_price'];
    thirdtyMinPrice = json['thirdty_min_price'];
    adharCard = json['adhar_card'];
    panCard = json['pan_card'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['is_verify_mobile'] = this.isVerifyMobile; 
    data['password'] = this.password;
    data['role_type'] = this.roleType;
    data['loginstatus'] = this.loginstatus;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nToken'] = this.nToken;
    data['gender'] = this.gender;
    data['astrologer_id'] = this.astrologerId;
    data['long_bio'] = this.longBio;
    data['photo'] = this.photo;
    data['dob'] = this.dob;
    data['experience'] = this.experience;
    data['categories'] = this.categories;
    data['language'] = this.language;
    data['call'] = this.call;
    data['chat'] = this.chat;
    data['call_price'] = this.callPrice;
    data['chat_price'] = this.chatPrice;
    data['available_call'] = this.availableCall;
    data['is_busy'] = this.isBusy;
    data['available_chat'] = this.availableChat;
    data['is_recommended'] = this.isRecommended;
    data['is_onboard'] = this.isOnboard;
    data['hours_contribute'] = this.hoursContribute;
    data['how_to_talk'] = this.howToTalk;
    data['onboard_you'] = this.onboardYou;
    data['interview_time'] = this.interviewTime;
    data['city'] = this.city;
    data['business'] = this.business;
    data['highest_qualification'] = this.highestQualification;
    data['diploma_degree'] = this.diplomaDegree;
    data['university'] = this.university;
    data['working_platform'] = this.workingPlatform;
    data['learn_astrology'] = this.learnAstrology;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['linkedin'] = this.linkedin;
    data['youtube'] = this.youtube;
    data['website'] = this.website;
    data['min_earning'] = this.minEarning;
    data['max_earning'] = this.maxEarning;
    data['travel'] = this.travel;
    data['fullTime'] = this.fullTime;
    data['astroQual'] = this.astroQual; 
    data['sameQuery'] = this.sameQuery;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['twinty_min_price'] = this.twintyMinPrice;
    data['thirdty_min_price'] = this.thirdtyMinPrice;
    data['adhar_card'] = this.adharCard;
    data['pan_card'] = this.panCard;
    return data;
  }
}
