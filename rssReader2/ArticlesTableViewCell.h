//
//  ArticlesTableViewCell.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/26.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticlesTableViewCell : UITableViewCell
{
       
}
@property (nonatomic, strong) UIImageView *enclosure;
@property (nonatomic, strong)  UITextView *headingTextView;
@property (nonatomic, strong) UILabel *dateLabel;

- (void) configureForArticle:(Article *)article;

@end
