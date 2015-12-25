//
//  NewsHandler.m
//  medicine
//
//  Created by Yutao on 15/11/23.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "NewsHandler.h"
#import "newsModel.h"
#import "AFNetworking.h"
@interface NewsHandler()
@property (nonatomic,assign)NSInteger shuxinCount;
@property (nonatomic,strong)AFHTTPRequestOperationManager *manger;

@end
@implementation NewsHandler

+(instancetype)shareNewData{
    static NewsHandler *handeler=nil;
    static dispatch_once_t once;
    if (!handeler) {
        dispatch_once(&once, ^{
            
            handeler=[[NewsHandler alloc]init];
            [handeler serilizationData];
            handeler.shuxinCount=1;
        });
    }
    return handeler;
}

-(NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry=[NSMutableArray array];
    }
    return _dataArry;
}
-(AFHTTPRequestOperationManager *)manger{
    if (!_manger) {
        _manger=[AFHTTPRequestOperationManager manager];
    }
    return _manger;
}


-(void)serilizationData{

    
   self. manger.responseSerializer=[AFHTTPResponseSerializer serializer ];
    NSString *urlstring=@"http://api.medlive.cn/cms/get_list_info.php?limit=20&start=0&cat=news";
    [self. manger GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData *data=operation.responseData;
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      //  NSLog(@"%@",dic);
        
        NSArray *temparry=dic[@"data_list"];
        for (NSDictionary *dic2 in temparry) {
            newsModel *model=[[newsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic2];
            [self.dataArry addObject:model];
           
        }
        if (self.huidiaoBlock) {
                self.huidiaoBlock();
        }
   
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}

-(void )infinteData{
  
    NSLog(@"开始%ld\n,第%ld次刷新",self.dataArry.count,self.shuxinCount);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer ];
    NSString *urlstring= [NSString stringWithFormat:@"http://api.medlive.cn/cms/get_list_info.php?limit=%ld&start=0&cat=news",++self.shuxinCount*20];
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSData *data=operation.responseData;
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [self.dataArry removeAllObjects];

        NSArray *temparry=dic[@"data_list"];
        for (NSDictionary *dic2 in temparry) {
            newsModel *model=[[newsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic2];
            [self.dataArry addObject:model];
            
        }
        if (self.huidiaoBlock) {
            self.huidiaoBlock();
        }
        NSLog(@"结束%ld",self.dataArry.count);

       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);

    }];
    NSLog(@"hahh");
}


-(newsModel *)getModelAtIndexPath:(NSIndexPath *)indexpath{
    newsModel *model=self.dataArry[indexpath.row];
    
    return model;
}
-(NSInteger)count{
        return self.dataArry.count;
}

@end
