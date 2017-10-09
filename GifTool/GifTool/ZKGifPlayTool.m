//
//  ZKGifPlayTool.m
//  GifTool
//
//  Created by MliBo on 2017/7/21.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import "ZKGifPlayTool.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

typedef void(^AnimationCompleteBlock)(BOOL complete);

@interface ZKGifPlayTool ()
@property (nonatomic, strong) UIView         * contentView; //展示的View
@property (nonatomic, assign) CGImageSourceRef gif;
@property (nonatomic, strong) NSDictionary   * gifDic;
@property (nonatomic, assign) size_t           index;       //计数
@property (nonatomic, assign) size_t           count;       //图片的张数
@property (nonatomic, strong) NSTimer        * timer;       //计时器

@property (nonatomic, assign) int              up;
@property (nonatomic, copy)   NSString       * imageName;
@property (nonatomic, strong) UIImageView    * backgoundView;

@property (nonatomic, copy) AnimationCompleteBlock completeBlock;
@end

static NSTimeInterval timeInterval = 0.075; //每张图片切换的时间

@implementation ZKGifPlayTool
#pragma mark - 播放gif动画
- (void)addGifName:(NSString *)name toView:(UIView *)contentView{
    self.contentView = contentView;
    [self createGifWithName:name];
}

- (void)createGifWithName:(NSString *)name{
    NSNumber * num = [NSNumber numberWithInt:0];
    NSDictionary * gifDictionary = @{(NSString *)kCGImagePropertyGIFLoopCount:num};
    self.gifDic = @{(NSString *)kCGImagePropertyGIFDictionary:gifDictionary};
    NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData * gifData = [NSData dataWithContentsOfFile:path];
    self.gif = CGImageSourceCreateWithData((CFDataRef)gifData, (CFDictionaryRef)self.gifDic);
    _count = CGImageSourceGetCount(self.gif); //得到图片的张数
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(startPlay) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//开始播放
- (void)startPlay{
    _index ++;
    _index = _index%_count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(self.gif, _index, (CFDictionaryRef)self.gifDic);
    self.contentView.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

//停止播放
- (void)stopPlay{
    if (self.gif) {
        CFRelease(self.gif);
        if (self.timer.valid) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

#pragma mark - 播放帧动画
- (void)addAnimationName:(NSString *)name toView:(UIImageView *)contentView count:(NSUInteger)count{
    self.imageName = name;
    self.backgoundView = contentView;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:count*timeInterval+0.25];
}

- (void)addAnimationName:(NSString *)name toView:(UIImageView *)contentView count:(NSUInteger)count withCompleteBlock:(void(^)(BOOL complete))Block{
    self.imageName = name;
    self.backgoundView = contentView;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:count*timeInterval+0.25];
    self.completeBlock = Block;
}

- (void)startAnimation{
    NSString * imageName = [NSString stringWithFormat:@"%@%d",self.imageName,_up];
    UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    self.backgoundView.image = image;
    _up++;
}

- (void)stopAnimation{
    if (self.timer.valid) {
        [self.timer invalidate];
        self.timer = nil;
        if (self.completeBlock) {
            self.completeBlock(YES);
        }
    }
}

- (void)dealloc{
    NSLog(@"ZKGifPlayTool dealloc !!!!!!");
}

@end
