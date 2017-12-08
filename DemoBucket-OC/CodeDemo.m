//
//  CodeDemo.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 06/12/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

/*
 TabBar
 向UITabBarController设置Controller
 UIViewController *VC01 = [[UIViewController alloc] init];
 UIViewController *VC02 = [[UIViewController alloc] init];
 NSArray *VCArr = [NSArray arrayWithObjects:VC01, VC02, nil];
 [self setViewControllers:VCArr];
 设置UITabBarItem的消息数量(badgeValue)
 UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
 tabBarItem.badgeColor = [UIColor blueColor];
 tabBarItem.badgeValue = [NSString stringWithFormat:@"5"];
 点击UITabBarItem时Delegate的回调方法
 - (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
 
 
 
 
 
 Navigation
 转场：
 通过NavigationController从VC01(self)转场到VC02,即将VC02压入栈顶
 UIViewController *VC02 = [[UIViewController alloc] init];
 [self.navigationController pushViewController:VC02 animated:YES];
  通过NavigationController从VC02(self)反向转场到VC01，VC01需要是之前已经被压入(pushViewController:)栈中的，这样VC01之上的所有Controller都会出栈
 [self.navigationController popViewController:VC animated:YES];
 通过NavigationController出栈栈顶的Controller
 [self.navigationController  popViewControllerAnimated:YES];
 通过NavigationController转场到RootViewController
 [self.navigationController  popToRootViewControllerAnimated:YES];

 添加Navigation中Button：
 UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"Non-Gravity"] style:UIBarButtonItemStyleDone target:self action:@selector(configGravity:)];
 self.navigationItem.rightBarButtonItem = barButton;
 自定义Navigation中Button的样式
 UIButton *button = [[UIButton alloc] init];
 配置Button
 UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
 设置Navigation的title
 self.navigationItem.title = [NSString stringWithFormat:@"CustomTitle"];
 
 
 
 
 
 转场的方法
 Navigation中含有转场的方法
 可用presentViewController:从VC01转场到VC02，以及可用dismissViewController:进行反向转场
 对于VC01(self)
 UIViewController *VC02 = [[UIViewController alloc] init];
 [self.myRootTableViewController presentViewController:VC02 animated:NO completion:^{
 NSLog(@"present complete");
 }];
 对于VC02(self)
 [self dismissViewControllerAnimated:YES completion:^{
 NSLog(@"dismiss complete");
 }];
 
 
 
 
 
 UITableView
 UITableViewStyle: UITableViewStylePlain无特别处 UITableViewStyleGrouped依据Section来分组Cell
 UITableViewCellStyle: UITableViewCellStyleDefault只会显示TextLabel内容 UITableViewCellStyleSubtitle&UITableViewCellStyleValue1&UITableViewCellStyleValue2以不同方式显示TextLabel和detailTextLabel内容
IOS11中废弃了automaticallyAdjustsScrollViewInsets废弃,代替方法是contentInsetAdjustmentBehavior
 self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
 UIScrollViewContentInsetAdjustmentAutomatic(Default)：如果scrollview在一个automaticallyAdjustsScrollViewInsets = YES的controller上，并且这个Controller包含在一个navigation controller中，这种情况下会设置在top & bottom上 adjustedContentInset = safeAreaInset + contentInset不管是否滚动。其他情况下与UIScrollViewContentInsetAdjustmentScrollableAxes相同
 UIScrollViewContentInsetAdjustmentScrollableAxes: 在可滚动方向上adjustedContentInset = safeAreaInset + contentInset，在不可滚动方向上adjustedContentInset = contentInset；依赖于scrollEnabled和alwaysBounceHorizontal / vertical = YES，scrollEnabled默认为yes，所以大多数情况下，计算方式还是adjustedContentInset = safeAreaInset + contentInset
 UIScrollViewContentInsetAdjustmentNever: adjustedContentInset = contentInset
 UIScrollViewContentInsetAdjustmentAlways: adjustedContentInset = safeAreaInset + contentInset
 
 
 
 
 
 Masnory
 需要先将subView添加入superView，否则会报错
 将Masonry布局约束写入updateViewConstraints[UIViewController]或者updateConstraints[UIView]中并以[super updateViewConstraints]或[super updateConstraints]结束;，然后将[self.view setNeedsUpdateConstraints]和[self.view updateConstraintsIfNeeded]写入viewWillLayoutSubviews中比较好
 新增约束
  - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
 更新约束
  - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
 清楚之前的所有约束,只会保留最新的约束
  - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
 居中设置
 垂直居中：make.centerY.mas_equalTo(self.window.mas_centerY)
 水平居中：make.centerX.mas_equalTo(self.window.mas_centerX)
 全屏居中：make.center.equalTo(self.window)
 边界设置
 上边界：make.top.equalTo(self.window).with.offset(15.0)
 左边界：make.left.equalTo(self.window).with.offset(15.0)
 下边界：make.bottom.equalTo(self.window).with.offset(-15.0)
 右边界：make.right.equalTo(self.window).with.offset(-15.0)
 或：
 上边界：make.top.mas_equalTo(15.0)
 左边界：make.left.mas_equalTo(15.0)
 下边界：make.bottom.mas_equalTo(-15.0)
 右边界：make.right.mas_equalTo(-15.0)
 或：
 上边界、左边界：make.top.left.mas_equalTo(15.0)
 下边界、右边界：make.bottom.right.mas_equalTo(-15.0)
 或：make.top.left.bottom.and.right.equalTo(self.window).with.insets(UIEdgeInsetsMake(15.0,15.0,15.0,15.0))
 或：make.edges.equalTo(self.window).with.insets(UIEdgeInsetsMake(15.0,15.0,15.0,15.0))
 与另一个视图的边界间距设置
 与另一个视图右部边界间距：make.right.mas_equalTo(currentView.mas_left).offset(10.0);
 与另一个视图底部边界间距：make.top.mas_equalTo(currentView.mas_bottom).offset(10.0);
 倍数设置
 设置宽度为self.view的一半，multipliedBy是倍数的意思，也就是，使宽度等于self.view宽度的0.5倍
 make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
 设置高度为self.view高度的一半
 make.height.equalTo(self.view.mas_height).multipliedBy(0.5);
 大小设置
 宽：
 make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
 或：make.width. mas_equalTo(320.0).multipliedBy(0.5);
 或：make.width. mas_equalTo(160.0);
 高：make.height.equalTo(self.view.mas_height).multipliedBy(0.5);
 或：make.height. mas_equalTo(320.0).multipliedBy(0.5);
 或：make.height. mas_equalTo(160.0);
 size：make.size. mas_equalTo(CGSizeMake(300.0,50.0));
 或：make.size.equalTo(view);
 或：make.size.mas_equalTo(CGSizeMake(150.0,50.0)).multipliedBy(0.5);
 注意：
 1、equalTo与mas_equalTo有什么区别？
 equalTo比较的是view；
 mas_equalTo比较的是数值。
 
 
 
 
 
 SafeAreaInsets
 对于UIViewController的回调：-(void)viewSafeAreaInsetsDidChange 对于UIView的回调：-(void)safeAreaInsetsDidChange 回调方法的调用时机
 2017-10-04 16:59:59.594811+0800 XXX[15662:803767] Begin pushViewController to [<_TtCC8XXXTests27ContainerViewControllerTest20MockUIViewController: 0x7f9c07b643b0>]
 viewDidLoad()---Optional("pushVC")---UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
 willMove(toParentViewController:)---Optional("pushVC")---UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
 viewWillDisappear---Optional("rootVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewWillAppear---Optional("pushVC")---UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
 viewSafeAreaInsetsDidChange()---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewWillLayoutSubviews()---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewDidLayoutSubviews()---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewWillLayoutSubviews()---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewDidLayoutSubviews()---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewDidAppear---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 viewDidDisappear---Optional("rootVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 didMove(toParentViewController:)---Optional("pushVC")---UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
 2017-10-04 16:59:59.604563+0800 XXX[15662:803767] Did PushViewController [<_TtCC8XXXTests27ContainerViewControllerTest20MockUIViewController: 0x7f9c0790d170>]->[<_TtCC8XXXTests27ContainerViewControllerTest20MockUIViewController: 0x7f9c07b643b0>] time = [0.009772]
 SafeAreaInsets在viewSafeAreaInsetsDidChange之前为(0,0,0,0)，之后才会更新成适合的值，所以一些基于SafeAreaInsets的布局不能写在viewDidLoad中，可写到SafeAreaInsets回调后的viewWillLayoutSubviews中
 
 
 
 
 
 UIDynamicAnimator：
 UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:superView];   // 在superView中模拟动态
 [animator addBehavior:behavior];   // 在动态动画中添加行为
 animator.running  //BOOL属性，判断动画是否正在进行
 
 UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:subView snapToPoint:point];     //吸附行为
 snap.damping = 0.5;  //设置阻尼 from 0.0 to 1.0. 1.0 is the least oscillation.
 
 UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[subView] mode:UIPushBehaviorModeInstantaneous];    //推动行为 UIPushBehaviorModeContinuous  力是连续的 UIPushBehaviorModeInstantaneous  力是瞬时的
 push.angle = angle;  //设置推力角度
 push.magnitude = distance/10;  //设置推力量级
 [self.push setPushDirection:CGVectorMake(offsetPoint.x/10, offsetPoint.y/10)];  //设置推力向量，同时设置了推力的角度和量级
 push.active = YES;  //激活推力
 
 UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:subView offsetFromCenter:offset attachedToAnchor:anchorPoint];   //附着行为
 attachment.damping = 0.1;  //设置阻尼 from 0.0 to 1.0. 1.0 is the least oscillation.
 attachment.frequency = 1.0;  //设置振幅
 
 UIGravityBehavior * gravity = [[UIGravityBehavior alloc] initWithItems:[NSArray arrayWithObject:subView]];   //添加重力
 push.angle = angle;  //设置重力角度
 push.magnitude = 1.0;  //设置重力量级
 gravity.gravityDirection = CGVectorMake(0.0, 1.0)  //设置重力向量，同时设置了重力的角度和量级 The default value for the gravity vector is (0.0, 1.0) The acceleration for a dynamic item subject to a (0.0, 1.0) gravity vector is downwards at 1000 points per second².
 
 UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[subView01， subView02]];   //碰撞检测
 collision.translatesReferenceBoundsIntoBoundary = YES;  //将参考坐标系边界作为碰撞边界
 [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:self.view.safeAreaInsets];  //将参考坐标系边界以UIEdgeInset为偏差作为碰撞边界
 collision.collisionMode = UICollisionBehaviorModeEverything;  //设置碰撞模式
 UICollisionBehaviorModeItems        = 1 << 0,           // items 相互碰撞，没有指定碰撞的边界
 UICollisionBehaviorModeBoundaries   = 1 << 1,          // 指定了碰撞的边界，没有 items 的相互碰撞
 UICollisionBehaviorModeEverything   = NSUIntegerMax    // 指定了碰撞边界 和 items 的相互碰撞 （这个是默认值）
 UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 200, 500)];    // 创建椭圆形路径对象
 path.lineWidth     = 1.f;
 path.lineCapStyle  = kCGLineCapRound;
 path.lineJoinStyle = kCGLineCapRound;
 [collisionBehavior addBoundaryWithIdentifier:@"path1" forPath:path];   //将添加椭圆path作为碰撞边界
 UICollisionBehaviorDelegate实现
 @protocol UICollisionBehaviorDelegate <NSObject>
 @optional
 // 当一个两个动态元素之间发生碰撞时调用
 - (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2 atPoint:(CGPoint)p;
 // 当一个两个动态元素之间碰撞结束时调用
 - (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2;
 
 // 当一个动态元素与边界发生碰撞时调用
 - (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p;
 // 当一个动态元素与边界碰撞结束时调用
 - (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier;
 
 UIDynamicBehavior * dynamicBehavior = [[UIDynamicBehavior alloc] init];  //UIDynamicBehavior为之上行为的父类
 [dynamicBehavior addChildBehavior:behavior]  //可以添加行为
 // When running, the dynamic animator calls the action block on every animation step.
 @property (nullable, nonatomic,copy) void (^action)(void);
 
 
 
 
 
 二维数组、多维数组
 只有第一维的元素数可以省略
 int arr01[] = {1,2,3};
 int arr02[][3] = {
 {1,2,3},
 {4,5,6},
 };
 
 
 
 
 
 运行时RunTime
 关联对象(Associated Object)
 static char kDTActionHandlerTapGestureKey;
 UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
 if (!gesture)
 {
 gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
 [self addGestureRecognizer:gesture];
 objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
 }
 //内存管理策略
 OBJC_ASSOCIATION_ASSIGN
 OBJC_ASSOCIATION_RETAIN_NONATOMIC
 OBJC_ASSOCIATION_COPY_NONATOMIC
 OBJC_ASSOCIATION_RETAIN
 OBJC_ASSOCIATION_COPY
 //关联对象为block时内存管理策略应为COPY
 objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
 // 设置关联对象
 void objc_setAssociatedObject ( id object, const void *key, id value, objc_AssociationPolicy policy );
 // 获取关联对象
 id objc_getAssociatedObject ( id object, const void *key );
 // 移除关联对象
 void objc_removeAssociatedObjects ( id object );
 
操作成员变量
 // 获取所有成员变量
 class_copyIvarList
 // 获取成员变量名
 ivar_getName
 // 获取成员变量类型编码
 ivar_getTypeEncoding
 // 获取指定名称的成员变量
 class_getInstanceVariable
 // 获取某个对象成员变量的值
 object_getIvar
 // 设置某个对象成员变量的值
 object_setIvar
 //Ivar是objc_ivar的指针，包含变量名，变量类型等成员。
 typedef objc_ivar * Ivar;
 struct objc_ivar {
 char *ivar_name;
 char *ivar_type;
 int ivar_offset;
 #ifdef __LP64__
 int space;
 #endif
 }
 //遍历获取Person类所有的成员变量IvarList
 - (void) getAllIvarList {
 unsigned int methodCount = 0;
 Ivar * ivars = class_copyIvarList([Person class], &methodCount);
 for (unsigned int i = 0; i < methodCount; i ++) {
 Ivar ivar = ivars[i];
 const char * name = ivar_getName(ivar);
 const char * type = ivar_getTypeEncoding(ivar);
 NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
 }
 free(ivars);
 }
 
 操作属性
 // 获取所有属性
 class_copyPropertyList
 说明：使用class_copyPropertyList并不会获取无@property声明的成员变量
 // 获取属性名
 property_getName
 // 获取属性特性描述字符串
 property_getAttributes
 // 获取所有属性特性
 property_copyAttributeList
 //objc_property_attribute_t定义了属性的特性(attribute)，它是一个结构体，定义如下：
 typedef struct {
 const
 char *name;
 // 特性名
 const
 char *value;
 // 特性值
 } objc_property_attribute_t;
 //遍历获取所有属性Property
 - (void) getAllProperty {
 unsigned int propertyCount = 0;
 objc_property_t *propertyList = class_copyPropertyList([Person class], &propertyCount);
 for (unsigned int i = 0; i < propertyCount; i++ ) {
 objc_property_t thisProperty = propertyList[i];
 const char* propertyName = property_getName(thisProperty);
 NSLog(@"Person拥有的属性为: '%s'", propertyName);
 }
 }
 
 操作方法
 方法交换
 + (void)load {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 Class class = [self class];
 SEL originalSelector = @selector(viewWillAppear:);
 SEL swizzledSelector = @selector(xxx_viewWillAppear:);
 Method originalMethod = class_getInstanceMethod(class, originalSelector);
 Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
 // 如果 swizzling 的是类方法, 采用如下的方式:
 // Class class = object_getClass((id)self);
 // ...
 // Method originalMethod = class_getClassMethod(class, originalSelector);
 // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
 //交换实现,现将原selector-交换method方法对添加入对象
 BOOL didAdd = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
 if (didAdd) {
 //如果添加成功，将交换selector的方法替换成原method
 class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
 }else
 {
 //如果添加失败，则代表交换method已经加入过了，直接交换原method和交换method
 method_exchangeImplementations(originalMethod, swizzledMethod);
 }
 });
 }
 #pragma mark - Method Swizzling
 - (void)xxx_viewWillAppear:(BOOL)animated {
 [self xxx_viewWillAppear:animated];
 NSLog(@"viewWillAppear: %@", self);
 }
 
 
 
 
 
 NSArray排序和过滤
 NSArray * herosInfoArrModel = herosInfoDic.allValues;
 NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"totalNum"ascending:NO];
 NSArray * herosInfoArr = [herosInfoArrModel sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor1]];
 NSArray提供了如下方法使用谓词来过滤集合
 - (NSArray*)filteredArrayUsingPredicate:(NSPredicate *)predicate:使用指定的谓词过滤NSArray集合，返回符合条件的元素组成的新集合
 NSMutableArray提供了如下方法使用谓词来过滤集合
 - (void)filterUsingPredicate:(NSPredicate *)predicate：使用指定的谓词过滤NSMutableArray，剔除集合中不符合条件的元素
 NSSet提供了如下方法使用谓词来过滤集合
 - (NSSet*)filteredSetUsingPredicate:(NSPredicate *)predicate NS_AVAILABLE(10_5, 3_0)：作用同NSArray中的方法
 NSMutableSet提供了如下方法使用谓词来过滤集合
 - (void)filterUsingPredicate:(NSPredicate *)predicate NS_AVAILABLE(10_5, 3_0)：作用同NSMutableArray中的方法。
 
 
 
 
 
 CoreData操作数据
 新建NSManagedObjectContext
 AppDelegate * appDe = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 NSManagedObjectContext *parentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
 [parentContext setParentContext:appDe.persistentContainer.viewContext];
 查询获取
 NSError * errMatche01;
 //抓取实体
 NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MatchList_EN"];
 //抓取谓词
 NSPredicate * predicate = [NSPredicate predicateWithFormat:@"accountId == %@", [[self getSummonerInfo_EN] objectForKey:@"accountId"]];
 [fetchRequest setPredicate:predicate];
 //排序
 NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:@"gameId" ascending:NO];
 [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
 NSArray * matchesResults=[parentContext executeFetchRequest:fetchRequest error:&errMatche01];
 写入数据
 [parentContext performBlockAndWait:^{
 MatchList_EN * MatchList_ENEntity = [[MatchList_EN alloc] initWithEntity:[NSEntityDescription entityForName:@"MatchList_EN" inManagedObjectContext:parentContext] insertIntoManagedObjectContext:parentContext];
 MatchList_ENEntity.summonerName = value；
[MatchList_ENEntity setValue:value forKey:key];
 if ([self saveContext:parentContext withErr:err postNotificationName:@"insertENMatchListWithData" object:NULL userInfo:NULL]) {
 NSLog(@"写入成功：MatchList_EN");
 NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
 NSLog(@"路径是：%@",docPath);
 }else
 {
 [NSException raise:@"写入错误" format:@"错误是%@",[err localizedDescription]];
 }
 }
 
 
 
 
 
 谓词NSPredicate
 1.可用比较运算符
 =、==：判断两个表达式是否相等，在谓词中=和==是相同的意思都是判断，而没有赋值这一说
 >=，=>：判断左边表达式的值是否大于或等于右边表达式的值
 <=，=<：判断右边表达式的值是否小于或等于右边表达式的值
 >：判断左边表达式的值是否大于右边表达式的值
 <：判断左边表达式的值是否小于右边表达式的值
 !=、<>：判断两个表达式是否不相等
 BETWEEN：BETWEEN表达式必须满足表达式 BETWEEN {下限，上限}的格式，要求该表达式必须大于或等于下限，并小于或等于上限
 2.可用逻辑运算符
 AND、&&：逻辑与，要求两个表达式的值都为YES时，结果才为YES。
 OR、||：逻辑或，要求其中一个表达式为YES时，结果就是YES
 NOT、 !：逻辑非，对原有的表达式取反
3.可用字符串比较运算符
 BEGINSWITH：检查某个字符串是否以指定的字符串开头（如判断字符串是否以a开头：BEGINSWITH 'a'）
 ENDSWITH：检查某个字符串是否以指定的字符串结尾
 CONTAINS：检查某个字符串是否包含指定的字符串
 LIKE：检查某个字符串是否匹配指定的字符串模板。其之后可以跟?代表一个字符和*代表任意多个字符两个通配符。比如"name LIKE '*ac*'"，这表示name的值中包含ac则返回YES；"name LIKE '?ac*'"，表示name的第2、3个字符为ac时返回YES。
 MATCHES：检查某个字符串是否匹配指定的正则表达式。虽然正则表达式的执行效率是最低的，但其功能是最强大的，也是我们最常用的。
 在NSPredicate输入[`~!@]正则表达式时和写成^[`~!@]$的效果是一样的
 4.可用集合运算符
 ANY、SOME：集合中任意一个元素满足条件，就返回YES。
 ALL：集合中所有元素都满足条件，才返回YES。
 NONE：集合中没有任何元素满足条件就返回YES。如:NONE person.age < 18，表示person集合中所有元素的age>=18时，才返回YES。
 IN：等价于SQL语句中的IN运算符，只有当左边表达式或值出现在右边的集合中才会返回YES。我们通过一个例子来看一下
 示例
 NSArray *filterArray = @[@"ab", @"abc"];
 NSArray *array = @[@"a", @"ab", @"abc", @"abcd"];
 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filterArray];
 NSLog(@"%@", [array filteredArrayUsingPredicate:predicate]);
 输出为( a, abcd )
 5.可用直接量
 在谓词表达式中可以使用如下直接量
 FALSE、NO：代表逻辑假
 TRUE、YES：代表逻辑真
 NULL、NIL：代表空值
 SELF：代表正在被判断的对象自身
 "string"或'string'：代表字符串
 数组：和c中的写法相同，如：{'one', 'two', 'three'}。
 数值：包括证书、小数和科学计数法表示的形式
 十六进制数：0x开头的数字
 八进制：0o开头的数字
 二进制：0b开头的数字
 6.可用保留字
 下列单词都是保留字（不论大小写）
 AND、OR、IN、NOT、ALL、ANY、SOME、NONE、LIKE、CASEINSENSITIVE、CI、MATCHES、CONTAINS、BEGINSWITH、ENDSWITH、BETWEEN、NULL、NIL、SELF、TRUE、YES、FALSE、NO、FIRST、LAST、SIZE、ANYKEY、SUBQUERY、CAST、TRUEPREDICATE、FALSEPREDICATE
 注：虽然大小写都可以，但是更推荐使用大写来表示这些保留字
 7.在谓词中使用占位符参数%k,%@以及动态值%VALUE
 %K：用于动态传入属性名
 %@：用于动态设置属性值
 $VALUE：一个可以动态变化的值
 NSArray *array = @[[ZLPersonModel personWithName:@"Jack" age:20 sex:ZLPersonSexMale],
 [ZLPersonModel personWithName:@"Rose" age:22 sex:ZLPersonSexFamale],
 [ZLPersonModel personWithName:@"Jackson" age:30 sex:ZLPersonSexMale],
 [ZLPersonModel personWithName:@"Johnson" age:35 sex:ZLPersonSexMale]];
 //  定义一个property来存放属性名，定义一个value来存放值
 NSString *property = @"name";
 NSString *value = @"Jack";
 //  该谓词的作用是如果元素中property属性含有值value时就取出放入新的数组内，这里是name包含Jack
 NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K CONTAINS %@", property, value];
 NSArray *newArray = [array filteredArrayUsingPredicate:pred];
 NSLog(@"newArray:%@", newArray);
 
 //  创建谓词，属性名改为age，要求这个age包含$VALUE字符串
 NSPredicate *predTemp = [NSPredicate predicateWithFormat:@"%K > $VALUE", @"age"];
 // 指定$SUBSTR的值为 25    这里注释中的$SUBSTR改为$VALUE
 NSPredicate *pred1 = [predTemp predicateWithSubstitutionVariables:@{@"VALUE" : @25}];
 NSArray *newArray1 = [array filteredArrayUsingPredicate:pred1];
 NSLog(@"newArray1:%@", newArray1);
 
 //  修改 $SUBSTR的值为32，  这里注释中的SUBSTR改为$VALUE
 NSPredicate *pred2 = [predTemp predicateWithSubstitutionVariables:@{@"VALUE" : @32}];
 NSArray *newArray2 = [array filteredArrayUsingPredicate:pred2];
 NSLog(@"newArray2:%@", newArray2);
 输出为
 2016-01-07 17:28:02.062 PredicteDemo[14542:309494] newArray:(
 "[name = Jack, age = 20, sex = 0]",
 "[name = Jackson, age = 30, sex = 0]"
 )
 2016-01-07 17:28:02.063 PredicteDemo[14542:309494] newArray1:(
 "[name = Jackson, age = 30, sex = 0]",
 "[name = Johnson, age = 35, sex = 0]"
 )
 2016-01-07 17:28:02.063 PredicteDemo[14542:309494] newArray2:(
 "[name = Johnson, age = 35, sex = 0]"
 )
 
 
 
 
 
 正则表达式
 要匹配圆括号字符，请使用“\(”或“\)”。
 强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$
 一、校验数字的表达式
 1 数字：^[0-9]*$
 2 n位的数字：^\d{n}$
 3 至少n位的数字：^\d{n,}$
 4 m-n位的数字：^\d{m,n}$
 5 零和非零开头的数字：^(0|[1-9][0-9]*)$
 6 非零开头的最多带两位小数的数字：^([1-9][0-9]*)+(.[0-9]{1,2})?$
 7 带1-2位小数的正数或负数：^(\-)?\d+(\.\d{1,2})?$
 8 正数、负数、和小数：^(\-|\+)?\d+(\.\d+)?$
 9 有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
 10 有1~3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
 11 非零的正整数：^[1-9]\d*$ 或 ^([1-9][0-9]*){1,3}$ 或 ^\+?[1-9][0-9]*$
 12 非零的负整数：^\-[1-9][]0-9"*$ 或 ^-[1-9]\d*$
 13 非负整数：^\d+$ 或 ^[1-9]\d*|0$
 14 非正整数：^-[1-9]\d*|0$ 或 ^((-\d+)|(0+))$
 15 非负浮点数：^\d+(\.\d+)?$ 或 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$
 16 非正浮点数：^((-\d+(\.\d+)?)|(0+(\.0+)?))$ 或 ^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$
 17 正浮点数：^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$ 或 ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 18 负浮点数：^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$ 或 ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
 19 浮点数：^(-?\d+)(\.\d+)?$ 或 ^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$
 二、校验字符的表达式
 1 汉字：^[\u4e00-\u9fa5]{0,}$
 2 英文和数字：^[A-Za-z0-9]+$ 或 ^[A-Za-z0-9]{4,40}$
 3 长度为3-20的所有字符：^.{3,20}$
 4 由26个英文字母组成的字符串：^[A-Za-z]+$
 5 由26个大写英文字母组成的字符串：^[A-Z]+$
 6 由26个小写英文字母组成的字符串：^[a-z]+$
 7 由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$
 8 由数字、26个英文字母或者下划线组成的字符串：^\w+$ 或 ^\w{3,20}$
 9 中文、英文、数字包括下划线：^[\u4E00-\u9FA5A-Za-z0-9_]+$
 10 中文、英文、数字但不包括下划线等符号：^[\u4E00-\u9FA5A-Za-z0-9]+$ 或 ^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$
 11 可以输入含有^%&',;=?$\"等字符：[^%&',;=?$\x22]+
 12 禁止输入含有~的字符：[^~\x22]+
 三、特殊需求表达式
 1 Email地址：^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
 2 域名：[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?
 3 InternetURL：[a-zA-z]+://[^\s]* 或 ^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$
 4 手机号码：^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$
 5 电话号码("XXX-XXXXXXX"、"XXXX-XXXXXXXX"、"XXX-XXXXXXX"、"XXX-XXXXXXXX"、"XXXXXXX"和"XXXXXXXX)：^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$
 6 国内电话号码(0511-4405222、021-87888822)：\d{3}-\d{8}|\d{4}-\d{7}
 7 身份证号(15位、18位数字)：^\d{15}|\d{18}$
 8 短身份证号码(数字、字母x结尾)：^([0-9]){7,18}(x|X)?$ 或 ^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$
 9 帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 10 密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)：^[a-zA-Z]\w{5,17}$
 11 强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$
 12 日期格式：^\d{4}-\d{1,2}-\d{1,2}
 13 一年的12个月(01～09和1～12)：^(0?[1-9]|1[0-2])$
 14 一个月的31天(01～09和1～31)：^((0?[1-9])|((1|2)[0-9])|30|31)$
 15 钱的输入格式：
 16 1.有四种钱的表示形式我们可以接受:"10000.00" 和 "10,000.00", 和没有 "分" 的 "10000" 和 "10,000"：^[1-9][0-9]*$
 17 2.这表示任意一个不以0开头的数字,但是,这也意味着一个字符"0"不通过,所以我们采用下面的形式：^(0|[1-9][0-9]*)$
 18 3.一个0或者一个不以0开头的数字.我们还可以允许开头有一个负号：^(0|-?[1-9][0-9]*)$
 19 4.这表示一个0或者一个可能为负的开头不为0的数字.让用户以0开头好了.把负号的也去掉,因为钱总不能是负的吧.下面我们要加的是说明可能的小数部分：^[0-9]+(.[0-9]+)?$
 20 5.必须说明的是,小数点后面至少应该有1位数,所以"10."是不通过的,但是 "10" 和 "10.2" 是通过的：^[0-9]+(.[0-9]{2})?$
 21 6.这样我们规定小数点后面必须有两位,如果你认为太苛刻了,可以这样：^[0-9]+(.[0-9]{1,2})?$
 22 7.这样就允许用户只写一位小数.下面我们该考虑数字中的逗号了,我们可以这样：^[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?$
 23 8.1到3个数字,后面跟着任意个 逗号+3个数字,逗号成为可选,而不是必须：^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$
 24 备注：这就是最终结果了,别忘了"+"可以用"*"替代如果你觉得空字符串也可以接受的话(奇怪,为什么?)最后,别忘了在用函数时去掉去掉那个反斜杠,一般的错误都在这里
 25 xml文件：^([a-zA-Z]+-?)+[a-zA-Z0-9]+\\.[x|X][m|M][l|L]$
 26 中文字符的正则表达式：[\u4e00-\u9fa5]
 27 双字节字符：[^\x00-\xff] (包括汉字在内，可以用来计算字符串的长度(一个双字节字符长度计2，ASCII字符计1))
 28 空白行的正则表达式：\n\s*\r (可以用来删除空白行)
 29 HTML标记的正则表达式：<(\S*?)[^>]*>.*?</\1>|<.*? /> (网上流传的版本太糟糕，上面这个也仅仅能部分，对于复杂的嵌套标记依旧无能为力)
 30 首尾空白字符的正则表达式：^\s*|\s*$或(^\s*)|(\s*$) (可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式)
 31 腾讯QQ号：[1-9][0-9]{4,} (腾讯QQ号从10000开始)
 32 中国邮政编码：[1-9]\d{5}(?!\d) (中国邮政编码为6位数字) 33 IP地址：\d+\.\d+\.\d+\.\d+ (提取IP地址时有用) 34 IP地址：((?:(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d))
 
 
 
 
 
 CoreGraphics画图
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
 //CGContextSetStrokeColorWithColor(con, lightGray.CGColor);
 //CGContextStrokePath(con);
 //设置path区域填充颜色
 //[blueColor setFill];
 //CGContextFillPath(con);
 CGContextClip(con);
 //创建一个线性渐变
 CGContextDrawLinearGradient(con, gradient01, startPoint01, endPoint01, 0);
 // 创建一个径向渐变
 //CGContextDrawRadialGradient(con, gradient01, startPoint01, startRadius, endPoint01, endRadius, kCGGradientDrawsAfterEndLocation);
 // kCGGradientDrawsBeforeStartLocation = (1 << 0),  //向外渐变       kCGGradientDrawsAfterEndLocation = (1 << 1)       //向里渐变
 CGGradientRelease(gradient01);
 CGContextRestoreGState(con);
 CGPathRelease(path01);
 
 CGMutablePathRef path02 = CGPathCreateMutable();
 CGPathMoveToPoint(path02, NULL, drawSize.width, 0);
 CGPathAddLineToPoint(path02, NULL, drawSize.width*rate - 10, 0);
 CGPathAddLineToPoint(path02, NULL, drawSize.width*rate + 10, drawSize.height);
 CGPathAddLineToPoint(path02, NULL, drawSize.width, drawSize.height);
 CGPathCloseSubpath(path02);
 NSArray * redColors = @[(__bridge id) redColor.CGColor, (__bridge id) lightredColor.CGColor];
 CGGradientRef gradient02 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) redColors, colorLocations);
 CGRect pathRect02 = CGPathGetBoundingBox(path02);
 CGPoint startPoint02 = CGPointMake(CGRectGetMaxX(pathRect02), CGRectGetMinY(pathRect02));
 CGPoint endPoint02 = CGPointMake(CGRectGetMaxX(pathRect02), CGRectGetMaxY(pathRect02));
 CGContextSaveGState(con);
 CGContextAddPath(con, path02);
 CGContextClip(con);
 CGContextDrawLinearGradient(con, gradient02, startPoint02, endPoint02, 0);
 CGGradientRelease(gradient02);
 CGContextRestoreGState(con);
 CGPathRelease(path02);
 
 CGColorSpaceRelease(colorSpace);
 UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 return im;
 }
 
 
 
 
 
 UIBezierPath的基本用法
 APIs
 + (instancetype)bezierPathWithRect:(CGRect)rect;// 矩形
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;// 椭圆
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; // 带圆角度的矩形
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;// 带指定方向圆角度的矩形
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;// 弧线,参数分别为圆弧的中心，半径，开始角度，结束角度，是否顺时针绘制
 - (void)moveToPoint:(CGPoint)point; // 设置线段的起点
 - (void)closePath; // 结束一个图形的subpath，也会连接最后一个点与初始点之间的直线
 // add*系列--定义一个或多个subpaths
 - (void)addLineToPoint:(CGPoint)point;// 添加直线
 - (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise NS_AVAILABLE_IOS(4_0);// 添加弧线
 - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;// 添加二阶曲线
 - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2; // 添加三阶曲线
 
 UIBezierPath *path = [UIBezierPath bezierPath]; //创建
 [path moveToPoint:CGPointMake(100 , 100)]; //设置开始的起点
 [path addLineToPoint:CGPointMake(200, 150)];//添加绘制点subPath
 [path addLineToPoint:CGPointMake(300, 10)]; //添加绘制点subPath
 [path closePath]; //此句可以连接起点和最后一个绘制点
 UIBezierPath *ovalPath =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 20, 20)]；
 [path appendPath:ovalPath];        //添加椭圆路径
 UIBezierPath *rectPath =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 20)]；
 [path appendPath:rectPath];        //添加矩形路径
 [path stroke]; //这句是最关键的，将path绘制出来，如果不写这句，路线将不会绘制出来
 // 实心圆, 以self.center为圆心，50为半径，M_PI_2即90度为开始角度，M_PI即180度为结束为止角度数 逆时针绘制
 [path addArcWithCenter:self.center radius:50 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
 CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50)
 [path applyTransform:transform];        //偏移path的坐标系
 [path setLineWidth:5.0];       设置线宽
 [[UIColor blueColor] setStroke];    //设置线颜色
 [[UIColor redColor] setFill];      //设置填充颜色
 [path stroke];     //填充线颜色
 [path fill];//此方法为填充圆的颜色
 //在path中添加curve    抛物线，以（200，200）为切点  （200，50）为终点
 [path addQuadCurveToPoint:CGPointMake(200, 50) controlPoint:CGPointMake(200, 200)];
 //    抛物线，以（200, 250）终点，（200, 50）和（50, 200）为切点
 [path addCurveToPoint:CGPointMake(200, 250) controlPoint1:CGPointMake(200, 50) controlPoint2:CGPointMake(50, 200)];
 UIBezierPath类包括bezierPathWithRect:和bezierPathWithOvalInRect:方法去创建椭圆或者矩形形状的path。这两个方法都创建了一个新的path对象，并用指定的形状去初始化它们
 如果想在一个存在path对象上添加一个椭圆，则最简单的方法是使用core Graphics。尽管可以使用addQuadCurveToPoint:controlPoint:去创建一个近似的椭圆，core Graphics的CGPathAddEllipseInRect方法非常的简单使用，也更准确。
 Core Graphics函数设置path
 //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
 CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
 //创建CGMutablePathRef
 CGMutablePathRef path = CGPathCreateMutable();
 //左眼
 CGPathAddEllipseInRect(path, &transform, CGRectMake(0, 0, 20, 20));
 //右眼
 CGPathAddEllipseInRect(path, &transform, CGRectMake(80, 0, 20, 20));
 //笑
 CGPathMoveToPoint(path, &transform, 100, 50);
 CGPathAddArc(path, &transform, 50, 50, 50, 0, M_PI, NO);       //添加圆
 //将CGMutablePathRef添加到当前Context内
 CGContextAddPath(gc, path);
 //设置绘图属性
 [[UIColor blueColor] setStroke];
 CGContextSetLineWidth(gc, 2);
 //执行绘画
 CGContextStrokePath(gc);
 Core Graphics函数和UIBezierPath函数混合混合设置path
 UIBezierPath*    aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 300, 300)];
 CGPathRef cgPath = aPath.CGPath;
 CGMutablePathRef  mutablePath = CGPathCreateMutableCopy(cgPath);
 CGPathAddEllipseInRect(mutablePath, NULL, CGRectMake(50, 50, 200, 200));
 aPath.CGPath = mutablePath;
 CGPathRelease(mutablePath);
 
 
 
 沙盒各路径获取
 中文件路径：
 1，获取家目录路径的函数：
 NSString *homeDir = NSHomeDirectory();
 2，获取Documents目录路径的方法：
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *docDir = [paths objectAtIndex:0];
 //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/APIKeys.plist"]
 3，获取Caches目录路径的方法：
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
 NSString *cachesDir = [paths objectAtIndex:0];
 //[NSHomeDirectory() stringByAppendingPathComponent:@"Caches/APIKeys.plist"]
 4，获取tmp目录路径的方法：
 NSString *tmpDir = NSTemporaryDirectory();
 5，获取应用程序程序包NSBundle中资源文件路径的方法：
 例如获取程序包中一个图片资源（apple.png）路径的方法：
 NSString *imagePath = [[NSBundle mainBundle] pathForResource:@”apple” ofType:@”png”];
 //[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle]resourcePath],@"/PageView.html"]
 UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
 
 
 
 
 
 视图View截图：[UIView snapshotViewAfterScreenUpdates:NO]
 
 
 
 
 
 限定程序旋转方向：工程设定的General标签中，把Depoyment Info中Device Orientation中
 __func__,它指示所在的函数,__LINE__用以指示本行语句在源文件中的位置信息,__FILE__用以指示本行语句所在源文件的文件名
 #define后面的"\"是续行符
 */
