//
//  newsCell.h
//  medicine
//
//  Created by Yutao on 15/11/23.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class newsModel;
@interface newsCell : UITableViewCell
@property (nonatomic,strong)newsModel *newsmodel;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLable;

+(CGFloat)getHigh;
@end
