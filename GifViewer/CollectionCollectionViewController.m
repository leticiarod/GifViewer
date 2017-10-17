//
//  CollectionCollectionViewController.m
//  GifViewer
//
//  Created by Leticia Rodriguez on 10/16/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

#import "CollectionCollectionViewController.h"
#import "CollectionViewCell.h"
#import "Giphy.h"
#import "DetailViewController.h"

@interface CollectionCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *giphys;

@end

@implementation CollectionCollectionViewController

static NSString * const reuseIdentifier = @"GifViewerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshImage];
}

-(void)refreshImage{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.giphy.com/v1/gifs/trending?api_key=1qoZCKGR8a0BNzz5vvkuw6ZAZB00Mxor&limit=25&ratingPG"];
    
    self.giphys = [NSMutableArray array];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
    // location is where our data is stored.
    completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSString *responseText = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        
        NSData * data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"Response dictionary: %@", dictionary);
        
        // data array > images > downsized_still > url
        
      //  self.imageURLs = [dictionary valueForKeyPath:@"data.images.downsized_still.url"];
      //  NSLog(@"Response imageURLS: %@", self.imageURLs);
        
        NSArray *dictionaries = [dictionary valueForKey:@"data"];
        
        for (NSDictionary *dict in dictionaries){
            Giphy *giphy = [Giphy giphyWithDictionary:dict];
            [self.giphys addObject:giphy];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    
    [task resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]){
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        Giphy *giphy = self.giphys[selectedIndexPath.row];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.giphy = giphy;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return [self.giphys count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
   // NSString *urlString = self.imageURLs[indexPath.row];
   // NSURL *url = [NSURL URLWithString:urlString];
   // NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    
   // cell.urlString = urlString;
    
   // cell.imageView.image = [UIImage imageWithData:imageData];
   
    Giphy *giphy = [self.giphys objectAtIndex:indexPath.row];
    cell.giphy = giphy;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
