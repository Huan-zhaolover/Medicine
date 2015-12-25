//
//  MediaHandeler.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "MediaHandeler.h"
#import "MovieModel.h"
#import "AFNetworking.h"



@interface MediaHandeler()

@property (nonatomic,strong)NSMutableArray *movieArray;
@property (nonatomic,strong)NSMutableArray *voiceArry;

@property (nonatomic,assign)NSInteger movieshucount;
@property (nonatomic,assign)NSInteger voiceshucount;

@property (nonatomic,strong)AFHTTPRequestOperationManager *manger;


@end

@implementation MediaHandeler

-(AFHTTPRequestOperationManager *)manger{
    if (!_manger) {
        _manger=[AFHTTPRequestOperationManager manager ];
    }
    return _manger;
}

#pragma mark 音频，视频懒加载

-(NSMutableArray *)movieArray{
    if (!_movieArray) {
        _movieArray=[NSMutableArray array];
    }
    return _movieArray;
}

-(NSMutableArray *)voiceArry{
    if (!_voiceArry) {
        _voiceArry=[NSMutableArray array];
    }
    return _voiceArry;
}
#pragma mark 单例方法

+(instancetype)shareMovieData{
    static MediaHandeler *handele=nil;
    static   dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!handele) {
            handele=[[MediaHandeler alloc]init];
        }
        
        [handele serirization];
        [handele seririzationVoice];
        handele.movieshucount=1;
        handele.voiceshucount=1;
        
        
        
    });
    return handele;
}





#pragma mark 解析视频数据

-(void)serirization{
    
  NSString *urlString=@"http://www.ihealth365.com:85/popumed_mobi/pmci/multimedia/?tuijian=n&page=1&type=shipin";
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
  [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

      NSArray *arry=responseObject[@"result"];
      for (NSDictionary *dic in arry) {
          MovieModel *model=[[MovieModel alloc]init];
          [model setValuesForKeysWithDictionary:dic];
          [self.movieArray addObject:model];
      }
      if (self.shuaxinBlock) {
          self.shuaxinBlock();
      }
      
  } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
      
      NSLog(@"=============%@",error);
  }];
}

#pragma mark 解析音频数据

-(void)seririzationVoice{
    NSString *urlString=@"http://www.ihealth365.com:85/popumed_mobi/pmci/multimedia/?tuijian=n&page=1&type=yinpin";
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.voiceArry addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];
    
}

-(void)shuxinMovie{
    NSString *urlString= [NSString stringWithFormat:@"http://www.ihealth365.com:85/popumed_mobi/pmci/multimedia/?tuijian=n&page=%ld&type=shipin",++self.movieshucount]  ;
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.movieArray addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];

}
-(void)shuxinVoice{
  //  NSString *urlString=@"http://www.ihealth365.com:85/popumed_mobi/pmci/multimedia/?tuijian=n&page=1&type=yinpin";
    NSString *urlString= [NSString stringWithFormat:@"http://www.ihealth365.com:85/popumed_mobi/pmci/multimedia/?tuijian=n&page=%ld&type=yinpin",++self.voiceshucount]  ;
    NSSet *set = self.manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *setM = set.mutableCopy;
    [setM addObject:@"text/html"];
    self.manger.responseSerializer.acceptableContentTypes = setM;
    
    [self.manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *arry=responseObject[@"result"];
        for (NSDictionary *dic in arry) {
            MovieModel *model=[[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.voiceArry addObject:model];
        }
        if (self.shuaxinBlock) {
            self.shuaxinBlock();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"=============%@",error);
    }];
}

#pragma mark  视频的count，根据下标获取视频
-(NSInteger)movieListCount{
    return self.movieArray.count;

}
-(MovieModel *)getMovieModelAtIndexPath:(NSIndexPath *)indexpath{
    
    return  [self getMovieModelAtIndex:indexpath.row];
}
-(MovieModel *)getMovieModelAtIndex :(NSInteger )index {

    MovieModel *mod=self.movieArray[index];
    return mod;

}

#pragma mark  音频的count，根据下标获取视频

-(NSInteger)voiveListCount{
    
    return self.voiceArry.count;
}

-(MovieModel *)getVoiceModelAtIndexPath:(NSIndexPath *)indexpath{
    return [self getVoiceModelAtIndex:indexpath.row];
}
-(MovieModel *)getVoiceModelAtIndex :(NSInteger )index {
    MovieModel *mod=self.voiceArry[index];
    return mod;
}


@end
