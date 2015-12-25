//
//  FenleiDataHelper.h
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieModel;
@interface FenleiDataHelper : NSObject

@property (nonatomic,copy)void (^shuaxinBlock)();
@property (nonatomic,assign)NSInteger FoodListCount;
@property (nonatomic,assign)NSInteger MiaozhaoListCount;
@property (nonatomic,assign)NSInteger NannvListCount;


+(instancetype)shareFenleiData;

-(MovieModel*)getFoodCellAtIndexPath:(NSIndexPath *)indexpath;
-(MovieModel*)getMiaozhaoCellAtIndexPath:(NSIndexPath *)indexpath;
-(MovieModel*)getNannvCellAtIndexPath:(NSIndexPath *)indexpath;

-(void)foodShuaxin;
-(void)miaoshuaxin;
-(void)nannvshuaxin;


@end
