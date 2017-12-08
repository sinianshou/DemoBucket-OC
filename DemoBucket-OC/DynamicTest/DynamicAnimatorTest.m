//
//  DynamicAnimatorTest.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 05/12/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//



#import "DynamicAnimatorTest.h"
#import "Masonry.h"

@interface DynamicAnimatorTest ()

@property (strong, nonatomic) UIView *targetViewRect;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (assign, nonatomic) CGPoint fromPoint;
@property (assign, nonatomic) CGPoint toPoint;
@property (weak, nonatomic) UISnapBehavior *snap;
@property (weak, nonatomic) UIPushBehavior *push;
@property (weak, nonatomic) UIAttachmentBehavior *attachment;
@property (weak, nonatomic) UIGravityBehavior *gravity;

@end

@implementation DynamicAnimatorTest

-(instancetype)initWithDynamicAnimatorType:(DynamicAnimatorType)daType
{
    self = [super init];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.dynamicAnimatorType = daType;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.targetViewRect = [[UIView alloc] init];
    [self.view addSubview:self.targetViewRect];

    self.targetViewRect.backgroundColor = [UIColor greenColor];
    int num = 0;
    UIFont *font = [UIFont systemFontOfSize:9];
    for (int i = -1; i < 2; i += 2) {
        for (int j = -1; j < 2; j += 2) {
            UILabel *la = [[UILabel alloc] init];
            la.text = [NSString stringWithFormat:@"%d", num];
            num++;
            la.textColor = [UIColor blackColor];
            la.font = font;
            [self.targetViewRect addSubview:la];
            [la mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(10, 10));
                make.centerX.mas_equalTo(self.targetViewRect.mas_centerX).multipliedBy(1+0.8*j);
                make.centerY.mas_equalTo(self.targetViewRect.mas_centerY).multipliedBy(1+0.8*i);
            }];
        }
    }
    // 0 1 2 3 -1,-1 1,-1 -1,1 1,1
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"Non-Gravity"] style:UIBarButtonItemStyleDone target:self action:@selector(configGravity:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    // Do any additional setup after loading the view.
}
-(void)updateViewConstraints
{
    typeof(self) __weak weakSelf = self;
    [self.targetViewRect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(weakSelf.view).with.offset(50);
    }];
    [super updateViewConstraints];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
}
-(void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    [self.animator.behaviors enumerateObjectsUsingBlock:^(__kindof UIDynamicBehavior * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UICollisionBehavior class]]) {
            UICollisionBehavior * CB = obj;
            [CB setTranslatesReferenceBoundsIntoBoundaryWithInsets:self.view.safeAreaInsets];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self configBehaviorFuncWith:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self configBehaviorFuncWith:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self configBehaviorFuncWith:touches withEvent:event];
}
-(void)configBehaviorFuncWith:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    switch (self.dynamicAnimatorType) {
        case AbsorbDynamicAnimatorType:
            [self snapBehaviorFuncWith:touches withEvent:event];
            break;
            
        case PushDynamicAnimatorType:
            [self pushBehaviorFuncWith:touches withEvent:event];
            break;
            
        case AttachDynamicAnimatorType: case AttachmentDynamicAnimatorType:
            [self attachmentBehaviorFuncWith:touches withEvent:event];
            break;
            
        case CollisionDynamicAnimatorType:
            
            break;
            
        default:
            break;
    }
}
-(void)snapBehaviorFuncWith:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.dynamicAnimatorType == AbsorbDynamicAnimatorType) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        if (self.snap == nil && self.targetViewRect != nil) {
            [self cleanBehaviors];
            UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.targetViewRect snapToPoint:point];
            snap.damping = 0.5;
            [self.animator addBehavior:snap];
            self.snap = snap;
        }else
        {
            [self.snap setSnapPoint:point];
        }
    }
}
-(void)pushBehaviorFuncWith:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan) {
        self.fromPoint = [touch locationInView:self.view];
    }else if (touch.phase == UITouchPhaseEnded)
    {
        self.toPoint = [touch locationInView:self.view];
        CGPoint offsetPoint = CGPointMake(self.toPoint.x - self.fromPoint.x, self.toPoint.y - self.fromPoint.y);
        CGFloat angle = atan2(offsetPoint.y, offsetPoint.x);
        CGFloat distance = hypot(offsetPoint.y, offsetPoint.x);
        if (self.push == nil && self.targetViewRect != nil) {
            [self cleanBehaviors];
            UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.targetViewRect] mode:UIPushBehaviorModeInstantaneous];
            push.angle = angle;
            push.magnitude = distance/10;
            push.active = YES;
            [self.animator addBehavior:push];
            self.push = push;
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.targetViewRect]];
            [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:self.view.safeAreaInsets];
            [self.animator addBehavior:collision];
        }else
        {
            //        self.push = angle;
            //        self.push.magnitude = distance/10;
            [self.push setPushDirection:CGVectorMake(offsetPoint.x/10, offsetPoint.y/10)];
            [self.push setActive:YES];
        }
    }
}
-(void)attachmentBehaviorFuncWith:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.attachment == nil && self.targetViewRect != nil) {
        UIOffset offset = UIOffsetMake(-self.targetViewRect.bounds.size.width/4, -self.targetViewRect.bounds.size.height/4);
        CGPoint anchorPoint = CGPointMake(CGRectGetMinX(self.targetViewRect.frame)-CGRectGetWidth(self.targetViewRect.frame)/4, CGRectGetMinY(self.targetViewRect.frame)-CGRectGetHeight(self.targetViewRect.frame)/4);
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.targetViewRect offsetFromCenter:offset attachedToAnchor:anchorPoint];
        [self cleanBehaviors];
        [self.animator addBehavior:attachment];
        self.attachment = attachment;
    }else
    {
        self.attachment.anchorPoint = [[touches anyObject] locationInView:self.view];
    }
    NSLog(@"self.attachment.damping is %f, self.attachment.frequency is %f", self.attachment.damping, self.attachment.frequency);
    switch (self.dynamicAnimatorType) {
        case AttachDynamicAnimatorType:
            self.attachment.damping = 0.1;
            self.attachment.frequency = 1.0;

            break;
        case AttachmentDynamicAnimatorType:
            self.attachment.damping = 0;
            self.attachment.frequency = 0;
            break;
            
        default:
            break;
    }
}
-(void)configGravity:(UIBarButtonItem*)barButton
{
    if ([barButton.title isEqualToString:[NSString stringWithFormat:@"Gravity"]]) {
        [self removeGravityFunc];
        [barButton setTitle:[NSString stringWithFormat:@"Non-Gravity"]];
    }else
    {
        [self addGravityFunc];
        [barButton setTitle:[NSString stringWithFormat:@"Gravity"]];
    }
}
-(void)addGravityFunc
{
    if (self.gravity == nil && self.targetViewRect != nil) {
        UIGravityBehavior * gravity = [[UIGravityBehavior alloc] initWithItems:[NSArray arrayWithObject:self.targetViewRect]];
        [self.animator addBehavior:gravity];
        self.gravity = gravity;
    }
}
-(void)removeGravityFunc
{
    if (self.gravity != nil) {
        [self.animator removeBehavior:self.gravity];
    }
}
-(void)cleanBehaviors
{
    if (self.gravity != nil) {
        [self.animator.behaviors enumerateObjectsUsingBlock:^(__kindof UIDynamicBehavior * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isEqual:self.gravity]) {
                [self.animator removeBehavior:obj];
            }
        }];
    }else
    {
        [self.animator removeAllBehaviors];
    }
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
