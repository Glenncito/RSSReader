//
//  RssCategory.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/02/20.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RssCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rssUrl;

@end
