//
//  ViewController.m
//  自定义collectionLayout
//
//  Created by rimi on 15/7/16.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "FirstLayoutCell.h"
#import "TLLineLayout.h"
#import "TLCircleLayout.h"

//随机色
#define randomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak ,nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    CGRect rect = CGRectMake(0, 50, self.view.frame.size.width, 200);
    //初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[TLCircleLayout alloc] init]];
    collectionView.backgroundColor = [UIColor clearColor];
    //注册xib
    [collectionView registerNib:[UINib nibWithNibName:@"FirstLayoutCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //设置代理
    collectionView.delegate = self;
    //设置数据源
    collectionView.dataSource = self;
    //添加collectionView
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[TLLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init] animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifier = @"cell";
    FirstLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = randomColor;
    return cell;
}




@end
