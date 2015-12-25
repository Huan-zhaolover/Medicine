//
//  FenleiDataHelper.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "FenleiDataHelper.h"
#import "MovieModel.h"
#import "AFNetworking.h"

@interface FenleiDataHelper()

@property (nonatomic,strong)NSMutableArray *FoodArray;
@property (nonatomic,strong)NSMutableArray *MiaozhaoArry;
@property (nonatomic,strong)NSMutableArray *NannvArry;

@property (nonatomic,assign)NSInteger foodShuaxinCount;
@property (nonatomic,assign)NSInteger miaoShuaxinCount;
@property (nonatomic,assign)NSInteger nanvuShuaxinCount;



@property (nonatomic,strong)AFHTTPRequestOperationManager *manger;


@end

@implementation FenleiDataHelper

-(AFHTTPRequestOperationManager *)manger{
    if (!_manger) {
        _manger=[AFHTTPRequestOperationManager manager ];
    }
    return _manger;
}

#pragma mark food ， miaozhao ,nannv 三栏的懒加载

-(NSMutableArray *)FoodArray{
    if (!_FoodArray) {
        _FoodArray=[NSMutableArray array];
    }
    return _FoodArray;
}

-(NSMutableArray *)MiaozhaoArry{
    if (!_MiaozhaoArry) {
        _MiaozhaoArry=[NSMutableArray array];
    }
    return _MiaozhaoArry;
}
-(NSMutableArray *)NannvArry{
    if (!_NannvArry) {
        _NannvArry=[NSMutableArray array];
    }
    return _NannvArry;
}

#pragma mark 单例方法


+(instancetype)shareFenleiData{
    static FenleiDataHelper *handele=nil;
    static   dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!handele) {
            handele=[[FenleiDataHelper alloc]init];
        }
        [handele seririzationfood];
        [handele seririzationmiaozhao];
        [handele seririzationnannv];
        
        handele.foodShuaxinCount=1;
        handele.miaoShuaxinCount=1;
        handele.nanvuShuaxinCount=1;
        
        
        
    });
    return handele;

}
-(void)seririzationfood{
    NSString *urlString=@"http://www.ihealth365.com:85/popumed_mobi/pmci/mobile_online/?page=1&sub_channel=xinzhi";
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.FoodArray addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];
}
-(void)seririzationmiaozhao{
    
    NSString *urlString=@"http://www.ihealth365.com:85/popumed_mobi/pmci/mobile_online/?page=1&sub_channel=miaozhao";
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.MiaozhaoArry addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];
    
}
-(void)seririzationnannv{
    NSString *urlString=@"http://www.ihealth365.com:85/popumed_mobi/pmci/mobile_online/?page=1&sub_channel=aijiankang";
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.NannvArry addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];

}

-(void)foodShuaxin{
    NSString *urlString=[NSString stringWithFormat:@"http://www.ihealth365.com:85/popumed_mobi/pmci/mobile_online/?page=%ld&sub_channel=xinzhi",++self.foodShuaxinCount]  ;
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.FoodArray addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];
    

}
-(void)miaoshuaxin{
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.ihealth365.com:85/popumed_mobi/pmci/mobile_online/?page=%ld&sub_channel=miaozhao",++self.miaoShuaxinCount];
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.MiaozhaoArry addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];

    
    

}
-(void)nannvshuaxin{
    
    NSString *urlString= [NSString stringWithFormat:@"http://www.ihealth365.com:85/popumed_mobi/pmci/mobile_online/?page=%ld&sub_channel=aijiankang",++self.nanvuShuaxinCount];
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.NannvArry addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];


}

-(MovieModel*)getFoodCellAtIndexPath:(NSIndexPath *)indexpath{
    MovieModel *m=self.FoodArray[indexpath.row];
    return m;
}
-(MovieModel*)getMiaozhaoCellAtIndexPath:(NSIndexPath *)indexpath{
    MovieModel *m=self.MiaozhaoArry[indexpath.row];
    return m;
}
-(MovieModel*)getNannvCellAtIndexPath:(NSIndexPath *)indexpath{
    MovieModel *m=self.NannvArry[indexpath.row];
    return m;
}
-(NSInteger)FoodListCount{
    return self.FoodArray.count;
}
-(NSInteger)MiaozhaoListCount{
    return self.MiaozhaoArry.count;
}
-(NSInteger)NannvListCount{
    return self.NannvArry.count;
}











@end
