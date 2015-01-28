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

@implementation RSSParser

@synthesize articles;


- (RSSParser *) initRSSParser {
   

    if (!self.categoryURL){
        NSString *string = @"http://feeds.news24.com/articles/news24/TopStories/rss";
        self.categoryURL = string;
    }
    rssURL = [[NSURL alloc]initWithString:self.categoryURL];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    [parser setDelegate:self];
    [parser parse];

    return self;
}
//this was part of my failed attempt to control the RSS feed according to the Category view selection.

-(void) reloadParser:(NSString *)category{
    if ([category isEqualToString:@"TopStories"]){
        self.categoryURL = @"http://feeds.news24.com/articles/news24/TopStories/rss";
    }else if ([category isEqualToString:@"SouthAfrica"]){
        self.categoryURL = @"http://feeds.news24.com/articles/news24/SouthAfrica/rss";
    }else if ([category isEqualToString:@"World"]){
        self.categoryURL = @"http://feeds.news24.com/articles/news24/World/rss";
    }else if ([category isEqualToString:@"news"]){
        self.categoryURL = @"http://feeds.news24.com/articles/news24/news/rss";
    }
        
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
    if (!self.articles){
        self.articles = [[NSMutableArray alloc]init];
    }
    //Here I settled for a workaround hack rather than a clean solution. The problem I was facing is that I was only able to read the 'enclosure' value in this delegate and not the 'found characters' delegate. I tried to place all the object attribute definers in one place but I couldn't get it right.
    
    //the other dirty hack is nullifying the relevant instance variables in the last if statement, I'm sure theres a better way I could have done this.
    
   else if ([self.currentElement isEqualToString:@"enclosure"]){
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
} else {
NSLog(@"Error occurred during XML processing");
}
    
}


@end
