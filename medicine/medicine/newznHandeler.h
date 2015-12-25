//
//  newznHandeler.h
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class newsznModel;
@interface newznHandeler : NSObject

@property (nonatomic,copy)void (^shuaxinBlock)();

@property (nonatomic,assign)NSInteger count;


+(instancetype)shareZNdata;
-(newsznModel *)getZNmodelAtIndexPath:(NSIndexPath *)indexpath;
-(void)xialashuxin;

@end
