//
//  CatBarTVC.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatBarTVC : UITableViewController {
UITableView *tableView;
 NSMutableArray *categories;
}

@property (nonatomic, retain)  UITableView *tableView;
@property (nonatomic, retain)  NSMutableArray *categories; //when is this neccessary?

-(void) retrieveCategories;
@end

