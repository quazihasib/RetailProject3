//
//  UIViewController+CollectionController.h
//  RetailProject2
//
//  Created by Quazi Ridwan Hasib on 21/6/17.
//  Copyright © 2017 Quazi Ridwan Hasib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIDocumentInteractionControllerDelegate>

// PROPERTIES

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (strong, nonatomic) NSMutableArray *ary_images;
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end
