//
//  DetailViewController.h
//  GifViewer
//
//  Created by Leticia Rodriguez on 10/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Giphy;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Giphy *giphy;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (NSString*)formatTips:(NSArray*)tipsArray;

@end
