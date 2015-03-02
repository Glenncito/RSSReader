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
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#import "RssCategory.h"
#import "Articles.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize pView;
@synthesize lView;

- (void)viewDidLoad {
    [super viewDidLoad];

    isShowingLandscapeView = NO;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
   [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

    

    
   /* //setup orientation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification"  object:nil];
    orientation = (UIDeviceOrientation)[[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown)
    {
        orientation = UIDeviceOrientationPortrait;
    }


        lView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    pView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    lView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.view.autoresizesSubviews = YES;
*/
    [self setNeedsStatusBarAppearanceUpdate];

   // NC = [[UINavigationController alloc] initWithRootViewController:self];
  //  UIView *categoryView = [[UIView alloc] init];
    //[categoryView setFrame:CGRectMake(60,0, 100,-200)];
    
    //UIView *articlesView = [[UIView alloc] init];
   // [articlesView setFrame:CGRectMake(0,50, 400,400)];
    [self initCoreCategoryEntity];
    categoryBar = [[CatBarTVC alloc] initWithStyle:UITableViewStylePlain];
    categoryBar.view.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    categoryBar.view.autoresizesSubviews=YES;
    
   
    
  //  [articlesView addSubview:_articles.view];
    //[self addChildViewController:articles];
    
    //[articlesView addSubview:articles.view];
    
  
    
    /*
    [lView addSubview:categoryBar.view];
    [lView addSubview:_articles.view];
    
    [pView addSubview:categoryBar.view];
    [pView addSubview:_articles.view];
     
     
     pView.autoresizesSubviews = YES;
     lView.autoresizesSubviews = YES;
   */
    
   [self.view addSubview:categoryBar.view];

    
    
    [self initUIElements];
    
 
    
    [self addChildViewController:categoryBar];
    
    categoryBar.view.frame =CGRectMake(0,0, 500,70);
   

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"kNotificationKey_reloadArticlesTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToDetailView:) name:@"kNotificationKey_articleSelected" object:nil];

  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"kNotificationKey_loadDetailView" object:nil];

   // NSDictionary *nameMap = @{@"categoryBar" : categoryBar,
    //                          @"articlesList" : articlesList};
    
    //imageView is 0 pts from superview at left and right edges
   /*  NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[articlesList]-0-|"
     options:0
     metrics:nil
     views:nameMap];
   */
    /*
     
     //imageview is 8 pots from dateLabel at its top edge...
     //... and 8 pots from toolbar at its bottom edge
     
     NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat: @"V:[dateLabel]-[imageView]-[toolbar]"
     options:0
     metrics:nil
     views:nameMap];
         [self.view addConstraints: verticalConstraints];
     
    [self.view addConstraints: horizontalConstraints];
*/

}

-(void)initUIElements{
    pView = [[UIView alloc]initWithFrame:CGRectMake(0,50, 768, 1024)];
      [self.view addSubview:pView];
     articlesList = [[ArticlesTVC alloc] initWithStyle:UITableViewStylePlain];
    articlesList.view.frame =CGRectMake(0,50, 400,400);
    [pView addSubview:articlesList.view];
    [self addChildViewController:articlesList];
    
}
/*
-(BOOL) shouldAutorotate
{
    return YES;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
 
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
 
    /*
    
    //setup orientation
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
    */
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(void) initCoreCategoryEntity{
    if([self coreDataHasEntriesForEntityName:@"RssCategory"]==NO){
     AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    RssCategory *category;
   
    //--Top Stories--//
    category = [NSEntityDescription
                insertNewObjectForEntityForName:@"RssCategory"
                inManagedObjectContext:context];
    
    category.name = @"Top Stories";
    category.rssUrl = @"http://feeds.news24.com/articles/news24/TopStories/rss";
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //--South Africa--//
    category = [NSEntityDescription
                insertNewObjectForEntityForName:@"RssCategory"
                inManagedObjectContext:context];
    
    category.name = @"South Africa";
    category.rssUrl = @"http://feeds.news24.com/articles/news24/SouthAfrica/rss";
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //--World--//
    category = [NSEntityDescription
                insertNewObjectForEntityForName:@"RssCategory"
                inManagedObjectContext:context];
    
    category.name = @"World";
    category.rssUrl = @"http://feeds.news24.com/articles/news24/World/rss";
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    //--Sport--//
    category = [NSEntityDescription
                insertNewObjectForEntityForName:@"RssCategory"
                inManagedObjectContext:context];
    
    category.name = @"Tech";
    category.rssUrl = @"http://feeds.news24.com/articles/fin24/tech/rss";
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    
    //--Business--//
    category = [NSEntityDescription
                insertNewObjectForEntityForName:@"RssCategory"
                inManagedObjectContext:context];
    
    category.name = @"Business";
    category.rssUrl = @"http://feeds.news24.com/articles/fin24/news/rss";
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    }else{
        NSLog(@"Has entries");
    }
    

}

- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Fetch error: %@", error);
        abort();
    }
    if ([results count] == 0) {
        return NO;
    }
    return YES;
}


/*
-(void) saveData:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    NSManagedObject *newCategory;
    
    newCategory= [NSEntityDescription
              insertNewObjectForEntityForName:@"Category"
              inManagedObjectContext:context];
    
    [newCategory setValue:@"Top Stories" forKey:@"name"];
    [newCategory setValue:@"http://feeds.news24.com/articles/news24/TopStories/rss" forKey:@"rssUrl"];
    
    NSError *error;
    [context save:&error];
    NSLog (@"category saved");
    
}

-(void) retrieveCategory:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Category"
                                                  inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",@"Top Stories"];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count]==0){
        NSLog (@"no matches");
    }else {
        matches = objects[0];
        NSLog (@"URL: %@",[matches valueForKey:@"rssUrl"]);
        NSLog (@"%lu matches found", (unsigned long)[objects count]);

    }
    
}
 */
/*
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
                
                
            }
            orientation = newOrientation;
        }
        
    }
}
*/
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


- (void)orientationChanged:(NSNotification *)notification

{
    /*
    
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

    }*/

}







/*

- (NSUInteger)supportedInterfaceOrientations

{

    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;

}


*/



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
    [articlesList.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]withRowAnimation:UITableViewRowAnimationAutomatic];
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
