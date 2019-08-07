//
//  ViewController.m
//  RPHeadPortraitBubble
//
//  Created by Tao on 2018/9/27.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "ViewController.h"
#import "RPHeadPortraitBubbleView.h"
#import "GHCardBuddleView.h"
@interface ViewController ()
{
    GHCardBuddleView *bu_view;
    NSInteger countTime;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSArray * imgArr = [NSArray arrayWithObjects:@"rpImg_00.jpg",@"rpImg_01.jpg",@"rpImg_02.jpg",@"rpImg_03.jpg",@"rpImg_04.jpg",@"rpImg_05.jpg",@"rpImg_06.jpg",@"rpImg_07.jpg",@"rpImg_08.jpg",@"rpImg_09.jpg", nil];
    
    
    RPHeadPortraitBubbleView * bubbleView = [[RPHeadPortraitBubbleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    bubbleView.backgroundColor = [UIColor redColor];
    bubbleView.dataArr = imgArr;
    [self.view addSubview:bubbleView];
    
    bu_view = [[GHCardBuddleView alloc]initWithFrame:CGRectMake(0, 150, bubbleView.bounds.size.width, self.view.bounds.size.height - 150)];
    bu_view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bu_view];
    [bu_view receiveNewNotification:@[@"rpImg_00.jpg",@"rpImg_01.jpg",@"rpImg_02.jpg",@"rpImg_03.jpg",@"rpImg_04.jpg",@"rpImg_05.jpg",@"rpImg_06.jpg"]];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(addNewNotification:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    countTime = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [timer invalidate];
    });
}

-(void)addNewNotification:(NSTimer *)timer{
    
    countTime++;
    //对视图进行添加
    [bu_view receiveNewNotification:@[@(countTime)]];
    
}

@end
