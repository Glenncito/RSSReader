//
//  DetailViewController.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/30.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface DetailViewController : UIViewController<UINavigationBarDelegate>{
    UIImageView *enclosure;
    NSObject *story;
}

@property (strong, nonatomic) UIViewController *detailVC;
//@property (strong, nonatomic) NSObject *story;

@property (nonatomic, strong) UIImageView *enclosure;
@property (nonatomic, strong)  UILabel *headingLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UITextView *articleDescription;
@property (nonatomic, strong) UILabel *link;

@property (nonatomic, strong) Article *currentArticle;

- (id) initWithArticle:(Article *)article;

@end
