//
//  Giphy.h
//  GifViewer
//
//  Created by Leticia Rodriguez on 10/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Giphy : NSObject

@property (nonatomic, strong) NSURL *stillImageURL;
@property (nonatomic, strong) NSURL *animatedGifURL;
+ (instancetype) giphyWithDictionary:(NSDictionary *) dictionary;

@end
