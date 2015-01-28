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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIVC = [[UIViewController alloc]init];
    
    UIView *categoryView = [[UIView alloc] init];
    [categoryView setFrame:CGRectMake(60,0, 100,-200)];
   // [categoryView setBackgroundColor: [ UIColor redColor]];
    
    /* UIView *marker= [[UIView alloc] init];
     marker setFrame:CGRectMake (0,205,400,5)];
     [marker setBackgroundColor:[UIColor blueColor]];
     */
    
    UIView *articlesView = [[UIView alloc] init];
    [articlesView setFrame:CGRectMake(0,50, 400,400)];
   // [articlesView setBackgroundColor: [ UIColor redColor]];
    
   
    
    CatBarTVC *categoryBar = [[CatBarTVC alloc] initWithStyle:UITableViewStylePlain];
    categoryBar.view.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    categoryBar.view.autoresizesSubviews=NO;
   
    
    
    
    ArticlesTVC *articles = [[ArticlesTVC alloc] initWithStyle:UITableViewStylePlain];
    [articlesView addSubview:articles.view];
    [self addChildViewController:articles];
    
    
    [self.view addSubview:categoryBar.view];
    [self.view addSubview:articles.view];
    
    [self addChildViewController:categoryBar];
    [self addChildViewController:articles];
    
    categoryBar.view.frame =CGRectMake(0,0, 500,70);
    articles.view.frame =CGRectMake(0,50, 400,400);
    
 //   NSNotification *notification = [NSNotification notificationWithName:@"newDataFetched" object:categoryBar];
   // [[NSNotificationCenter defaultCenter] postNotification:notification];

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
