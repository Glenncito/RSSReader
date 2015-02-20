//
//  ViewController.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesTVC.h"
#import "DetailViewController.h"
#import "CatBarTVC.h"
//#import "AppDelegate.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>{
   
    CatBarTVC *categoryBar;
    ArticlesTVC *articlesList;
    
    UIView *pView;
    UIView *lView;
    
    UIDeviceOrientation orientation;
    UITableView *articles;
    DetailViewController *dvc;
    UINavigationController *NC;
    BOOL isShowingLandscapeView;

}

@property (strong, nonatomic) ArticlesTVC *articles;

@property (nonatomic, retain) UIView *pView;
@property (nonatomic, retain) UIView *lView;

- (void)clearCurrentView;
-(void) initUIElements;
+(void)action;
-(void) reloadTableView;

//-(void) saveData:(id)sender;
//-(void) findCategory:(id)sender;
@end
