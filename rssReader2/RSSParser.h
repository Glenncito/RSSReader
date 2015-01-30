//
//  RSSParser.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/25.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Article.h"


@interface RSSParser : NSObject <NSXMLParserDelegate>{
    
    NSURL *rssURL;
    NSXMLParser *parser;
    Article *article;
    NSMutableArray *articles;
    BOOL errorParsing;
}
+ (RSSParser *)sharedRSSParser;

//-(RSSParser *) initRSSParser;
@property (nonatomic, strong) NSString *categoryURL;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSString *currentTitle;
@property (nonatomic, strong) NSString *currentDescription;
@property (nonatomic, strong) NSString *currentLink;
@property (nonatomic, strong) NSString *currentPubDate;
@property (nonatomic, strong) NSString *currentEnclosure;

@property (nonatomic, retain) NSMutableArray *articles;

//NICK: Make the method "public" ie. accessible from outside classes
//GLENN: So do you mean turning it into a class method?
- (void) reloadParser:(NSString *)category;


@end
