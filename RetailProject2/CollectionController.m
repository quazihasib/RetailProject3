//
//  UIViewController+CollectionController.m
//  RetailProject2
//
//  Created by Quazi Ridwan Hasib on 21/6/17.
//  Copyright © 2017 Quazi Ridwan Hasib. All rights reserved.
//

#import "CollectionController.h"
#import "CustomHeader.h"
#import "CustomCell.h"
#import "ImageRecord.h"
#import "ImageCache.h"

static NSString * const kCellReuseIdentifier = @"cell";
NSMutableArray *listURLs, *listLabels, *listURLs1, *listImages ;

@implementation CollectionController : UIViewController

@synthesize imageDownloadsInProgress;
@synthesize ary_images;

NSArray *keys;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    keys = [self getData:@"keys"];
    //NSLog(@"keys:%@",keys);
    
    NSDictionary *json = [self getDictonary:@"json"];
    //NSLog(@"json:%@",json);
    
//    NSMutableArray *tableLists = [NSMutableArray array];
//    NSMutableArray *imageLists = [NSMutableArray array];
//       
//   
//    for(int i=0;i<[keys count];i++)
//    {
//        //NSLog(@"keys:%@",keys[i]);
//        tableLists[i] = [json valueForKey:keys[i]];
//        imageLists[i] = [tableLists[i] valueForKey:@"image"];
//        
//        for (int j=0; j<[imageLists[i] count]; j++)
//        {
//            ImageRecord *objs = [[ImageRecord alloc] init];
//            objs.imageURL = [imageLists[i] objectAtIndex:j];
//        }
//        //NSLog(@"urlLists:%@",urlLists);
//    }

    listURLs = [NSMutableArray array];
    NSMutableArray *tableData,* imageUrl, *tableData1,*imageUrl1;
    tableData = [[NSMutableArray alloc]init];
    imageUrl = [[NSMutableArray alloc]init];
    
    tableData1 = [[NSMutableArray alloc]init];
    imageUrl1 = [[NSMutableArray alloc]init];
    listURLs1 = [[NSMutableArray alloc] init];
    listLabels = [[NSMutableArray alloc]init];
    listImages = [[NSMutableArray alloc]init];
    
    for(int y=0;y<[keys count]; y++)
    {
        [tableData1 insertObject:[json valueForKey:keys[y]] atIndex:y];
    }
    
    for(int u=0;u<[keys count]; u++)
    {
        [imageUrl1 insertObject:[[tableData1 objectAtIndex:u] valueForKey:@"image"] atIndex:u];
        [listLabels insertObject:[[tableData1 objectAtIndex:u] valueForKey:@"field1"] atIndex:u];
    }
    
    
    //NSLog(@"tableData1:%@",tableData1);
    listURLs1 = imageUrl1;
    NSLog(@"listURLs1:%@",listURLs1);
    //NSLog(@"listLabels:%@",listLabels);
    
    /*
    for(int i=0;i<[listURLs1 count];i++)
    {
        for(int j=0;j<[listURLs1[i] count];j++)
        {
            NSLog(@"i:%d,j:%d, aaa:%@",i,j,[[listURLs1 objectAtIndex:i]objectAtIndex:j]);
            ImageRecord *objs = [[ImageRecord alloc] init];
            objs.imageURL = [[listURLs1 objectAtIndex:i]objectAtIndex:j];
            //NSLog(@"hh:%@",objs.imageURL);
            [[listImages ins]]
        }
    }
    */
    
//    for(int j=0;j<[keys count];j++)
//    {
//        for(int k=0;k<[[imageUrl1 objectAtIndex:j] count];k++)
//        {
//            ImageRecord *objs = [[ImageRecord alloc] init];
//            objs.imageURL = [[imageUrl1 objectAtIndex:j]objectAtIndex:k];
//            NSLog(@"objs.imageURL:%@",objs.imageURL);
//            [listURLs1 addObject:objs.imageURL];
//            //NSLog(@"i:%@i");
//        }
//    }
    
    //NSLog(@"m:%@",m);
    //NSLog(@"listURLs1:%@",listURLs1);
    /*
    tableData = [json valueForKey:keys[0]];
    //NSLog(@"tableData:%@",tableData);
    imageUrl=[tableData valueForKey:@"image"];
    //NSLog(@"imageUrl:%@",imageUrl);
    
    for (int cnt=0; cnt<[imageUrl count]; cnt++)
    {
        ImageRecord *objs = [[ImageRecord alloc] init];
        objs.imageURL = [imageUrl objectAtIndex:cnt];
        //NSLog(@"objs:%@",objs.imageURL);
        [listURLs addObject:objs];
    }
    //NSLog(@"listURLs:%@",listURLs);
    */
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = [NSString stringWithFormat:@"Lazy Loading UICollectionView - %lu Images",(unsigned long)listURLs1.count];
    [self emptyDocumentsDir];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // If memory warning is issued, then we can clear the objects to free some memory. Here we are simply removing all the images. But we can use a bit more logic to handle the memory here.
    [self.imageDownloadsInProgress removeAllObjects];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return [keys count];
}

-(NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger sectionItems = 0;
    
    for(int i=0;i<[keys count];i++)
    {
        if(section==i)
        {
            sectionItems =  [[listURLs1 objectAtIndex:i] count];
        }
        //NSLog(@"sctionItems:%ld",(long)sectionItems);
    }
    
    return sectionItems;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CustomHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    if (indexPath.section ==0) {
        header.collectionHeader.text = [NSString stringWithFormat:@"Section 0"];
    }
    else if (indexPath.section ==1) {
        header.collectionHeader.text = [NSString stringWithFormat:@"Section 1"];
    }
    else if (indexPath.section ==2) {
        header.collectionHeader.text = [NSString stringWithFormat:@"Section 2"];
    }
    return header;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSLog(@"[listLabels count]:%ld",[listLabels count]);
    
    for(int u=0;u<[listLabels count];u++)
    {
        if(indexPath.section==u)
        {
            //NSLog(@"[listLabels count]0:%ld",[[listLabels objectAtIndex:0] count]);
            for(int i=0;i<[[listLabels objectAtIndex:u] count];i++)
            {
                if(indexPath.item==i)
                {
                    //NSLog(@"[listLabels]:%@",[[listLabels objectAtIndex:0]objectAtIndex:i]);
                    cell.cellLabel.text = [[listLabels objectAtIndex:u]objectAtIndex:i];
                    
                    
                    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[cell.cellImage viewWithTag:505];
                    
                    if ([[ImageCache sharedImageCache] DoesExist:[[listURLs1 objectAtIndex:u]objectAtIndex:i]] == true){
                        [activityIndicator stopAnimating];
                        [activityIndicator removeFromSuperview];
                        
                        cell.cellImage.image = [[ImageCache sharedImageCache] GetImage:[[listURLs1 objectAtIndex:u]objectAtIndex:i]];
                    }
                    else{
                        // Add activity indicator
                        if (activityIndicator) [activityIndicator removeFromSuperview];
                        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                        activityIndicator.hidesWhenStopped = YES;
                        activityIndicator.hidden = NO;
                        [activityIndicator startAnimating];
                        activityIndicator.center = cell.cellImage.center;
                        activityIndicator.tag = 505;
                        [cell.cellImage addSubview:activityIndicator];
                        
                     
                        // Only load cached images; defer new downloads until scrolling ends
                        //if (!imgRecord.thumbImage){
                            //if (self.collection.dragging == NO && self.collection.decelerating == NO){
                            //[self startIconDownload:imgRecord forIndexPath:indexPath];
                            
                            NSURL *URL = [NSURL URLWithString:[[listURLs1 objectAtIndex:u]objectAtIndex:i]];
                            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                            
                            NSURLSession *session = [NSURLSession sharedSession];
                            NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                                    completionHandler:
                                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  
                                                                  [activityIndicator stopAnimating];
                                                                  [activityIndicator removeFromSuperview];
                                                                  
                                                                  cell.cellImage.image = [UIImage imageWithData:data];
                                                                  
                                                                  //cell.cellLabel.text = [listLabels objectAtIndex:indexPath.item];
                                                              });
                                                          }];
                            
                            [task resume];
                            //}
                            // if a download is deferred or in progress, return a placeholder image
                            cell.cellImage.image = [UIImage imageNamed:@"placeholder.png"];
//                        }
//                        else{
//                            cell.cellImage.image = [[listURLs1 objectAtIndex:u]objectAtIndex:i];
//                        }

                    }
                }
            }
        }
    }
    
    //NSLog(@"[[listURLs1 objectAtIndex:0] count]:%lu",(unsigned long)[[listURLs1 objectAtIndex:0] count]);
    /*
    for(int i=0;i<[[listURLs1 objectAtIndex:0] count];i++)
    {
        if(indexPath.section==i)
        {
            UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[cell.cellImage viewWithTag:505];
            
            // Set up the cell...
            // Fetch a image record from the array
            //ImageRecord *imgRecord = [listURLs objectAtIndex:indexPath.row];
            NSLog(@"imgggg:%@",[[listURLs1 objectAtIndex:0] objectAtIndex:indexPath.row]);
            ImageRecord *imgRecord=[[listURLs1 objectAtIndex:0] objectAtIndex:indexPath.row];
            //NSLog(@"imgRecord:%@",imgRecord);
            // Set thumbimage
            // Check if the image exists in cache. If it does exists in cache, directly fetch it and display it in the cell
            if ([[ImageCache sharedImageCache] DoesExist:imgRecord.imageURL] == true){
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
                
                cell.cellImage.image = [[ImageCache sharedImageCache] GetImage:imgRecord.imageURL];
            }
            else{
                // Add activity indicator
                if (activityIndicator) [activityIndicator removeFromSuperview];
                activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                activityIndicator.hidesWhenStopped = YES;
                activityIndicator.hidden = NO;
                [activityIndicator startAnimating];
                activityIndicator.center = cell.cellImage.center;
                activityIndicator.tag = 505;
                [cell.cellImage addSubview:activityIndicator];
                
                
                // Only load cached images; defer new downloads until scrolling ends
                if (!imgRecord.thumbImage){
                    //if (self.collection.dragging == NO && self.collection.decelerating == NO){
                    //[self startIconDownload:imgRecord forIndexPath:indexPath];
                    
                    NSURL *URL = [NSURL URLWithString:imgRecord.imageURL];
                    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                    
                    NSURLSession *session = [NSURLSession sharedSession];
                    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                            completionHandler:
                                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          [activityIndicator stopAnimating];
                                                          [activityIndicator removeFromSuperview];
                                                          
                                                          cell.cellImage.image = [UIImage imageWithData:data];
                                                          
                                                          cell.cellLabel.text = [listLabels objectAtIndex:indexPath.item];
                                                      });
                                                  }];
                    
                    [task resume];
                    //}
                    // if a download is deferred or in progress, return a placeholder image
                    cell.cellImage.image = [UIImage imageNamed:@"placeholder.png"];
                }
                else{
                    cell.cellImage.image = imgRecord.thumbImage;
                }
            }

        }
    }
    */
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSString *str = cell.cellLabel.text;
        NSLog(@"Text: %@ section no:%ld item no: %ld", str,  indexPath.section, indexPath.item);
    } else if(indexPath.section == 1){
        NSString *str = cell.cellLabel.text;
        NSLog(@"Text: %@ section no:%ld item no: %ld", str,  indexPath.section, indexPath.item);
    }
    else if(indexPath.section == 2){
        NSString *str = cell.cellLabel.text;
        NSLog(@"Text: %@ section no:%ld item no: %ld", str,  indexPath.section, indexPath.item);
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 90);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    //    if(IS_IPAD)
    //        return 20.0;
    //    else
    return 15.0;
    //return 0.0;
}


/////////////////////////////////////
//   UIDocumentInteractionController Delegate
/////////////////////////////////////
#pragma mark - UIDocumentInteractionController Delegate
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

/////////////////////////////////////
//   Documents Directory
/////////////////////////////////////
#pragma mark - Documents Directory
-(void)emptyDocumentsDir
{
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                }
            }
        } else {
            // Error
        }
    }
}

//get the saved user data using keys
-(NSArray*)getData:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *title = [defaults objectForKey:key];
    //NSArray *title1 = [title objectAtIndex:0];
    //NSLog(@"S:%@",[title objectAtIndex:0]);
    return title;
}

//get the saved dictonary data
-(NSDictionary*)getDictonary:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *title = [defaults objectForKey:key];
    //NSDictionary *title1 = [title objectAtIndex:0];
    //NSLog(@"S:%@",[title objectAtIndex:0]);
    return title;
}



@end
