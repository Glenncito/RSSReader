//
//  RSS.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/23.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSS : NSObject{
    NSInteger articleID;
    NSString *title;
    NSString *decription;
    NSString *link;
    NSString *pubDate;
    NSString *url;
}

@property (nonatomic, readwrite) NSInteger articleID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *pubDate;
@property (nonatomic, retain) NSString *url;

@end
