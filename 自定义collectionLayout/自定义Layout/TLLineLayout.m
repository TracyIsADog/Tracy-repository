//
//  TLLineLayout.m
//  自定义collectionLayout
//
//  Created by rimi on 15/7/16.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import "TLLineLayout.h"
//item的宽度与高度
static const CGFloat  TLItemWidth = 100.0;
//每个item间的间距
static const CGFloat  Spacing = 80.0;
@implementation TLLineLayout

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
/**
 *  当显示边界变化时重新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 *  设置item属性
 */
- (void)prepareLayout
{
    [super prepareLayout];
    //设置item尺寸
    self.itemSize = CGSizeMake(TLItemWidth, TLItemWidth);
    
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置左右两边间距
    CGFloat inset = (self.collectionView.frame.size.width - TLItemWidth) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    //设置item间距
    self.minimumLineSpacing = Spacing;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //取得默认的cell的layoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //获得可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    //计算屏幕最中间的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //遍历布局属性
    for (UICollectionViewLayoutAttributes *attri in array) {
        //只运算可见的
        if (!CGRectIntersectsRect(visiableRect, attri.frame)) {
            continue;
        }
        
        //获得item的centerX
        CGFloat itemCenterX = attri.center.x;
        
        //设置缩放比例
        CGFloat scale = 1 + 0.5 *(1 - ABS(centerX - itemCenterX) / (self.collectionView.frame.size.width * 0.5));
        
        attri.transform3D = CATransform3DMakeScale(scale, scale, 1);
    }
    return array;
}
@end
