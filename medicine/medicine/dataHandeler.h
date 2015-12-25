//
//  dataHandeler.h
//  medicine
//
//  Created by Yutao on 15/11/26.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Zixun;
@class Fenlei;
@class Yinpin;
@class Shipin;

@protocol dataBaseDelegate <NSObject>

-(void)tishi;
@end


@interface dataHandeler : NSObject



+(instancetype)sharedataBase;

@property (nonatomic,weak)id <dataBaseDelegate> delegate;

-(NSArray *)selectZixumodel;
-(NSArray *)selectFenleimodel;
-(NSArray *)selectYinpinmodel;
-(NSArray *)selectShipinmodel;

-(BOOL )isExitsTitle:(NSString *)title;



-(void)saveModelWithname:(NSString *)tableName andtitle:(NSString *)title andUrl:(NSString *)url;


-(void)delectAlldataBytatleName:(NSString *)tableName;



@end
