//
//  CatTableViewCell.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "CatTableViewCell.h"

@implementation CatTableViewCell

@synthesize nameLabel = _nameLagel;

- (void)awakeFromNib {
    // Initialization code
   }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected)
    {
        self.backgroundColor = [UIColor redColor];
       
    }
    else
    {
        self.backgroundColor = [UIColor blackColor];

    }

    // Configure the view for the selected state
}



-(void)setFrame:(CGRect)frame {
    if (self.superview ) {
        float cellWidth = 30.0;
        float cellHeight = 80.0;
        
        frame.origin.x = (self.superview.frame.size.width - cellWidth)/2;
        //frame.origin.y = (self.superview.frame.size.height -50);
        
       frame.size.width = cellWidth;
       //frame.size.height = cellHeight;
    }
    [super setFrame:frame];
}

/*
-(void)layoutSubviews
{
    self.textLabel.frame = CGRectMake(0, self.textLabel.frame.origin.y, self.frame.size.width, self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(0, self.detailTextLabel.frame.origin.y, self.frame.size.width, self.detailTextLabel.frame.size.height);
    [super layoutSubviews];


}*/



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
       self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -12, 100, 50)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
        self.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
//self.autoresizesSubviews=NO;
        
        [self addSubview:self.nameLabel];
    }
    return self;

}


@end
