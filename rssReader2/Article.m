//
//  Article.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/26.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "Article.h"

@implementation Article

@synthesize articleID, title, description, link, pubDate, enclosure;

-(Article *) initArticle{
    
    Article *article = [[Article alloc] init];
    return self;
}
@end
