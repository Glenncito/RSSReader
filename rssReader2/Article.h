//
//  Article.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/26.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject{

    NSInteger articleID;
    NSString *title;
    NSString *description;
    NSString *link;
    NSString *pubDate;
    NSString *enclosure;

}
@property (nonatomic, readwrite) NSInteger articleID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *pubDate;
@property (nonatomic, retain) NSString *enclosure;



-(Article *) initArticle;

@end
