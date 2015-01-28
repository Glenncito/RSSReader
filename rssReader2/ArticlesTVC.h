//
//  ArticlesTVC.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSParser.h"

@interface ArticlesTVC: UITableViewController{
    UITableView *tableView;
    NSMutableArray *articleList;
    RSSParser *parser;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain)  NSMutableArray *articleList;

@end