//
//  SettingView.m
//  YeaLink
//
//  Created by 李根 on 16/5/12.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "SettingView.h"
#import "SettingCell.h"

#define ROWHEIGHT 50 * HEI

@interface SettingView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SettingView

- (void)createView {
    _arr = [NSMutableArray array];
    _arr = @[@"新消息提醒", @"功能介绍", @"帮助与反馈", @"官网", @"检查新版本", @"使用条款和隐私政策"];
    _nextArr = [NSMutableArray arrayWithObjects:@"0", @"/PersonalCenter/FunctionIntroduction", @"/PersonalCenter/HelpAndFeedback", @"http://www.go2family.com", @"0", @"/PersonalCenter/TermsAndPrivacy", nil];
    
    
    _tableView = [[QJLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 350 * HEI) style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.rowHeight = ROWHEIGHT;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
}

- (void)setArr:(NSMutableArray *)arr {
    if (_arr != arr) {
        _arr = arr;
    }
    
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"reuse";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    if (indexPath.row == 0) {
        cell.switchButton.hidden = NO;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"switchStatus"] == nil) {
            [self sendDefaultStatusWith:cell.switchButton.on];
        }
        [cell.switchButton addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
//        [cell.switchButton addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.titleLabel.text = _arr[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    SettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([_nextArr[indexPath.row] isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"功能尚未开发, 敬请期待!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [UserInformation userinforSingleton].strURL = _nextArr[indexPath.row];
        _push();
    }
    
}

- (void)sendDefaultStatusWith:(BOOL)switchStatus {
//    /api/APIUserManage/SetNoticePush?UserID=18627820357&IsPush=1
    NSString *tempStr = [NSString stringWithFormat:@"%@/api/APIUserManage/SetNoticePush?UserID=%@&IsPush=%d", COMMONURL, [UserInformation userinforSingleton].usermodel.UserID, switchStatus];
    NSLog(@"%@", tempStr);
    [NetWorkingTool getNetWorking:tempStr block:^(id result) {
//        NSLog(@"code: %@", result[@"code"]);
        if (![result[@"code"] isEqualToString:@"1"]) {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:result[@"text"] message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
            [aler show];
        }
    }];
    
}

- (void)valueChange:(UISwitch *)switchBtn {
//    NSLog(@"switchBtn.on: %d", switchBtn.on);
    [self sendDefaultStatusWith:switchBtn.on];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
