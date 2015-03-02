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

#import "Articles.h"

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
            self.categoryName = @"Top Stories";
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
    }else if ([category isEqualToString:@"Tech"]){
        self.categoryURL = @"http://feeds.news24.com/articles/fin24/tech/rss";
    }else if ([category isEqualToString:@"Business"]){
        self.categoryURL = @"http://feeds.news24.com/articles/fin24/news/rss";
    }
    
    //this will be send with the article data to the object model
    self.categoryName = category;
    
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
        
        //[self.articles addObject:article];
        if([self recordAlreadyExists:article]==NO){
        [self addArticleToObjectModel:article];
        }else {
            NSLog (@"\n---\n'%@' was not added to the database",article.title);
        }
        
        self.currentTitle = nil;
        self.currentDescription = nil;
        self.currentLink = nil;
        self.currentPubDate = nil;
        self.currentEnclosure = nil;
        article = nil;
    }
    
    
    self.currentElement = nil;
}
#pragma mark ------Core Data interaction------

-(void)addArticleToObjectModel:(Article *) articleObject{
     
     //put object in model
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Articles *articleEntity;
    
    articleEntity = [NSEntityDescription
                insertNewObjectForEntityForName:@"Articles"
                inManagedObjectContext:context];
    
    articleEntity.articleDescription = articleObject.description;
    articleEntity.categoryName = self.categoryName;
    articleEntity.enclosure= articleObject.enclosure;
    articleEntity.link= articleObject.link;
    articleEntity.pubDate= articleObject.pubDate;
    articleEntity.title= articleObject.title;
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }else
        NSLog(@"\n---\n'%@' has been added to the db",articleEntity.title);

    
     
     
}



-(BOOL)recordAlreadyExists:(Article *)articleObject{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Articles"
                                              inManagedObjectContext:context];
  
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"categoryName = %@", self.categoryName];
    request.predicate = predicate;
    
    [request setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    if (!fetchedObjects) {
        NSLog(@"Fetch error: %@", error);
        abort();
    }
    
    BOOL exists = NO;

    for (Articles *info in fetchedObjects) {
        if([articleObject.link isEqualToString:info.link]){
            NSLog (@"\n--\n'%@' exists\n",info.title);
            exists = YES;

        }
    }
    if (exists==YES){
        return YES;
    }else{
        return NO;
    }
    return 0;
}
-(void) buildArticleList{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Articles"
                                              inManagedObjectContext:context];
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"categoryName = %@", self.categoryName];
    request.predicate = predicate;

    [request setEntity:entity];
    [request setFetchLimit:20];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    for (Articles *info in fetchedObjects) {
      //  NSLog (@"article name: %@", info.title);
        [self.articles addObject:info];
    }


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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationKey_XMLProcessingDone" object:nil];
    } else {
        NSLog(@"Error occurred during XML processing");
    }
   [self buildArticleList];
    
}


@end
