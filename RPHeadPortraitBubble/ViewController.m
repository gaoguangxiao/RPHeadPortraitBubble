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
    
    bu_view = [[GHCardBuddleView alloc]initWithFrame:CGRectMake(0, 150, bubbleView.bounds.size.width, 350)];
    bu_view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bu_view];
    [bu_view receiveNewNotification:@[@"rpImg_00.jpg",@"rpImg_01.jpg",@"rpImg_02.jpg",@"rpImg_03.jpg",@"rpImg_04.jpg",@"rpImg_05.jpg",@"rpImg_06.jpg"]];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addNewNotification:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)addNewNotification:(NSTimer *)timer{
    
    //对视图进行添加
//    [bu_view receiveNewNotification:@[@""]];
    
}

@end
