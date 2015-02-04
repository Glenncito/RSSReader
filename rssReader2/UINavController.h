//
//  UINav.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/02/04.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavController : UINavigationController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
-(BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;


@property (nonatomic, retain) UINavigationController *navigationController;

@end
