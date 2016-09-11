//
//  adressViewCell.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/13.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adressViewCell : UITableViewCell
@property (nonatomic , strong) UIButton *editButton;
- (void)setContentWithObject:(NSArray *)object AtIndexPath:(NSIndexPath *)indexPath;

@end
