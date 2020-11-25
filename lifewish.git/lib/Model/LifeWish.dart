class LifeWish {
  String ID;
  String msgTo;
  String subject;
  bool isScheduled;
  String scheduledTime;
  String msgBody;
  String msgFormatting;
  int msgType; // DRAFT = 1, SENT = 2, RECEIVED = 3
  List<LifeWishMedia> medias;
  String createdOn;
  String modifiedOn;

  LifeWish(
      {this.ID,
      this.msgTo,
      this.subject,
      this.isScheduled,
      this.scheduledTime,
      this.msgBody,
      this.msgFormatting,
      this.msgType,
      this.medias,
      this.createdOn,
      this.modifiedOn});

  factory LifeWish.fromMap(Map<String, dynamic> json) => new LifeWish(
        ID: json["id"],
        msgTo: json["msg_to"],
        subject: json["subject"],
        isScheduled: json["is_scheduled"] == 1,
        scheduledTime: json["scheduled_time"],
        msgBody: json["msg_body"],
        msgFormatting: json["msg_formatting"],
        msgType: json["msg_type"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
        medias: json["medias"]
            ?.map((media) => LifeWishMedia.fromMap(json["medias"])),
      );

  Map<String, dynamic> toMap() => {
        "id": ID,
        "msg_to": msgTo,
        "subject": subject,
        "is_scheduled": isScheduled,
        "scheduled_time": scheduledTime,
        "msg_body": msgBody,
        "msg_formatting": msgFormatting,
        "msg_type": msgType,
        "created_on": createdOn,
        "modified_on": modifiedOn,
      };
}

class LifeWishMedia {
  int id;
  int mediaType;
  String mediaLink;
  String createdOn;
  String modifiedOn;

  LifeWishMedia(
      {this.id,
      this.mediaType,
      this.mediaLink,
      this.createdOn,
      this.modifiedOn});

  factory LifeWishMedia.fromMap(Map<String, dynamic> json) => new LifeWishMedia(
        id: json["id"],
        mediaType: json["media_type"],
        mediaLink: json["media_link"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "media_type": mediaType,
        "media_link": mediaLink,
        "created_on": createdOn,
        "modified_on": modifiedOn,
      };
}
