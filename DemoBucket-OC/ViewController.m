//
//  ViewController.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 22/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//
#import "Masonry.h"
#import "ViewController.h"
#import "MyRootTableViewController.h"
NSString* _i03 = @"0";
@interface Model:NSObject{
    NSString* _str;
    int _i01;
}
@property (nonatomic, strong) NSString* uId;
@property (nonatomic, copy) Model* model;
@property (nonatomic, copy) void (^callBack)(void);
@end
@implementation Model
-(instancetype)init{
    self = [super init];
    self.uId = [NSString stringWithFormat:@"str"];
    _i01 = 0;
    return self;
}
-(void)setModel{
    NSString* _i02 = @"0";
    self.model = [[Model alloc] init];
    [self.model setCallBack:^{
        _str = self.model.uId;
        NSLog(@"i is %d %@ %@",_i01,_i02,_i03);
    }];
    _i01 = 1;
    _i02 = @"1";
    _i03 = @"1";
    self.model.uId = [NSString stringWithFormat:@"str01"];
    self.model.callBack();
    BOOL b = YES;
    while (b) {
        NSLog(@"self %@ %@,self.model %@ %@", self.uId, self->_str, self.model.uId, self.model->_str);
        if (_str) {
            b = NO;
        }
    }
}
@end

@interface ViewController ()
@property (nonatomic, strong) MyRootTableViewController* myRootTableVC;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.myRootTableVC = [[MyRootTableViewController alloc] init];
//    self.myRootTableVC.view.frame = self.view.bounds;
//    [self.view addSubview:self.myRootTableVC.view];
    
//    Model * m = [[Model alloc] init];
//    [m setModel];
    
//    [self testCopy];
    
//    [self testArr];
    CGSize imSize = CGSizeMake(300, 100);
    UIImage * im = [self createTeamGoldRateImgWithBlueGold:@"200" RedGold:@"100" Size:imSize];
    UIImageView *imv = [[UIImageView alloc] initWithImage:im];
    [self.view addSubview:imv];
    __weak typeof(self) weakSelf = self;
    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(imSize);
    }];
}

-(UIImage *)createTeamGoldRateImgWithBlueGold:(NSString *) blueGold RedGold:(NSString *) redGold Size:(CGSize) drawSize
{
    
    UIColor * blueColor = [UIColor colorWithRed:0/255.00 green:169/255.00 blue:184/255.00 alpha:1];
    UIColor * lightblueColor = [UIColor colorWithRed:139/255.00 green:226/255.00 blue:226/255.00 alpha:0.8];
    UIColor * redColor = [UIColor colorWithRed:255/255.00 green:105/255.00 blue:109/255.00 alpha:1];
    UIColor * lightredColor = [UIColor colorWithRed:240/255.00 green:150/255.00 blue:150/255.00 alpha:0.8];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(drawSize.width, drawSize.height), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat rate = blueGold.floatValue/(blueGold.floatValue+redGold.floatValue);
    CGFloat colorLocations[2] = {0.0,1.0};  //渐变系数：0.0~1.0
    //创建CGMutablePathRef
    CGMutablePathRef path01 = CGPathCreateMutable();
    
    CGPathMoveToPoint(path01, NULL, 0, 0);
    CGPathAddLineToPoint(path01, NULL, drawSize.width*rate - 10, 0);
    CGPathAddLineToPoint(path01, NULL, drawSize.width*rate + 10, drawSize.height);
    CGPathAddLineToPoint(path01, NULL, 0, drawSize.height);
    CGPathCloseSubpath(path01);
    NSArray * blueColors = @[(__bridge id) blueColor.CGColor, (__bridge id) lightblueColor.CGColor];
    CGGradientRef gradient01 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) blueColors, colorLocations);
    //或者CGGradientCreateWithColorComponents创建CGGradientRef
    //CGFloat colors[] =
    //{
    //[[blueColor objectAtIndex:0] floatValue]/255.00, [[blueColor objectAtIndex:1] floatValue]/255.00, [[blueColor objectAtIndex:2] floatValue]/255.00, [[blueColor objectAtIndex:3] floatValue],//blueColor color(r,g,b,alpha)
    //[[lightblueColor objectAtIndex:0] floatValue]/255.00, [[lightblueColor objectAtIndex:1] floatValue]/255.00, [[lightblueColor objectAtIndex:2] floatValue]/255.00, [[lightblueColor objectAtIndex:3] floatValue],//lightblueColor color(r,g,b,alpha)
    //};
    //CGGradientRef gradient01 = CGGradientCreateWithColorComponents(colorSpace, colors, colorLocations, sizeof(colorLocations)/sizeof(colorLocations[0]));
    CGRect pathRect01 = CGPathGetBoundingBox(path01);     //获取path的CGRect
    CGPoint startPoint01 = CGPointMake(CGRectGetMaxX(pathRect01), CGRectGetMinY(pathRect01));
    CGPoint endPoint01 = CGPointMake(CGRectGetMaxX(pathRect01), CGRectGetMaxY(pathRect01));
    CGContextSaveGState(con);
    CGContextAddPath(con, path01);
    //设置路径颜色
    CGContextSetStrokeColorWithColor(con, blueColor.CGColor);
//    CGContextStrokePath(con);
    [blueColor setFill];
    CGContextFillPath(con);
//    CGContextClip(con);
    //创建一个线性渐变
//    CGContextDrawLinearGradient(con, gradient01, startPoint01, endPoint01, 0);
//    CGGradientRelease(gradient01);
    CGContextRestoreGState(con);
    CGPathRelease(path01);
    
//    CGMutablePathRef path02 = CGPathCreateMutable();
//    CGPathMoveToPoint(path02, NULL, drawSize.width, 0);
//    CGPathAddLineToPoint(path02, NULL, drawSize.width*rate - 10, 0);
//    CGPathAddLineToPoint(path02, NULL, drawSize.width*rate + 10, drawSize.height);
//    CGPathAddLineToPoint(path02, NULL, drawSize.width, drawSize.height);
//    CGPathCloseSubpath(path02);
//    NSArray * redColors = @[(__bridge id) redColor.CGColor, (__bridge id) lightredColor.CGColor];
//    CGGradientRef gradient02 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) redColors, colorLocations);
//    CGRect pathRect02 = CGPathGetBoundingBox(path02);
//    CGPoint startPoint02 = CGPointMake(CGRectGetMaxX(pathRect02), CGRectGetMinY(pathRect02));
//    CGPoint endPoint02 = CGPointMake(CGRectGetMaxX(pathRect02), CGRectGetMaxY(pathRect02));
//    CGContextSaveGState(con);
//    CGContextAddPath(con, path02);
//    CGContextClip(con);
//    CGContextDrawLinearGradient(con, gradient02, startPoint02, endPoint02, 0);
//    CGGradientRelease(gradient02);
//    CGContextRestoreGState(con);
//    CGPathRelease(path02);
    
    CGColorSpaceRelease(colorSpace);
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return im;
}
-(void)testArr{
    int a[5] = {1,2,3,4,5};
    int* ptr = (int*)(&a+1);
    int* ptr2 = (int*)(&ptr+1);
    printf("a %d size %d, ptr %d size %d,ptr2 %d size %d,int size %d", *(a+1),sizeof(a),*(ptr-1),sizeof(ptr),*(ptr2-6),sizeof(ptr2), sizeof(int));
}
-(void)testCopy{
    NSArray*array01 = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    NSArray*copyArray01 = [array01 copy];
    NSMutableArray*mCopyArray01 = [array01 mutableCopy];
    
    NSMutableArray*array02 = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    NSArray*copyArray02 = [array02 copy];
    NSMutableArray*mCopyArray02 = [array02 mutableCopy];
    
    NSLog(@"\n array01 %p %p %@ %ld\n coptArray01 %p %p %@ %ld\n mcoptArra01 %p %p %@ %ld\n array02 %p %p %@ %ld\n coptArray02 %p %p  %@ %ld\n mcoptArra02 %p %p %@ %ld", array01, array01[0], array01[0], array01.count, copyArray01, copyArray01[0],  copyArray01[0], copyArray01.count, mCopyArray01, mCopyArray01[0],  mCopyArray01[0], mCopyArray01.count, array02, array02[0],  array02[0], array02.count, copyArray02, copyArray02[0],  copyArray02[0], copyArray02.count, mCopyArray02, mCopyArray02[0], mCopyArray02[0], mCopyArray02.count);
    [mCopyArray01 addObject:@"d"];
    [mCopyArray02 addObject:@"d"];
    NSMutableString * mstr01 = mCopyArray01[0];
    NSMutableString * mstr02 = mCopyArray02[0];
    [mstr01 appendString:@"b"];
    [mstr02 appendString:@"b"];
    NSLog(@"\n array01 %p %p %@ %ld\n coptArray01 %p %p %@ %ld\n mcoptArra01 %p %p %@ %ld\n array02 %p %p %@ %ld\n coptArray02 %p %p  %@ %ld\n mcoptArra02 %p %p %@ %ld", array01, array01[0], array01[0], array01.count, copyArray01, copyArray01[0],  copyArray01[0], copyArray01.count, mCopyArray01, mCopyArray01[0],  mCopyArray01[0], mCopyArray01.count, array02, array02[0],  array02[0], array02.count, copyArray02, copyArray02[0],  copyArray02[0], copyArray02.count, mCopyArray02, mCopyArray02[0], mCopyArray02[0], mCopyArray02.count);
    
    NSMutableString* str01 =[NSMutableString stringWithFormat:@"a"];
    NSString* copyStr01 = [str01 copy];
    NSMutableString* mCopyStr01 = [str01 mutableCopy];
    NSString* str02 =[NSString stringWithFormat:@"a"];
    NSString* copyStr02 = [str02 copy];
    NSMutableString* mCopyStr02 = [str02 mutableCopy];
    NSLog(@"\n str01 %p %ld %@\n copyStr01 %p %ld %@\n mCopyStr01 %p %ld %@\n str02 %p %ld %@\n copyStr02 %p %ld %@\n mCopyStr02 %p %ld %@", str01, str01.length, str01, copyStr01, copyStr01.length, copyStr01, mCopyStr01, mCopyStr01.length, mCopyStr01, str02, str02.length, str02, copyStr02, copyStr02.length, copyStr02, mCopyStr02, mCopyStr02.length, mCopyStr02);
    [mCopyStr01 appendString:@"b"];
    [mCopyStr02 appendString:@"b"];
    NSLog(@"\n str01 %p %ld %@\n copyStr01 %p %ld %@\n mCopyStr01 %p %ld %@\n str02 %p %ld %@\n copyStr02 %p %ld %@\n mCopyStr02 %p %ld %@", str01, str01.length, str01, copyStr01, copyStr01.length, copyStr01, mCopyStr01, mCopyStr01.length, mCopyStr01, str02, str02.length, str02, copyStr02, copyStr02.length, copyStr02, mCopyStr02, mCopyStr02.length, mCopyStr02);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


