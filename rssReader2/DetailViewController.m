//
//  DetailViewController.m
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/30.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id) initWithArticle:(Article *)article {
    self = [super init];
    
    if(self) {
        self.currentArticle = article;
        

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetail:) name:@"kNotificationKey_articleSelected" object:nil];

    UIScrollView *detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] applicationFrame].size.width,
                                                                              [[UIScreen mainScreen] applicationFrame].size.height)];

    //[detailView setFrame:CGRectMake(0,0, 800,400)];
    
    [self.view addSubview:detailView];
    detailView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);

  //  self.currentArticle.enclosure = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,48,48)];
    //self.currentArticle.enclosure
    
    self.enclosure = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,48,48)];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString: self.currentArticle.enclosure]];
    
    if (imgData) {
        UIImage *image = [UIImage imageWithData:imgData];
        if (image) {
            self.enclosure.image = image;
            self.enclosure.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);

            }
        }
    self.headingLabel = [[UILabel alloc] initWithFrame: CGRectMake (10,60,350,30)];
    self.headingLabel.textColor = [UIColor blackColor];
    self.headingLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    self.headingLabel.text = self.currentArticle.title;
    self.headingLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);

    
    
    self.dateLabel = [[UILabel alloc] initWithFrame: CGRectMake (12,65,350,50)];
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:8.0f];
    self.dateLabel.text = self.currentArticle.pubDate;
    
    self.articleDescription = [[UITextView alloc] initWithFrame: CGRectMake (9,100,150,500)];
    self.articleDescription.textColor = [UIColor blackColor];
    self.articleDescription.font = [UIFont fontWithName:@"Arial" size:10.0f];
    self.articleDescription.text = self.currentArticle.description;
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.currentArticle.link];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:(NSRange){0,[attributeString length]}];


    
    UIButton *linkButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [linkButton setFrame:CGRectMake(10, 160, 350, 100)];
   [linkButton setAttributedTitle:attributeString forState:UIControlStateNormal];
    linkButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
  [linkButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    
    [detailView addSubview:self.enclosure];
    [detailView addSubview:self.headingLabel];
    [detailView addSubview:self.dateLabel];
    [detailView addSubview:self.articleDescription];
    [detailView addSubview:linkButton];
    //[detailView addSubview:self.link];
    
    [linkButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    

}

-(void)buttonPressed:(id)sender{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.currentArticle.link]];

}



- (BOOL)shouldAutorotate {
    
    return YES;
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    NSLog (@"item: %@", item);
    //if you want to dismiss the controller presented, you can do that here or the method btnBackClicked
    
    return NO;
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
