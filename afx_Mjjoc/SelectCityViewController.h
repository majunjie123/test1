//
//  SelectCityViewController.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/12.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCityName)(NSString *cityname);

@interface SelectCityViewController : UIViewController

@property (nonatomic, copy) ReturnCityName returnBlock;

- (void)returnText:(ReturnCityName)block;

@end
