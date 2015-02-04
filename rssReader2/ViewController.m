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

@synthesize pView;
@synthesize lView;

- (void)viewDidLoad {
    [super viewDidLoad];

 /*   isShowingLandscapeView = NO;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
   [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
*/
    //----- SETUP ORIENTATION -----
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification"  object:nil];
    orientation = (UIDeviceOrientation)[[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown)
    {
        orientation = UIDeviceOrientationPortrait;
    }


    pView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    lView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    
    [self setNeedsStatusBarAppearanceUpdate];

   // NC = [[UINavigationController alloc] initWithRootViewController:self];
    UIView *categoryView = [[UIView alloc] init];
    [categoryView setFrame:CGRectMake(60,0, 100,-200)];
    
    UIView *articlesView = [[UIView alloc] init];
    [articlesView setFrame:CGRectMake(0,50, 400,400)];
    
    CatBarTVC *categoryBar = [[CatBarTVC alloc] initWithStyle:UITableViewStylePlain];
    categoryBar.view.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    categoryBar.view.autoresizesSubviews=NO;
    
    _articles = [[ArticlesTVC alloc] initWithStyle:UITableViewStylePlain];
    
    [articlesView addSubview:_articles.view];
    //[self addChildViewController:articles];
    
    //[articlesView addSubview:articles.view];
    
    [pView addSubview:categoryBar.view];
    [pView addSubview:_articles.view];
    
    [lView addSubview:categoryBar.view];
    [lView addSubview:_articles.view];
    
    [self addChildViewController:categoryBar];
    [self addChildViewController:_articles];
    
    categoryBar.view.frame =CGRectMake(0,0, 500,70);
    _articles.view.frame =CGRectMake(0,50, 400,400);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"kNotificationKey_reloadArticlesTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToDetailView:) name:@"kNotificationKey_articleSelected" object:nil];

  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"kNotificationKey_loadDetailView" object:nil];



}




- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    //----- SETUP ORIENTATION -----
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification"  object:nil];
    //orientation = [[UIDevice currentDevice] orientation];
    orientation = (UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown)
    {
        orientation = UIDeviceOrientationPortrait;
    }
   
    if ((orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight))
    {

        [self clearCurrentView];
        [self.view insertSubview:lView atIndex:0];
    }
    else if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
    {
        // Clear the current view and insert the orientation specific view.
        [self clearCurrentView];
        [self.view insertSubview:pView atIndex:0];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


-(void)didRotate:(NSNotification *)notification
{
    
    UIDeviceOrientation newOrientation = [[UIDevice currentDevice] orientation];
    if (newOrientation != UIDeviceOrientationUnknown && newOrientation != UIDeviceOrientationFaceUp && newOrientation != UIDeviceOrientationFaceDown)
    {
        if (orientation != newOrientation)
        {
            
            NSLog(@"Changed Orientation");
            if (
                ((newOrientation == UIDeviceOrientationLandscapeLeft || newOrientation == UIDeviceOrientationLandscapeRight)) &&
                ((orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown))
                )
            {
                NSLog(@"Changed Orientation To Landscape");
                // Clear the current view and insert the orientation specific view.
                [self clearCurrentView];
                [self.view insertSubview:lView atIndex:0];
                
                //Copy object states between views
                //SomeTextControlL.text = SomeTextControlP.text;
            }
            else if (
                     ((newOrientation == UIDeviceOrientationPortrait || newOrientation == UIDeviceOrientationPortraitUpsideDown)) &&
                     ((orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight))
                     )
            {
                NSLog(@"Changed Orientation To Portrait");
                // Clear the current view and insert the orientation specific view.
                [self clearCurrentView];
                [self.view insertSubview:pView atIndex:0];
                
                //Copy object states between views
                //SomeTextControlP.text = SomeTextControlL.text;
            }
            orientation = newOrientation;
        }
        
    }
}

- (void) clearCurrentView
{
    if (lView.superview)
    {
        [lView removeFromSuperview];
    }
    else if (pView.superview)
    {
        [pView removeFromSuperview];
    }
}

/*
- (void)orientationChanged:(NSNotification *)notification

{
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationIsLandscape(deviceOrientation))
        
    {
  // _articles.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    //    _articles.view.autoresizesSubviews = YES;

        //[self performSegueWithIdentifier:@"DisplayAlternateView" sender:self];
        isShowingLandscapeView = YES;
    }
    
    else if (UIDeviceOrientationIsPortrait(deviceOrientation))
    {

        [self dismissViewControllerAnimated:YES completion:nil];
        
        isShowingLandscapeView = NO;

    }

} */






/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation

{
    
    if ((orientation == UIInterfaceOrientationPortrait) ||
        
        (orientation == UIInterfaceOrientationLandscapeLeft)){
          NSLog (@"%d", orientation);
        return YES;
      
    }
    
    
    return NO;

}*/



- (NSUInteger)supportedInterfaceOrientations

{

    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;

}
- (BOOL)shouldAutorotate {

    return YES;
}





- (void)switchToDetailView:(NSNotification *)notification
{
    Article *article = (Article *)notification.object;
    DetailViewController *detailVC = [[DetailViewController alloc]initWithArticle:article];
    [self.navigationController pushViewController:detailVC animated:YES];

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
