//
//  dataHandeler.m
//  medicine
//
//  Created by Yutao on 15/11/26.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "dataHandeler.h"
#import "Zixun.h"
#import "Fenlei.h"
#import "Shipin.h"
#import "Yinpin.h"

#import "AppDelegate.h"

@interface dataHandeler()

@property (nonatomic,strong)NSMutableArray *zixundata;
@property (nonatomic,strong)NSMutableArray *fenleidata;
@property (nonatomic,strong)NSMutableArray *yinpindata;
@property (nonatomic,strong)NSMutableArray *shipindata;

@property (nonatomic,assign)BOOL flag;

@end

@implementation dataHandeler
+(instancetype)sharedataBase{
    static dataHandeler *handeler=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!handeler) {
            handeler=[[dataHandeler alloc]init];
            handeler.flag=NO;
        }
        
    });
    return handeler;
}

-(NSMutableArray *)zixundata{
    if (!_zixundata) {
        _zixundata=[NSMutableArray array];
    }
    return _zixundata;
}
-(NSMutableArray *)fenleidata{
    if (!_fenleidata) {
        _fenleidata=[NSMutableArray array];
    }
    return _fenleidata;
}
-(NSMutableArray *)yinpindata{
    if (!_yinpindata) {
        _yinpindata=[NSMutableArray array];
    }
    return _yinpindata;
}
-(NSMutableArray *)shipindata{
    if (!_shipindata) {
        _shipindata=[NSMutableArray array];
    }
    return _shipindata;
}

-(NSArray *)selectZixumodel{
    [self quchumoxing];
    return self.zixundata;

}
-(NSArray *)selectFenleimodel{
    [self quchumoxing];
    return self.fenleidata;

}
-(NSArray *)selectYinpinmodel{
    [self quchumoxing];
    return self.yinpindata;

}
-(NSArray *)selectShipinmodel{
    [self quchumoxing];

    return self.shipindata;

}
-(void)quchumoxing{
    
    AppDelegate *appdele=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=appdele.managedObjectContext;
    //1.创建一个描述
    NSEntityDescription *zixuDescri=[NSEntityDescription entityForName:@"Zixun" inManagedObjectContext:context];
    NSEntityDescription *fenleiDescri=[NSEntityDescription entityForName:@"Fenlei" inManagedObjectContext:context];
    NSEntityDescription *yinpinDescri=[NSEntityDescription entityForName:@"Yinpin" inManagedObjectContext:context];
    NSEntityDescription *shipinDescri=[NSEntityDescription entityForName:@"Shipin" inManagedObjectContext:context];
    
    
    NSFetchRequest *fetchrequst=[NSFetchRequest fetchRequestWithEntityName:@"Zixun"];
    [fetchrequst setEntity:zixuDescri];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    [fetchrequst setSortDescriptors:@[sort]];
    NSError *erron=nil;
    self.zixundata=[context executeFetchRequest:fetchrequst error:&erron].mutableCopy;
    
    
    
    NSFetchRequest *fetchrequst1=[NSFetchRequest fetchRequestWithEntityName:@"Fenlei"];
    [fetchrequst1 setEntity:fenleiDescri];
    [fetchrequst1 setSortDescriptors:@[sort]];
    self.fenleidata=[context executeFetchRequest:fetchrequst1 error:&erron].mutableCopy;
    
    NSFetchRequest *fetchrequst2=[NSFetchRequest fetchRequestWithEntityName:@"Yinpin"];
    [fetchrequst2 setEntity:yinpinDescri];
    [fetchrequst2 setSortDescriptors:@[sort]];
    self.yinpindata=[context executeFetchRequest:fetchrequst2 error:&erron].mutableCopy;
    
    
    NSFetchRequest *fetchrequst3=[NSFetchRequest fetchRequestWithEntityName:@"Shipin"];
    [fetchrequst3 setEntity:shipinDescri];
    [fetchrequst3 setSortDescriptors:@[sort]];
    self.shipindata=[context executeFetchRequest:fetchrequst3 error:&erron].mutableCopy;
    
}

-(BOOL )isExitsTitle:(NSString *)title{
    
    
    [self quchumoxing];
    for (Zixun *zixun in self.zixundata) {
        if ([zixun.title isEqualToString:title]) {
            return YES;
        }
    }
    for (Fenlei *fenle in self.fenleidata) {
        if ([fenle.title isEqualToString:title]) {
            return YES;
        }
    }

    for (Shipin *ship in self.shipindata) {
        if ([ship.title isEqualToString:title]) {
           return YES;
        }
    }
    for (Yinpin *yinp in self.yinpindata) {
        if ([yinp.title isEqualToString:title]) {
            return YES;
        }
    }
    
    return NO;
}

-(void)saveModelWithname:(NSString *)tableName andtitle:(NSString *)title andUrl:(NSString *)url{
    if ([self isExitsTitle:title]) {
        NSLog(@"已经存在");
        [_delegate tishi ];
    }
    else{
    
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=appdelegate.managedObjectContext;
    NSEntityDescription *zixundescri=[NSEntityDescription entityForName:@"Zixun" inManagedObjectContext:context];
    NSEntityDescription *fenleidescri=[NSEntityDescription entityForName:@"Fenlei" inManagedObjectContext:context];
    NSEntityDescription *shipindescri=[NSEntityDescription entityForName:@"Shipin" inManagedObjectContext:context];
    NSEntityDescription *yinpindescri=[NSEntityDescription entityForName:@"Yinpin" inManagedObjectContext:context];
    
    Zixun *somezixun=[[Zixun alloc]initWithEntity:zixundescri insertIntoManagedObjectContext:context];
    
    Fenlei *somefenlei=[[Fenlei alloc]initWithEntity:fenleidescri insertIntoManagedObjectContext:context];
    
    Shipin *someshipin=[[Shipin alloc]initWithEntity:shipindescri insertIntoManagedObjectContext:context];
    
    Yinpin *someyinpin=[[Yinpin alloc]initWithEntity:yinpindescri insertIntoManagedObjectContext:context];
    
    if ([tableName isEqualToString:@"视频列表"]) {
        someshipin.title=title;
        someshipin.url=url;
    }
    if ([tableName isEqualToString:@"音频列表"]) {
        someyinpin.title=title;
        someyinpin.url=url;
    }
    if ([tableName isEqualToString:@"资讯"]) {
        somezixun.title= title;
        somezixun.url= url;
    }
    if ([tableName isEqualToString:@"分类"]) {
        somefenlei.title= title;
        somefenlei.url=url;
    }
    
    [context save:nil];
    NSLog(@"没有，进行存储");
    
}

}

-(void)delectAlldataBytatleName:(NSString *)tableName{

    AppDelegate *appdele=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context=appdele.managedObjectContext;
    //1.创建一个描述
    NSEntityDescription *zixuDescri=[NSEntityDescription entityForName:@"Zixun" inManagedObjectContext:context];
    NSEntityDescription *fenleiDescri=[NSEntityDescription entityForName:@"Fenlei" inManagedObjectContext:context];
    NSEntityDescription *yinpinDescri=[NSEntityDescription entityForName:@"Yinpin" inManagedObjectContext:context];
    NSEntityDescription *shipinDescri=[NSEntityDescription entityForName:@"Shipin" inManagedObjectContext:context];
    
    
    NSFetchRequest *fetchrequst=[NSFetchRequest fetchRequestWithEntityName:@"Zixun"];
    [fetchrequst setEntity:zixuDescri];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    [fetchrequst setSortDescriptors:@[sort]];
    NSError *erron=nil;
    self.zixundata=[context executeFetchRequest:fetchrequst error:&erron].mutableCopy;
    
    NSFetchRequest *fetchrequst1=[NSFetchRequest fetchRequestWithEntityName:@"Fenlei"];
    [fetchrequst1 setEntity:fenleiDescri];
    [fetchrequst1 setSortDescriptors:@[sort]];
    self.fenleidata=[context executeFetchRequest:fetchrequst1 error:&erron].mutableCopy;
    
    NSFetchRequest *fetchrequst2=[NSFetchRequest fetchRequestWithEntityName:@"Yinpin"];
    [fetchrequst2 setEntity:yinpinDescri];
    [fetchrequst2 setSortDescriptors:@[sort]];
    self.yinpindata=[context executeFetchRequest:fetchrequst2 error:&erron].mutableCopy;
    
    
    NSFetchRequest *fetchrequst3=[NSFetchRequest fetchRequestWithEntityName:@"Shipin"];
    [fetchrequst3 setEntity:shipinDescri];
    [fetchrequst3 setSortDescriptors:@[sort]];
    self.shipindata=[context executeFetchRequest:fetchrequst3 error:&erron].mutableCopy;
    
   
    
    if ([tableName isEqualToString:@"视频列表"]) {
        for (Shipin *shipin in self.shipindata) {
            [context deleteObject:shipin];
        }
    }
    if ([tableName isEqualToString:@"音频列表"]) {
        for (Yinpin *yinpin in self.yinpindata) {
            [context deleteObject:yinpin];
        }
    }
    if ([tableName isEqualToString:@"资讯"]) {
        for (Zixun *zixun in self.zixundata) {
            [context deleteObject:zixun];
        }
    }
    if ([tableName isEqualToString:@"分类"]) {
        for (Fenlei *fenlei in self.fenleidata) {
            [context deleteObject:fenlei];
        }
    }
    
    [context save:nil];
    
    
    


}



@end
