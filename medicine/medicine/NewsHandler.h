//
//  NewsHandler.h
//  medicine
//
//  Created by Yutao on 15/11/23.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class newsModel;
@interface NewsHandler : NSObject

@property (nonatomic,copy)void (^huidiaoBlock)();
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,strong)NSMutableArray *dataArry;
 
+(instancetype)shareNewData;

-(newsModel *)getModelAtIndexPath:(NSIndexPath *)indexpath;

-(void)infinteData;


@end
