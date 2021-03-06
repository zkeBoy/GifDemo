//
//  ZKGifPlayTool.h
//  GifTool
//
//  Created by MliBo on 2017/7/21.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKGifPlayTool : NSObject

- (void)addGifName:(NSString *)name toView:(UIView *)contentView;
- (void)stopPlay;

- (void)addAnimationName:(NSString *)name
                  toView:(UIImageView *)contentView
                   count:(NSUInteger)count;
    
- (void)addAnimationName:(NSString *)name
                  toView:(UIImageView *)contentView
                   count:(NSUInteger)count
       withCompleteBlock:(void(^)(BOOL complete))Block;
@end
