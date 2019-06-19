//
//  KKHomePageModel.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

/**
 KKHomeContent --> KKHCTT
 */

#import "KKModel.h"



NS_ASSUME_NONNULL_BEGIN

@class KKHomeContentModel;
@interface KKHomePageModel : KKModel
@property (nonatomic,  copy) NSString *code;
@property (nonatomic,  copy) NSString *content;
@property (nonatomic,strong) KKHomeContentModel *contentModel;

@end


@class KKHCTTFilterWordModel,KKHCTTUserInfoModel;
@interface KKHomeContentModel : KKModel
@property (nonatomic,  copy) NSString *abstract;
@property (nonatomic,strong) NSArray *action_list;
@property (nonatomic,strong) NSNumber *aggr_type;
@property (nonatomic,assign) BOOL allow_download;

@property (nonatomic, strong) NSNumber *article_sub_type;
@property (nonatomic, strong) NSNumber *article_type;
@property (nonatomic, strong) NSURL *article_url;
@property (nonatomic, strong) NSNumber *article_version;

@property (nonatomic, strong) NSNumber *ban_comment;
@property (nonatomic, strong) NSNumber *behot_time;
@property (nonatomic, strong) NSNumber *bury_count;
@property (nonatomic, strong) NSNumber *cell_flag;

@property (nonatomic, strong) NSNumber *cell_layout_style;
@property (nonatomic, strong) NSNumber *cell_type;
@property (nonatomic, strong) NSNumber *comment_count;
@property (nonatomic,   copy) NSString *content_decoration;

@property (nonatomic, strong) NSNumber *cursor;
@property (nonatomic, strong) NSNumber *digg_count;
@property (nonatomic, strong) NSURL *display_url;
@property (nonatomic,   copy) NSString *feed_title;

@property (nonatomic, strong) NSArray<KKHCTTFilterWordModel *> *filter_words;
@property (nonatomic, strong) NSNumber *forward_info;
@property (nonatomic, strong) NSNumber *group_id;
@property (nonatomic, assign) BOOL has_m3u8_video;

@property (nonatomic, strong) NSNumber *has_mp4_video;
@property (nonatomic, assign) BOOL has_video;
@property (nonatomic, strong) NSNumber *hot;
@property (nonatomic, strong) NSNumber *ignore_web_transform;

@property (nonatomic,   copy) NSString *interaction_data;
@property (nonatomic, assign) BOOL is_stick;
@property (nonatomic, assign) BOOL is_subject;
@property (nonatomic, strong) NSNumber *item_id;

@property (nonatomic, strong) NSNumber *item_version;
@property (nonatomic,   copy) NSString *keywords;
@property (nonatomic,   copy) NSString *label;
@property (nonatomic, strong) NSDictionary *label_extra;

@property (nonatomic, strong) NSNumber *label_style;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSDictionary *log_pb;
@property (nonatomic, strong) NSDictionary *media_info;

@property (nonatomic,   copy) NSString *media_name;
@property (nonatomic, strong) NSNumber *need_client_impr_recycle;
@property (nonatomic, strong) NSNumber *preload_web;
@property (nonatomic, strong) NSNumber *publish_time;

@property (nonatomic, strong) NSNumber *read_count;
@property (nonatomic, strong) NSNumber *repin_count;
@property (nonatomic,   copy) NSString *rid;
@property (nonatomic, strong) NSNumber *share_count;

@property (nonatomic, strong) NSDictionary *share_info;
@property (nonatomic, strong) NSURL *share_url;
@property (nonatomic, assign) BOOL show_dislike;
@property (nonatomic, assign) BOOL show_portrait;

@property (nonatomic, assign) BOOL show_portrait_article;
@property (nonatomic,   copy) NSString *source;
@property (nonatomic, strong) NSNumber *source_icon_style;
@property (nonatomic,   copy) NSString *source_open_url;

@property (nonatomic,   copy) NSString *stick_label;
@property (nonatomic, strong) NSNumber *stick_style;
@property (nonatomic,   copy) NSString *tag;
@property (nonatomic, strong) NSNumber *tag_id;

@property (nonatomic, strong) NSNumber *tip;
@property (nonatomic,   copy) NSString *title;
@property (nonatomic, strong) NSDictionary *ugc_recommend;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) KKHCTTUserInfoModel *user_info;
@property (nonatomic, strong) NSNumber *user_repin;
@property (nonatomic, strong) NSNumber *user_verified;
@property (nonatomic,   copy) NSString *verified_content;

@property (nonatomic, strong) NSNumber *video_style;


@end



/**
 内容过滤Model
 */
@interface KKHCTTFilterWordModel : KKModel
@property (nonatomic,   copy) NSString *Id;
@property (nonatomic, assign) BOOL is_selected;
@property (nonatomic,   copy) NSString *name;

@end


@interface KKHCTTUserInfoModel : KKModel
@property (nonatomic, strong) NSURL *avatar_url;
@property (nonatomic,   copy) NSString *desc;
@property (nonatomic, assign) BOOL follow;
@property (nonatomic, strong) NSNumber *follower_count;

@property (nonatomic, strong) NSNumber *live_info_type;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *schema;
@property (nonatomic, strong) NSNumber *user_id;

@property (nonatomic, assign) BOOL user_verified;
@property (nonatomic,   copy) NSString *verified_content;

@end

NS_ASSUME_NONNULL_END