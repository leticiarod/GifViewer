//
//  Giphy.m
//  GifViewer
//
//  Created by Leticia Rodriguez on 10/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

#import "Giphy.h"

@implementation Giphy

+ (instancetype) giphyWithDictionary:(NSDictionary *) dictionary {
    Giphy *giphy = [[Giphy alloc] init];
    
    if (giphy){
        giphy.animatedGifURL = [NSURL URLWithString:[dictionary valueForKeyPath:@"images.original.url"]];
        giphy.stillImageURL = [NSURL URLWithString:[dictionary valueForKeyPath:@"images.downsized_still.url"]];
    }
    
    return giphy;
}

@end
