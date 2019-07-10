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

@property (nonatomic, strong) NSArray * dataArr;
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

- (void)createUI
{
    for (int i = 0; i < K_COUNT; i++) {
        
        UILabel * imgv = [[UILabel alloc]initWithFrame:CGRectMake(0, 60*i, self.width, 50)];
        imgv.tag = 10+i;
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
    self.dataArr = arr;
    
    //当产生新的时候
}
- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    
    if (dataArr.count<5) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"传入dataArr.count不能少于5个" message:nil preferredStyle: UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootViewController presentViewController:alert animated:true completion:nil];
        return;
    }
    
    for (int i = 0; i<K_COUNT; i++) {
        UILabel * imgv = [self viewWithTag:10+i];
        imgv.text = [NSString stringWithFormat:@"%d",i];
    }
    self.jsh_img = 4;
    [self startAnimation];
}

- (void)startAnimation
{
    WTWeakSelf;
    //视图上移动
    [UIView animateWithDuration:1 animations:^{
        
        NSInteger activeTag = weakSelf.activeImg.tag;
        for (int i = 0; i<K_COUNT; i++) {
            NSInteger aTag = 10+i;
            if (aTag != activeTag) {
                UILabel * imgg = [weakSelf viewWithTag:10+i];
                imgg.centerY = imgg.centerY-60;
            }
        }
    } completion:^(BOOL finished) {
        
        weakSelf.activeImg.centerY = self.height - 60;
        weakSelf.activeImg.transform = CGAffineTransformScale(weakSelf.activeImg.transform, 0.1, 0.1);
        if (weakSelf.jsh_img<weakSelf.dataArr.count-1) {
            weakSelf.jsh_img = weakSelf.jsh_img+1;
        }else{
            weakSelf.jsh_img = 0;
        }
        weakSelf.activeImg.text = [NSString stringWithFormat:@"%d",weakSelf.jsh_img];
        
        [UIView animateWithDuration:1 animations:^{
            weakSelf.activeImg.transform = CGAffineTransformScale(weakSelf.activeImg.transform, 10, 10);
        } completion:^(BOOL finished) {
            
            [weakSelf bringSubviewToFront:weakSelf.activeImg];
            [UIView animateWithDuration:1 animations:^{
                weakSelf.activeImg.Y = self.height - 60;
            } completion:^(BOOL finished) {
                weakSelf.jsh_index = weakSelf.jsh_index+1;
                if (weakSelf.jsh_index >K_COUNT - 1) {
                    weakSelf.jsh_index = 0;
                }
                weakSelf.activeImg = [weakSelf viewWithTag:10+weakSelf.jsh_index];
                [weakSelf startAnimation];
            }];
        }];
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

@end

//示例图片来自网络,如有不妥,请联系
