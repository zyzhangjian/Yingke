//
//  XCNetworkTools.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "HFNetworkTools.h"

#import "Reachability.h"

@protocol HFNetworkToolsProxy <NSObject>

@optional

/**
 *  @brief AFN内部的数据访问方法
 *
 *  @param method           HTTP方法
 *  @param URLString        URLString
 *  @param parameters       请求参数字典
 *  @param uploadProgress   上传进度
 *  @param downloadProgress 下载进度
 *  @param success          成功回调
 *  @param failure          失败回调
 *
 *  @return 最后需要resume来启动任务
 */
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface HFNetworkTools()<HFNetworkToolsProxy>

@end

@implementation HFNetworkTools

#pragma mark - 单例 & 构造函数
+(instancetype)sharedTools {
    
    static HFNetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    });
    return instance;
}

#pragma mark - 设置基础地址和对服务器返回NULL转化为nil的处理
-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    
    if (self) {
        // 判断网络状态(可能需要延时再判断)
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
            if (status <= 0) {
                return;
            }
        }];
        [self.reachabilityManager startMonitoring];
        
        // 设置可以接受的响应类型
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
        // 设置请求超时时间
        self.requestSerializer.timeoutInterval = 10.0;
        
        // 如果服务器返回null就会变成nil
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
    }
    return self;
}

/**
 *  @brief 发起网络请求
 *
 *  @param method     GET/POST
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param finish     请求完成回调
 */
-(void)requestWithMethod:(HFRequestMethod)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters finished:(HFRequestCallBack)finish nonetwork:(HFReachability)nonetwork{
    
    if (([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable) && [Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) {
        nonetwork();
        return;
    }
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";

    NSDate *date = [NSDate date];
    NSString *time = [NSString stringWithFormat:@"&s_st=%ld", (long)[date timeIntervalSince1970]];
    
    [[self dataTaskWithHTTPMethod:methodName URLString:[NSString stringWithFormat:@"%@%@",URLString,time] parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finish(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"网络请求错误 %@",error.localizedDescription);
        finish(nil,error);
    }] resume];
}

/**
 *  @brief 上传二进制数据
 *
 *  @param data       需要上传的二进制数据
 *  @param URLString  URLString
 *  @param name       服务器存放文件夹名称
 *  @param fileName   服务器存放文件夹中文件名称
 *  @param parameters 请求参数字典
 *  @param finish     完成回调
 */
-(void)uploadData:(NSData *)data URLString:(NSString *)URLString name:(NSString *)name fileName:(NSString *)fileName parameters:(NSDictionary *)parameters finish:(HFRequestCallBack)finish nonetwork:(HFReachability)nonetwork{
    
    if (([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable) && [Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) {
        nonetwork();
        return;
    }
    
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /**
         *  Data:需要上传的数据
         *  name:服务器文件夹参数的名称
         *  fileName:文件的名称
         *  mimeType:文件的类型 application/octet-stream 代表任意的耳机子数据传输
         */
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"application/octet-stream"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finish(nil,error);
    }];
}

/**
 *  @brief 下载文件
 *
 *  @param URLString  文件地址
 *  @param fileName  文件名称
 *  @param finish    完成回调
 *  @param nonetwork 网络状态
 */
-(void)downloadWithUrlString:(NSString *)URLString fileName:(NSString *)fileName finish:(HFRequestCallBack)finish nonetwork:(HFReachability)nonetwork{
    
    if (([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable) && [Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) {
        nonetwork();
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [[self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"当前进度%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *filePathUrl = [NSURL fileURLWithPath:fullPath];
        return filePathUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        finish(nil,nil);
        NSLog(@"文件下载完毕-----%@-----%@ -----%@",response,filePath,error);
    }] resume];
}

@end
