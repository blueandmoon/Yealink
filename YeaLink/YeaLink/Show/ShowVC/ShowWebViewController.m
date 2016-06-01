//
//  ShowWebViewController.m
//  YeaLink
//
//  Created by 李根 on 16/5/23.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ShowWebViewController.h"

@interface ShowWebViewController ()

@end

@implementation ShowWebViewController
{
    QJLBaseButton *_btn;    //  返回按钮
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _btn = [QJLBaseButton buttonWithType:UIButtonTypeSystem];
//    [_btn setTitle:@"秀场" forState:UIControlStateNormal];
//    //    [_button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    _btn.frame = CGRectMake(50 * WID, 25 * HEI, 50 * WID, 30 * HEI);
//    [self.view addSubview:_btn];
//    [_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self getHtmlWithstr:[UserInformation userinforSingleton].strURL];
    [self settingNavigationbar];
    
}

- (void)settingNavigationbar {
    QJLBaseLabel *label = [QJLBaseLabel LabelWithFrame:CGRectMake(0, 0, 200 * WID, 30 * HEI) text:@"秀场" titleColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:19]];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = CUSTOMBLUE;
    self.takeStr = ^(NSString *currentTitle) {
        label.text = currentTitle;
    };
    label.numberOfLines = 0;
    [label sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    self.changeShowLeftButton = ^(NSString *str) {
        
    };
}

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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