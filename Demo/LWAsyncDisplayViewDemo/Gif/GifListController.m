//
//  TestViewController.m
//  LWAsyncDisplayViewDemo
//
//  Created by Jiangmingz on 2018/7/26.
//  Copyright © 2018年 WayneInc. All rights reserved.
//

#import "GifListController.h"

#import "TextViewCell.h"
#import "LWGIFImage.h"

static NSString *cellIdentifier = @"cellIdentifier";
static CGFloat gifSize = 30;

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

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self dataSource];
//        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"reloadData");
            [self.tableView reloadData];
//        });
//    });
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
    for (int i = 0; i < 300; i++) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        NSInteger count = (NSInteger) (width / gifSize);
        NSMutableString *mutableString = [NSMutableString new];
        [mutableString appendFormat:@"%d->", i];
        LWLayout *layout = [[LWLayout alloc] init];
        for (int j = 0; j < count - 1; j++) {
            LWTextStorage *textStorage = [[LWTextStorage alloc] init];
            textStorage.frame = CGRectMake(0.0f, 0.0f, gifSize, gifSize);
            textStorage.text = [NSString stringWithFormat:@"%d", i];
            textStorage.textColor = [UIColor redColor];
            textStorage.vericalAlignment = LWTextVericalAlignmentCenter;
            [layout addStorage:textStorage];

            NSInteger index = arc4random() % 141;
            NSString *name = [self gifWithIndex:index];
            LWGIFImage *gifImage = [LWGIFImage gifNamed:name inDirect:@"EmoticonQQ.bundle"];
            LWImageStorage *imageStorage = [[LWImageStorage alloc] init];
            imageStorage.frame = CGRectMake((j + 1) * gifSize, 0, gifSize, gifSize);
            imageStorage.contents = gifImage;
            imageStorage.localImageType = LWLocalImageTypeDrawInLWAsyncImageView;
            imageStorage.contentMode = UIViewContentModeScaleAspectFill;
            [layout addStorage:imageStorage];

            [mutableString appendFormat:@"%@ ", name];
        }

        NSLog(@"%@",mutableString);
        [_dataSource addObject:layout];
    }

    return _dataSource;
}

- (NSString *)gifWithRadom {
    NSInteger index = arc4random() % 141;
    NSString *name = [self gifWithIndex:index];
    return name;
}

- (NSString *)gifWithIndex:(NSInteger)index {
    NSMutableString *name = [NSMutableString new];
    if( index < 10) {
        [name appendString:@"00"];
    } else if(index < 100) {
        [name appendString:@"0"];
    }
    [name appendFormat:@"%zd",index];
    return name;
}

@end

