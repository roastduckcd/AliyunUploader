//
//  ViewController.m
//  AliyunUploader
//
//  Created by yang song on 2019/4/27.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "ViewController.h"
#import "RDAliNetWork.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RDAliNetWork *oss = [[RDAliNetWork alloc] init];
    [oss performSelector:@selector(accessForToken)];
    
}


@end
