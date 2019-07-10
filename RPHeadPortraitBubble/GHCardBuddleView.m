//
//  RPHeadPortraitBubbleView.m
//  RPHeadPortraitBubble
//
//  Created by Tao on 2018/9/27.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "GHCardBuddleView.h"
#import "UIView+Ext.h"

#define WTWeakSelf __weak typeof(self) weakSelf = self;
#define randomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f]
#define WTWidth [UIScreen mainScreen].bounds.size.width
#define WTHeight [UIScreen mainScreen].bounds.size.height
#define K_COUNT 10

@interface GHCardBuddleView ()

@property (nonatomic, strong) UILabel * activeImg;

@property (nonatomic, assign) int jsh_index;
@property (nonatomic, assign) int jsh_img;

@property (nonatomic, assign) NSInteger img_tag;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation GHCardBuddleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    for (int i = 0; i < self.dataArr.count; i++) {
        
        UILabel * imgv = [[UILabel alloc]initWithFrame:CGRectMake(0, 60*i, self.width, 50)];
        imgv.tag = 10+i;
        imgv.hidden = YES;
        imgv.text = [NSString stringWithFormat:@"%d",i];
        imgv.centerY = self.width/2;
        imgv.layer.cornerRadius = 25;
        imgv.layer.masksToBounds = YES;
        imgv.layer.borderColor = [UIColor orangeColor].CGColor;
        imgv.layer.borderWidth = 3;
        imgv.backgroundColor = randomColor;
        [self addSubview:imgv];
        if (i == 0) {
            self.jsh_index = 0;
            self.activeImg = imgv;
        }
    }
}

-(void)receiveNewNotification:(NSArray *)arr{

    //需要依次移动
    [self.dataArr addObjectsFromArray:arr];
    //当产生新的时候 向数组中加
    [self startNewView];
    
}
- (void)moveOldView{
    
    for (int i = 0; i < self.dataArr.count; i++) {
        UILabel * imgv = [self viewWithTag:10+i];
        imgv.text = [NSString stringWithFormat:@"%d",i];
    }
    self.jsh_img = 4;
    [self startAnimation];
}

- (void)startAnimation{
    WTWeakSelf;
    //视图上移动
    [UIView animateWithDuration:1 animations:^{
//        NSInteger activeTag = weakSelf.activeImg.tag;
        for (int i = 0; i < self.dataArr.count; i++) {
            NSInteger aTag = 10+i;
//            if (aTag != activeTag) {
                UILabel * imgg = [weakSelf viewWithTag:10+i];
                imgg.centerY = imgg.centerY-60;
//            }
        }
    } completion:^(BOOL finished) {
        
        //
    }];
}

-(void)startNewView{
    
    WTWeakSelf;
    weakSelf.img_tag ++;

    UILabel * imgv = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
    imgv.tag = 10+weakSelf.img_tag;
    imgv.textAlignment = NSTextAlignmentCenter;
    imgv.text = [NSString stringWithFormat:@"%ld",weakSelf.img_tag];
    imgv.centerY = self.width/2;
    imgv.layer.cornerRadius = 25;
    imgv.layer.masksToBounds = YES;
    imgv.layer.borderColor = [UIColor orangeColor].CGColor;
    imgv.layer.borderWidth = 3;
    imgv.backgroundColor = randomColor;
    [self addSubview:imgv];
    
    //先移动
    [self moveOldView];
    
    weakSelf.activeImg = imgv;
    weakSelf.activeImg.centerY = self.height;
//    weakSelf.activeImg.transform = CGAffineTransformScale(weakSelf.activeImg.transform, 0.1, 0.1);
    
    [UIView animateWithDuration:1 animations:^{
        weakSelf.activeImg.centerY = self.height - imgv.height/2;
//        weakSelf.activeImg.transform = CGAffineTransformScale(weakSelf.activeImg.transform, 10, 10);
    } completion:^(BOOL finished) {
//        [self startAnimation];
        //开始对新添加的计时，如果超过一定时间就移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:1 animations:^{
//                weakSelf.activeImg.Y = self.height - 60;
                imgv.transform = CGAffineTransformScale(weakSelf.activeImg.transform, 0.1, 0.1);
            } completion:^(BOOL finished) {
                [imgv removeFromSuperview];
            }];
        });
    }];
}
- (UIViewController *)getCurrentVC {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
@end

//示例图片来自网络,如有不妥,请联系
