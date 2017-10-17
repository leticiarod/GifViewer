//
//  CollectionViewCell.h
//  GifViewer
//
//  Created by Leticia Rodriguez on 10/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Giphy;

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) Giphy *giphy;

@end
