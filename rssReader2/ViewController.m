//
//  ViewController.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "ViewController.h"
#import "CatBarTVC.h"
#import "ArticlesTVC.h"
#import "RSSParser.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];

    UIView *categoryView = [[UIView alloc] init];
    [categoryView setFrame:CGRectMake(60,0, 100,-200)];
    
    UIView *articlesView = [[UIView alloc] init];
    [articlesView setFrame:CGRectMake(0,50, 400,400)];
    
    CatBarTVC *categoryBar = [[CatBarTVC alloc] initWithStyle:UITableViewStylePlain];
    categoryBar.view.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    categoryBar.view.autoresizesSubviews=NO;
   
    dvc = [[DetailViewController alloc]init];
    
    _articles = [[ArticlesTVC alloc] initWithStyle:UITableViewStylePlain];
    
    [articlesView addSubview:_articles.view];
    //[self addChildViewController:articles];
    
    //[articlesView addSubview:articles.view];
    
    [self.view addSubview:categoryBar.view];
    [self.view addSubview:_articles.view];
    
    [self addChildViewController:categoryBar];
    [self addChildViewController:_articles];
    
    categoryBar.view.frame =CGRectMake(0,0, 500,70);
    _articles.view.frame =CGRectMake(0,50, 400,400);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"kNotificationKey_reloadArticlesTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToDetailView:) name:@"kNotificationKey_articleSelected" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"kNotificationKey_loadDetailView" object:nil];


}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)switchToDetailView:(UIViewController *)viewController
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:dvc.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadTableView{
    [_articles.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]withRowAnimation:UITableViewRowAnimationAutomatic];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
