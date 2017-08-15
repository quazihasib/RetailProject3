//
//  UICollectionViewCell+CustomCell.h
//  RetailProject2
//
//  Created by Quazi Ridwan Hasib on 21/6/17.
//  Copyright © 2017 Quazi Ridwan Hasib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@end
