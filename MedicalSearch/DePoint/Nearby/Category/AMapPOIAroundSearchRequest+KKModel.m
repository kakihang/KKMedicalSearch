//
//  AMapPOIAroundSearchRequest+KKModel.m
//  DePoint
//
//  Created by kaki on 16/7/27.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "AMapPOIAroundSearchRequest+KKModel.h"

@implementation AMapPOIAroundSearchRequest (KKModel)
+ (instancetype)searchRequest {
    // 构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    // 当前位置 默认值
    //request.location = [AMapGeoPoint locationWithLatitude:23.131287 longitude:113.401946];
    
    //关键字 默认为药店
    request.keywords = @"药店";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    //    request.types = @"餐饮服务|生活服务";
    request.types = @"医疗保健服务";
    request.radius =  1500;//<! 查询半径，范围：0-50000，单位：米 [default = 3000]
    request.sortrule = 0; //<! 排序规则, 0-距离排序；1-综合排序, 默认1
    request.requireExtension = NO; //<! 是否返回扩展信息，默认为 NO。
    request.offset = 50; //每页记录数
    request.page = 1; //当前页数
    
    return request;
}
@end
