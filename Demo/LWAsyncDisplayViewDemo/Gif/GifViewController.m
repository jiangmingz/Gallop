//
//  GifViewController.m
//  LWAsyncDisplayViewDemo
//
//  Created by Jiangmingz on 2018/7/25.
//  Copyright © 2018年 WayneInc. All rights reserved.
//

#import "GifViewController.h"

#import <SDWebImage/FLAnimatedImageView+WebCache.h>
#import <FLAnimatedImage/FLAnimatedImage.h>

#import "LWLayout.h"
#import "LWAsyncDisplayView.h"

@interface GifViewController ()

@property(nonatomic,strong) FLAnimatedImageView *gifImageView;
@property(nonatomic,strong) LWAsyncDisplayView* displayView;
@property(nonatomic,strong) LWLayout* layout;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.gifImageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) *0.5f, 50, 100, 100)];
//    [self.gifImageView sd_setImageWithURL:[NSURL URLWithString:@"http://ww3.sinaimg.cn/bmiddle/006qdyzsly1fctmnzwqcwg307505pasc.gif"]];
//    [self.view addSubview:self.gifImageView];

    LWImageStorage* imageStorage = [[LWImageStorage alloc] init];
    imageStorage.contents = [NSURL URLWithString:@"http://ww3.sinaimg.cn/bmiddle/006qdyzsly1fctmnzwqcwg307505pasc.gif"];
    imageStorage.backgroundColor = [UIColor grayColor];
    imageStorage.contentMode = UIViewContentModeScaleAspectFill;
    imageStorage.frame = CGRectMake(0.0,0.0, 100, 100);
    
    self.layout = [[LWLayout alloc] init];
    [self.layout addStorage:imageStorage];
    
    self.displayView = [[LWAsyncDisplayView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) *0.5f,200, 100, 100)];
    self.displayView.layout = self.layout;
    [self.view addSubview:self.displayView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.gifImageView sd_setImageWithURL:[NSURL URLWithString:@"http://ww3.sinaimg.cn/bmiddle/006qdyzsly1fctmnzwqcwg307505pasc.gif"]];
    self.displayView.layout = nil;
    self.displayView.layout = self.layout;
}

@end
