//
//  newznHandeler.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "newznHandeler.h"
#import "AFNetworking.h"
#import "newsznModel.h"
@interface newznHandeler()

@property (nonatomic,strong)NSMutableArray *zndataArrary;

@property (nonatomic,assign)NSInteger shuxinCount;

@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end

@implementation newznHandeler
+(instancetype)shareZNdata{
    static newznHandeler *handler=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!handler) {
            handler=[[newznHandeler alloc]init];
            [handler serizalization];
            handler.shuxinCount=1;
        }
        
    });
    return handler;
}
-(NSMutableArray *)zndataArrary{
    if (!_zndataArrary) {
        _zndataArrary=[NSMutableArray array];
    }
    return _zndataArrary;
}
-(AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager=[AFHTTPRequestOperationManager manager];
    }
    return _manager;
}


-(void)serizalization{
  
    NSString *urlstring=@"http://www.dxy.cn/webservices/article/latest/v3.3?limit=40&pge=0&mc=ffffffff811ac52affffffff9bdea126";
    [ self.manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData *data=operation.responseData;
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic2= dic[@"message"];
        NSArray *arry=dic2[@"list"];
        for (NSDictionary *dic1 in arry) {
            newsznModel *model=[[newsznModel alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.zndataArrary addObject:model];
  
        }
        
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
-(void)xialashuxin{

    NSString *urlstring= [NSString stringWithFormat:@"http://www.dxy.cn/webservices/article/latest/v3.3?limit=40&pge=%ld&mc=ffffffff811ac52affffffff9bdea126",++self.shuxinCount];
    
    [self.manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData *data=operation.responseData;
     
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic2= dic[@"message"];
        NSArray *arry=dic2[@"list"];
        
        
        for (NSDictionary *dic1 in arry) {
            newsznModel *model=[[newsznModel alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.zndataArrary addObject:model];
         
        }
        
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}


-(NSInteger)count{
    return self.zndataArrary.count;

}
-(newsznModel *)getZNmodelAtIndexPath:(NSIndexPath *)indexpath{
    newsznModel *model=self.zndataArrary[indexpath.row];
    return model;
}
@end
