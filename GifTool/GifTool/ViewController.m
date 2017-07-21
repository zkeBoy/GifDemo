//
//  ViewController.m
//  GifTool
//
//  Created by MliBo on 2017/7/21.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import "ViewController.h"
#import "ZKGifPlayTool.h"
#import "ZKViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(pushToNextView)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)pushToNextView{
    ZKViewController * nextVC = [[ZKViewController alloc] initWithNibName:@"ZKViewController" bundle:nil];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
