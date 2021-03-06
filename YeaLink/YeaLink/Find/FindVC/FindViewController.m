//
//  FindViewController.m
//  YeaLink
//
//  Created by 李根 on 16/4/24.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "FindViewController.h"
#import "FindWebViewController.h"

@interface FindViewController ()<UIWebViewDelegate>

@end

@implementation FindViewController
{
    QJLBaseImageView *imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [UserInformation userinforSingleton].isFind = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"selectPhoto"] isEqualToString:@"1"]) {
        //  判定是否从相册返回, 若是, 不再重新加载, 而是返回原页面
        NSLog(@"从相册返回!");
    } else {
        [self getHtmlWithstr:@"/find/find"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
//    [UserInformation userinforSingleton].isFind = NO;
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingNavigationbar];
    self.wv.delegate = self;
    
    self.backNative = ^() {
        NSLog(@"没有原生页面, 怎么返回");
    };
    
    
    
}



- (void)settingNavigationbar {
    __weak FindViewController *blockSelf = self;
    QJLBaseLabel *label = [QJLBaseLabel LabelWithFrame:CGRectMake(0, 0, 200 * WID, 30 * HEI) text:@"发现" titleColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:19]];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = CUSTOMBLUE;
    self.takeStr = ^(NSString *currentTitle) {
        label.text = currentTitle;
        if ([currentTitle isEqualToString:@"发现"]) {
            blockSelf.navigationItem.hidesBackButton = YES;
            blockSelf.navigationItem.leftBarButtonItem = nil;
        } else {
            blockSelf.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:blockSelf action:@selector(back:)];
        }
    };
    label.numberOfLines = 0;
    [label sizeToFit];
    
    self.changeShowLeftButton = ^(NSString *urlStr) {
        if ([urlStr rangeOfString:@"find?"].location != NSNotFound) {
            blockSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:blockSelf action:@selector(rightAction:)];
        } else {
            blockSelf.navigationItem.rightBarButtonItem = nil;
        }
    };
    
    //  会影响导航栏上所有除返回以外的按钮
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
}

- (void)back:(id)sender {
    //  h5页面的返回
    __weak BaseWebViewController *blockSelf = self;
    self.backforH5 = ^(UIWebView *webview) {
        NSString *Str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"gotoPre();"]];
        NSLog(@"jsStr: %@", Str);
        if ([Str isEqualToString:@"a"] || [Str isEqualToString:@"b"]) {
            //            NSLog(@"我该怎么返回!");
        } else {
            //  返回native
            blockSelf.backNative();
        }
    };
    self.backforH5(self.wv);
}

- (void)rightAction:(id)sender {
    //  Find/FindSearch
    [UserInformation userinforSingleton].strURL = @"Find/FindSearch";
    FindWebViewController *findWebVC = [[FindWebViewController alloc] init];
    [self.navigationController pushViewController:findWebVC animated:YES];
//    [self presentViewController:findWebVC animated:YES completion:^{
//        
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
