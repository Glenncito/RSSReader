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
    
    UIVC = [[UIViewController alloc]init];
    
    UIView *categoryView = [[UIView alloc] init];
    [categoryView setFrame:CGRectMake(60,0, 100,-200)];
    
    UIView *articlesView = [[UIView alloc] init];
    [articlesView setFrame:CGRectMake(0,50, 400,400)];
    
    CatBarTVC *categoryBar = [[CatBarTVC alloc] initWithStyle:UITableViewStylePlain];
    categoryBar.view.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    categoryBar.view.autoresizesSubviews=NO;
   
    
    ArticlesTVC *articles = [[ArticlesTVC alloc] initWithStyle:UITableViewStylePlain];
    
    [articlesView addSubview:articles.view];
    //[self addChildViewController:articles];
    
    //[articlesView addSubview:articles.view];
    
    [self.view addSubview:categoryBar.view];
    [self.view addSubview:articles.view];
    
    [self addChildViewController:categoryBar];
    [self addChildViewController:articles];
    
    categoryBar.view.frame =CGRectMake(0,0, 500,70);
    articles.view.frame =CGRectMake(0,50, 400,400);
    
    


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
