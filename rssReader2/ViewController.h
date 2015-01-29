//
//  ViewController.h
//  rssReader2
//
//  Created by Glenn Stein on 2015/01/21.
//  Copyright (c) 2015 Glenn Stein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>{
   
    UIViewController *UIVC;
        
}

@property (strong, nonatomic) UIViewController *UIVC;

+(void)action;

@end
