//
//  HomepageView.h
//  YeaLink
//
//  Created by 李根 on 16/4/24.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "QJLBaseView.h"

@interface HomepageView : QJLBaseView
/**
 *  首页中间部分
 */
@property(nonatomic, strong)NSMutableArray *tempArr;
@property(nonatomic, strong)QJLBaseCollectionView *collectionView;
@property(nonatomic, strong)void(^jumpView)();  //  跳转页面
@property(nonatomic, strong)void(^pushview)();

@end