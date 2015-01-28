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

@synthesize headingTextView , enclosure
;
- (void)awakeFromNib {
    // Initialization code
}

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
        
        self.headingTextView= [[UITextView alloc] initWithFrame:CGRectMake(70, 20, 400, 80)];
        self.headingTextView.textColor = [UIColor blackColor];
        self.headingTextView.font = [UIFont fontWithName:@"Arial" size:10.0f];
        
 
        [self addSubview:self.enclosure];
        [self addSubview:self.headingTextView];
    }
    return self;
    
}

@end
