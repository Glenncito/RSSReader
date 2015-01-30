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
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetail:) name:@"kNotificationKey_articleSelected" object:story];

    UIScrollView *detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(100,150,400,600)];
    [detailView setFrame:CGRectMake(0,0, 800,400)];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 41)];
    navBar.delegate = self;
    UINavigationItem *backItem = [[UINavigationItem alloc] initWithTitle:@"< Back to archive"];
 //   UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(goHome:)];
    
   // self.navigationItem.backBarButtonItem = newBackButton;
   [navBar pushNavigationItem:backItem animated:NO];

    [self.view addSubview:navBar];
    [self.view addSubview:detailView];
  

    enclosure = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,48,48)];
/*
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:]];
    
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.enclosure.image = image;
                    [cell.enclosure setNeedsDisplay];
                });
            }
        }*/
    
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    NSLog (@"item: %@", item);
    //if you want to dismiss the controller presented, you can do that here or the method btnBackClicked
    
    return NO;
}
-(void) goHome:(UIBarButtonItem* )sender{
  
    NSLog (@"Sender is: %@", sender);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) showDetail:(NSNotification *)notification {
    
    NSArray *story = notification.object;
    NSLog (@"This is story: %@",story.description);
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
