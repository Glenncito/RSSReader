//
//  DetailViewController.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/30.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "DetailViewController.h"
#import "Article.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetail:) name:@"kNotificationKey_articleSelected" object:nil];
    
    UIView *detailView = [[UIView alloc] init];
    [detailView setFrame:CGRectMake(0,0, 800,400)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) showDetail:(NSNotification *)notification {
    self.story = notification.object;
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
