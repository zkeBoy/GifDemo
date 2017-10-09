//
//  ZKViewController.m
//  GifTool
//
//  Created by MliBo on 2017/7/21.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import "ZKViewController.h"
#import "ZKGifPlayTool.h"
@interface ZKViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIImageView * backgroundView;
@property (nonatomic, strong) ZKGifPlayTool * gifPlayTool;
@end

@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self)weakSelf = self;
    self.gifPlayTool = [[ZKGifPlayTool alloc] init];
    //[self.gifPlayTool addGifName:@"car" toView:weakSelf.contentView];
    
    [self.gifPlayTool addAnimationName:@"newcar_" toView:weakSelf.backgroundView count:134 withCompleteBlock:^(BOOL complete) {
        NSLog(@"sss");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"ZKViewController dealloc !!!!!!");
    [self.gifPlayTool stopPlay];
}

- (UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_backgroundView];
    }
    return _backgroundView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
