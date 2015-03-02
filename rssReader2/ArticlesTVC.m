//
//  ArticlesTVC.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "ArticlesTVC.h"
#import "RSSParser.h"
#import "ArticlesTableViewCell.h"
#import "article.h"
#import "DetailViewController.h"

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Articles.h"


@interface ArticlesTVC ()

@end

@implementation ArticlesTVC



#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myTableView = [[UITableView alloc] initWithFrame: CGRectMake(0,1,400,150)
                                                    style:UITableViewStylePlain];
    [myTableView setDataSource:self];
    [myTableView setDelegate:self];
    
    //fetch from core data here for offline capabilities
    // then parse
    //then update from core using fetched results controller
    
    
    parser = [RSSParser sharedRSSParser];
    
    self.articleList = [[NSMutableArray alloc]initWithArray:parser.articles];
 //  [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
    
    //NICK: Here we register to listen out for our "category selected" notifcation broadcast and tell our class what method to fire if we receive it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categorySelected:) name:@"kNotificationKey_categorySelected" object:nil];
    
    //NICK: Here we register for our parser to let us know when it is done so we can reload the tableview
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parsingComplete) name:@"kNotificationKey_XMLProcessingDone" object:nil];
   
}

-(void) viewWillAppear:(BOOL)animated{
    dispatch_async(kBgQueue, ^{
        [myTableView reloadData];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - -= Callbacks =-

//NICK: Method that gets fired when a category is received
- (void) categorySelected:(NSNotification *)notification {
       //Get our category string out of our notification object
    NSString *categoryName = notification.object;
    
    //Reload the parser using your method
    [parser reloadParser:categoryName];
    dispatch_async(dispatch_get_main_queue(), ^{
        [myTableView reloadData];
    });

    [self listArticles:categoryName];
    
    
}

-(void)listArticles:(NSString *)categoryName{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Articles"
                                              inManagedObjectContext:context];
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"categoryName = %@", categoryName];
    request.predicate = predicate;
    
    [request setEntity:entity];
    [request setFetchLimit:20];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    NSLog(@"*************************");
    for (Articles *info in fetchedObjects) {
      NSLog (@"--------\narticle name: %@\narticleCategory: %@", info.title,info.categoryName);
        [parser.articles addObject:info];
    }
    NSLog(@"*************************");
    [self parsingComplete];
}


// Method that gets fired when parsing is complete via NSNotification
- (void) parsingComplete {
    //Tell the tableview to animate the changes automatically

        self.articleList = [[NSMutableArray alloc]initWithArray:parser.articles];
  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationKey_reloadArticlesTable" object:nil];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.articleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static  NSString *CellIdentifier = @"Cell";
    ArticlesTableViewCell *cell = (ArticlesTableViewCell *)[myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (!cell){
     cell = [[ArticlesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
          }

    dispatch_async(kBgQueue, ^{
          NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.articleList valueForKey:@"enclosure"] objectAtIndex:indexPath.row]]];

               if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                        cell.enclosure.image = image;
                    [cell.enclosure setNeedsDisplay];
                });
            }
        }
    });
    
 /*   dispatch_async(dispatch_get_main_queue(), ^{
       [cell.dateLabel setText:[[self.articleList valueForKey:@"pubDate"] objectAtIndex:indexPath.row]];
        
        [cell.headingTextView setText:[[self.articleList valueForKey:@"title"] objectAtIndex:indexPath.row]];
        //NSLog(@"title is: %@", [[self.articleList valueForKey:@"title"] objectAtIndex:indexPath.row]);
  
        [cell setNeedsLayout];
    });*/
    
    Article *article = (Article *)[self.articleList objectAtIndex:indexPath.row];
    [cell configureForArticle:article];

    [cell setNeedsDisplay];

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Article *selectedArticle = (Article *)[self.articleList objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationKey_articleSelected" object:selectedArticle];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
