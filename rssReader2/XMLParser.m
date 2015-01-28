//
//  XMLParser.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/23.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "XMLParser.h"
#import "AppDelegate.h"
#import "RSS.h"

@implementation XMLParser

- (XMLParser *) initXMLParser {
    
    [super init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return self;
}

-(void) parser:(NSXMLParser *) parser didStartElement: (NSString *) elementName
nameSpaceURI:(NSString *)nameSpaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *) attributeDict{
    
    if ([elementName isEqualToString:@"RSS"]){
        //init array
        AppDelegate = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"RSS"]){
        //initialize the book.
        
        //init instance of RSS
        aRSS = [[RSS alloc] init];
        
        //extract attribute here
        aRSS.articleID = [[attributeDict objectForKey:@"id"] integerValue];
        
        NSLog (@"Reading id value :%i", aRSS.articleID);
        
    }
    NSLog (@"PRocessing Element: %@", elementName);
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *) string
{
    if (!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    else
        [currentElementValue appendString:string];
    
    NSLog (@"Processing value: %@", currentElementValue);
}

-(void) parser: (NSXMLParser *) parser didEndElement:(NSString *)elementName
  NamespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString: @"Book"])
        return;
    
    
}

@end
