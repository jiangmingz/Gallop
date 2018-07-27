//
//  TestViewController.m
//  LWAsyncDisplayViewDemo
//
//  Created by Jiangmingz on 2018/7/26.
//  Copyright © 2018年 WayneInc. All rights reserved.
//

#import "GifListController.h"
#import "TextViewCell.h"

static NSString *cellIdentifier = @"cellIdentifier";
static CGFloat gifSize = 28;

@interface GifListController () <UITableViewDelegate, UITableViewDataSource>


@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation GifListController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"LWImageStorage使用示例";
    [self.view addSubview:self.tableView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Test"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(test)];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self dataSource];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)test {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Test"
                                                                             message:@"当 present 出 UIAlertController时, 界面上显示的图片全部不显示了"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    LWLayout *layout = self.dataSource[indexPath.row];
    cell.layout = layout;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return gifSize;
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[TextViewCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }

    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 500; i++) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        NSInteger count = (NSInteger) (width / gifSize);
        LWLayout *layout = [[LWLayout alloc] init];
        for (int j = 0; j < count; j++) {
            NSInteger index = arc4random() % 72;
            LWImageStorage *imageStorage = [[LWImageStorage alloc] init];
            imageStorage.frame = CGRectMake(j * gifSize, 0, gifSize, gifSize);
            imageStorage.contents = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", index]];
            [layout addStorage:imageStorage];
        }

        [_dataSource addObject:layout];
    }

    return _dataSource;
}


@end

