//
//  AppDelegate.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/18.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
//#import "TableViewController.h"
#import "UINavController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) UINavController *navigationController;

@end

