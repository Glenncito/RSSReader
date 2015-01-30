//
//  ArticlesTableViewCell.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/26.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "ArticlesTableViewCell.h"
#import "RSSParser.h"

@implementation ArticlesTableViewCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        self.enclosure = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,48,48)];
        self.enclosure.tag = 1;
         //self.imageView = nil;
        
        self.dateLabel = [[UILabel alloc] initWithFrame: CGRectMake (75,-10,50,50)];
        self.dateLabel.textColor = [UIColor grayColor];
        self.dateLabel.font = [UIFont fontWithName:@"Arial" size:8.0f];
        
        self.headingTextView= [[UITextView alloc] initWithFrame:CGRectMake(80, 20, 400, 30)];
        self.headingTextView.textColor = [UIColor blackColor];
        self.headingTextView.font = [UIFont fontWithName:@"Arial" size:10.0f];
        
        self.exclusiveTouch = NO;
        
        [self addSubview:self.dateLabel];
        [self addSubview:self.enclosure];
        [self addSubview:self.headingTextView];
        
        
        //Here the Date only appears in the first cell, but when I scroll down and up again it re-appears
            }
    return self;
    
}

- (void) configureForArticle:(Article *)article {
    NSString *dateString = article.pubDate;
    self.dateLabel.text = dateString;
    self.headingTextView.text = article.title;
    self.headingTextView.editable = NO;
}

@end
