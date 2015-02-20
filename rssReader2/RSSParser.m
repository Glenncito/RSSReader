//
//  RSSParser.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/25.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "RSSParser.h"
#import "ViewController.h"
#import "Article.h"
#import "ArticlesTVC.h"
#import "CatBarTVC.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation RSSParser

@synthesize articles;

+(RSSParser *) sharedRSSParser{
    static RSSParser *sharedRSSParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRSSParser = [[self alloc] init];
    });
    
    if (sharedRSSParser==nil){
        sharedRSSParser = [[self alloc]init];
    }
    return sharedRSSParser;
}
- (id)init {
    if (self = [super init]) {
        self.articles = [[NSMutableArray alloc]init];
        
        if (!self.categoryURL){
            NSString *string = @"http://feeds.news24.com/articles/news24/TopStories/rss";
            self.categoryURL = string;
        }
        rssURL = [[NSURL alloc]initWithString:self.categoryURL];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
        [parser setDelegate:self];
        [parser parse];

    }
    return self;
}
/*
- (RSSParser *) initRSSParser {
    
    //NICK: Init your array here rather
    self.articles = [[NSMutableArray alloc]init];
    
    if (!self.categoryURL){
        NSString *string = @"http://feeds.news24.com/articles/news24/TopStories/rss";
        self.categoryURL = string;
    }
    rssURL = [[NSURL alloc]initWithString:self.categoryURL];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    [parser setDelegate:self];
    [parser parse];
    
    return self;
}*/

//this was part of my failed attempt to control the RSS feed according to the Category view selection.

-(void) reloadParser:(NSString *)category{
    //NICK: Some of your strings did not match the cateogoy strings exactly - this meant when I passed the string to this method it did pick up which URL to use.
   NSString *categoryURL;
    
    if ([category isEqualToString:@"Top Stories"]){
        self.categoryURL = @"http://feeds.news24.com/articles/news24/TopStories/rss";
    }else if ([category isEqualToString:@"South Africa"]){
    self.categoryURL = @"http://feeds.news24.com/articles/news24/SouthAfrica/rss";
    }else if ([category isEqualToString:@"World"]){
        self.categoryURL = @"http://feeds.news24.com/articles/news24/World/rss";
    }else if ([category isEqualToString:@"Sport"]){
        self.categoryURL = @"http://feeds.24.com/articles/sport/featured/topstories/rss";
    }else if ([category isEqualToString:@"Business"]){
        self.categoryURL = @"http://feeds.news24.com/articles/fin24/news/rss";
    }
    
    //NICK: Re-init array for the changes
    articles = [[NSMutableArray alloc]init];
    
    //NICK: You forgot to tell the parser to reload the data :)
    rssURL = [[NSURL alloc]initWithString:self.categoryURL];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    
    [parser setDelegate:self];
    [parser parse];
}

-(void)parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName
 namespaceURI: (NSString *) namespaceURI qualifiedName: (NSString *) qName attributes: (NSDictionary *) attributeDict{
    self.currentElement = elementName;
    errorParsing = NO;
    
    
    if ([self.currentElement isEqualToString:@"title"])
    {
        self.currentTitle = [NSMutableString string];
        
    }
    
    else if ([self.currentElement isEqualToString:@"description"]){
        
        self.currentDescription = [NSMutableString string];
        
    }
    else if ([self.currentElement isEqualToString:@"link"]){
        
        
        self.currentLink = [NSMutableString string];
        
        
    }else if ([self.currentElement isEqualToString:@"pubDate"]){
        
        self.currentPubDate = [NSMutableString string];
        
    }
    else if ([self.currentElement isEqualToString:@"enclosure"]){
        
        self.currentEnclosure = [NSMutableString string];
        NSMutableString *string = attributeDict [@"url"];
        self.currentEnclosure = string;
        
    }
}



-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NICK: I removed the array init from this method. The array should be initialised at the beginning of the process and not during the process
    
    //Here I settled for a workaround hack rather than a clean solution. The problem I was facing is that I was only able to read the 'enclosure' value in this delegate and not the 'found characters' delegate. I tried to place all the object attribute definers in one place but I couldn't get it right.
    
    //the other dirty hack is nullifying the relevant instance variables in the last if statement, I'm sure theres a better way I could have done this.
    
    //NICK: we can chat about this when we meet
    
    if ([self.currentElement isEqualToString:@"enclosure"]){
        article.enclosure = self.currentEnclosure;
        
        [self.articles addObject:article];
        
        self.currentTitle = nil;
        self.currentDescription = nil;
        self.currentLink = nil;
        self.currentPubDate = nil;
        self.currentEnclosure = nil;
        article = nil;
    }
    
    
    self.currentElement = nil;
}

-(void) parser: (NSXMLParser *) parser foundCharacters: (NSString *) string
{
    if (!article){
        article = [[Article alloc]initArticle];
    }
    if (!self.currentElement)
        return;
    
    if ([self.currentElement isEqualToString:@"title"])
    {
        NSArray *newString = [string componentsSeparatedByString:@" | "];
        if (newString.count >1){
            string = newString[1];
        }
        article.title = string;
        
    }else if ([self.currentElement isEqualToString:@"description"])
    {
        article.description = string;
        
    }
    else if ([self.currentElement isEqualToString:@"link"])
    {
        article.link = string;
        
    }else if ([self.currentElement isEqualToString:@"pubDate"])
    {
        NSString *substr = [string substringWithRange:NSMakeRange(5,11)];
        article.pubDate = substr;
        
    }
    else if ([self.currentElement isEqualToString:@"enclosure"]){
        
        article.enclosure = self.currentEnclosure;
        
        
    }
    
    
}

//error handlers
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    errorParsing = YES;
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (errorParsing == NO)
    {
        NSLog(@"XML processing done!");
        //NICK: Here we will broadcast a message to say that loading is done and our tableview can reload it's data
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationKey_XMLProcessingDone" object:nil];
    } else {
        NSLog(@"Error occurred during XML processing");
    }
    
}


@end
