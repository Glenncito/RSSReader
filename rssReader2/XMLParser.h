//
//  XMLParser.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/23.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AppDelegate, RSS;

@interface XMLParser : NSObject{
    NSMutableString *currentElementValue;
    
    AppDelegate *appDelegate;
    RSS *aRSS;
}

- (XMLParser *) initXMLParser;
@end
