//
//  SQMySegment.m
//  sikuDemo
//
//  Created by 齐冲 on 16/1/11.
//  Copyright © 2016年 齐冲. All rights reserved.
//

#import "SQMySegment.h"
static CGFloat linHeight = 2;
@interface SQMySegment()
{
    segmentSelectedBlokc _block;
    NSArray *_titleArrary;
    NSMutableArray *_btnArrary;
    UIButton *_agoBtn;
    UIView *_animateLine;
    UIView *_bigColorView;
    NSMutableArray *_selectBtnArrary;
}
@property (nonatomic,strong) UIView *smallBackView;
@property (nonatomic,strong) UIView *bottomView;
@end
@implementation SQMySegment

- (instancetype)initWithFrame:(CGRect)frame andTitleArrary:(NSArray *)titleArrary andSelectedBlock:(segmentSelectedBlokc)block
{
    if (self = [super initWithFrame:frame]) {
        _titleArrary = titleArrary;
        _block = block;
        [self addSubview:self.bottomView];
        [self addSubview:self.smallBackView];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = object;
            _smallBackView.frame = CGRectMake(view.frame.origin.x, _smallBackView.frame.origin.y, _smallBackView.frame.size.width, _smallBackView.frame.size.height);
            _bigColorView.frame = CGRectMake(-_smallBackView.frame.origin.x ,_smallBackView.frame.origin.y, _smallBackView.frame.size.width, _smallBackView.frame.size.height);
        }
    }
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIScrollView alloc] initWithFrame:self.frame];
        _btnArrary = @[].mutableCopy;
        CGFloat btnwith = _bottomView.frame.size.width / _titleArrary.count;
        for (NSInteger i = 0; i < _titleArrary.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnwith * i, 0, btnwith, _bottomView.frame.size.height);
            [btn setTitle:_titleArrary[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = i;
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:btn];
            [_btnArrary addObject:btn];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - linHeight, self.frame.size.width, linHeight)];
        line.backgroundColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
        [_bottomView addSubview:line];
        
        _animateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - linHeight, self.frame.size.width / _titleArrary.count , linHeight)];
        
        [_animateLine addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        _animateLine.backgroundColor = [UIColor redColor];
        [_bottomView addSubview:_animateLine];
    }
    return _bottomView;
}

- (UIView *)smallBackView
{
    if (!_smallBackView) {
        _bigColorView = [[UIView alloc] init];
        _smallBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.frame.size.width / _titleArrary.count, self.frame.size.height - 2)];
        _smallBackView.clipsToBounds = YES;
        _selectBtnArrary = @[].mutableCopy;
       CGFloat btnwith = self.frame.size.width / _titleArrary.count;
        for (NSInteger i = 0; i < _titleArrary.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnwith * i, 0, btnwith, _smallBackView.frame.size.height);
            [btn setTitle:_titleArrary[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag = i;
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_bigColorView addSubview:btn];
            [_selectBtnArrary addObject:btn];
        }
        [_smallBackView addSubview:_bigColorView];
        _smallBackView.backgroundColor = [UIColor whiteColor];
    }
    return _smallBackView;
}

#pragma mark - btn clected
- (void)pressBtn:(UIButton *)sender
{
    if (_agoBtn == sender) {
        return;
    }
    sender.selected = YES;
    _agoBtn.selected = NO;
    _agoBtn = sender;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _animateLine.frame = CGRectMake(sender.frame.origin.x, _animateLine.frame.origin.y,_animateLine.frame.size.width,_animateLine.frame.size.height);
    } completion:nil];
    if (_block) {
        _block(sender.tag);
    }
}

- (void)makeLineGoWithIndex:(CGFloat)proportion
{
    if (_animateLine) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          _animateLine.frame = CGRectMake(self.frame.size.width / _titleArrary.count * proportion, _animateLine.frame.origin.y,_animateLine.frame.size.width,_animateLine.frame.size.height);
        } completion:nil];
       
        if (_agoBtn.tag == (NSInteger)proportion) {
            return;
        }
        _agoBtn.selected = NO;
        UIButton *currentBtn = _btnArrary[(NSInteger)proportion];
        currentBtn.selected = YES;
        _agoBtn = currentBtn;
    }
}

-(void)setNormalTextColor:(UIColor *)normalTextColor
{
    for (UIButton *btn in _btnArrary) {
        [btn setTitleColor:normalTextColor forState:UIControlStateNormal];
    }
}

- (void)setSelectTextColor:(UIColor *)selectTextColor
{
    _animateLine.backgroundColor = selectTextColor;
    for (UIButton *btn in _selectBtnArrary) {
        [btn setTitleColor:selectTextColor forState:UIControlStateNormal];
    }
}

- (void)dealloc
{
    [_animateLine removeObserver:self forKeyPath:@"frame"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
