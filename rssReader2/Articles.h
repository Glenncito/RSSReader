//
//  Articles.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/02/20.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Articles : NSManagedObject

@property (nonatomic, retain) NSString * articleDescription;
@property (nonatomic, retain) NSNumber * categoryName;
@property (nonatomic, retain) NSString * enclosure;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * pubDate;
@property (nonatomic, retain) NSString * title;

@end
