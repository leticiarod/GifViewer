//
//  CollectionViewCell.m
//  GifViewer
//
//  Created by Leticia Rodriguez on 10/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Giphy.h"

@implementation CollectionViewCell

- (void) setGiphy:(Giphy *)giphy {
    _giphy = giphy;
    
    [self downloadImageWithURL:giphy.stillImageURL];
}

- (void)downloadImageWithURL:(NSURL*)url{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
       // NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image= [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // executes this line of code back on the main thread where we handle all the ui.
            self.imageView.image = image;
        });
        
    }];
    
    [task resume];
    
}

@end
