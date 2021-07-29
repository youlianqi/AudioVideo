//
//  NEMainWindowContentView.m
//  NESample
//
//  Created by Robin on 2021/7/23.
//

#import "NEMainWindowContentView.h"
#import "NETextField.h"
#import "NETextFieldCell.h"
#import "NEUIMgr.h"

@interface TreeNodeModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *childNodes;
@property (nonatomic, strong) NSString *actionName;

@end

@implementation TreeNodeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _childNodes = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
- (NSMutableArray *)childNodes {
    if (!_childNodes) {
        _childNodes = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _childNodes;
}

@end

@interface CustomTableCellView : NSTableCellView
@property (nonatomic, strong) NETextField *titleLabel;

+ (instancetype)cellWithTableView:(NSTableView *)tableView owner:(nullable id)owner;

@end

@implementation CustomTableCellView
static NSString * CustomTableCellID = @"CustomTableCellID";

+ (instancetype)cellWithTableView:(NSTableView *)tableView owner:(nullable id)owner{
    
    CustomTableCellView *cell = [tableView makeViewWithIdentifier:CustomTableCellID owner:owner];
    if (!cell) {
        cell = [[CustomTableCellView alloc]init];
        cell.identifier = CustomTableCellID;
        [cell setUpViews];
    }
    
    return cell;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = CustomTableCellID;
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    
    self.titleLabel = [[NETextField alloc]initWithFrame:NSMakeRect(0, 0, 500, 40)];
    [self addSubview:self.titleLabel];

    self.titleLabel.editable = NO;
    self.titleLabel.bordered = NO;
    [self.titleLabel setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    self.wantsLayer = YES;
}

- (void)layout
{
    [super layout];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}


@end

@interface NEMainWindowContentView()<NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSOutlineView *outlineView;
@property (nonatomic, strong) TreeNodeModel *treeModel;

@end

@implementation NEMainWindowContentView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setupUI];
        [self treeViewDataConfig];
    }
    return self;
}

- (void)setupUI
{
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor windowBackgroundColor].CGColor;
    
    NSTableColumn *tableColumn = [[NSTableColumn alloc] init];
    tableColumn.resizingMask = NSTableColumnAutoresizingMask;

    self.outlineView = [[NSOutlineView alloc] init];
    _outlineView.floatsGroupRows = YES;
    _outlineView.dataSource = self;
    _outlineView.delegate = self;
    _outlineView.allowsColumnResizing = YES;
    _outlineView.headerView = nil;
    _outlineView.allowsMultipleSelection = NO;
    _outlineView.allowsColumnSelection = NO;
    _outlineView.allowsEmptySelection = YES;
    _outlineView.allowsTypeSelect = YES;
    _outlineView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;
    _outlineView.columnAutoresizingStyle = NSTableViewFirstColumnOnlyAutoresizingStyle;
    [_outlineView addTableColumn:tableColumn];

    self.scrollView = [[NSScrollView alloc] init];
    _scrollView.documentView = _outlineView;
    _scrollView.hasVerticalScroller = YES;
    _scrollView.autohidesScrollers = YES;
    
    [self addSubview:_scrollView];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)layout
{
    [super layout];
    CGRect bounds = self.bounds;
    _scrollView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
}

- (TreeNodeModel *)treeModel {
    if (!_treeModel) {
        _treeModel = [[TreeNodeModel alloc] init];
        _treeModel.name = @"test";
    }
    
    return _treeModel;
}

- (void)treeViewDataConfig
{
    {
        TreeNodeModel *level1Node = [[TreeNodeModel alloc] init];
        level1Node.name = @"Common UI";
        
        {
            TreeNodeModel *level2Node = [[TreeNodeModel alloc] init];
            level2Node.name = @"Button";
            level2Node.actionName = @"onButton";
            [level1Node.childNodes addObject:level2Node];
        }
        
        {
            TreeNodeModel *level2Node = [[TreeNodeModel alloc] init];
            level2Node.name = @"Label";
            level2Node.actionName = @"onLabel";
            [level1Node.childNodes addObject:level2Node];
        }
        
        [self.treeModel.childNodes addObject:level1Node];
    }
    
    {
        TreeNodeModel *level1Node = [[TreeNodeModel alloc] init];
        level1Node.name = @"Call";
        
        {
            TreeNodeModel *level2Node = [[TreeNodeModel alloc] init];
            level2Node.name = @"Meeting";
            level2Node.actionName = @"onMeeting";
            [level1Node.childNodes addObject:level2Node];
        }
        
        {
            TreeNodeModel *level2Node = [[TreeNodeModel alloc] init];
            level2Node.name = @"Group Call";
            level2Node.actionName = @"onGroupCall";
            [level1Node.childNodes addObject:level2Node];
        }
        
        {
            TreeNodeModel *level2Node = [[TreeNodeModel alloc] init];
            level2Node.name = @"Video Cal-1to1";
            level2Node.actionName = @"onVideoCall";
            [level1Node.childNodes addObject:level2Node];
        }
        
        [self.treeModel.childNodes addObject:level1Node];
    }
    
    [self.outlineView reloadData];
}

#pragma  mark - NSOutlineViewDataSource
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    NSUInteger count = 0;
    if (!item) {
        count = [self.treeModel.childNodes count];
    }
    else {
        TreeNodeModel *nodeModel = item;
        count = [nodeModel.childNodes count];
    }
    
    return count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    TreeNodeModel *nodeModel = nil;
    if (!item) {
        nodeModel = self.treeModel.childNodes[index];
    }
    else {
        TreeNodeModel *nodeModelItem = item;
        nodeModel = nodeModelItem.childNodes[index];
    }
    
    return nodeModel;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    BOOL bRet = FALSE;
    if (!item) {
        bRet = [self.treeModel.childNodes count] > 0;
    }
    else {
        TreeNodeModel *nodeModel = item;
        bRet = [nodeModel.childNodes count] > 0;
    }
    
    return bRet;
}

//- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(nonnull id)item {
//    BOOL bRet = FALSE;
//    if (!item) {
//        bRet = [self.treeModel.childNodes count] > 0;
//    }else {
//        TreeNodeModel *nodeModel = item;
//        bRet = [nodeModel.childNodes count] > 0;
//    }
//
//    return bRet;
//}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {

#if 1
    CustomTableCellView *cell = [CustomTableCellView cellWithTableView:outlineView owner:self];
#else
    CustomTableCellView *cell = [outlineView makeViewWithIdentifier:CustomTableCellID owner:self];
    if (cell == nil) {
        cell = [[CustomTableCellView alloc] init];
        cell.identifier = CustomTableCellID;
    }
#endif
    
    TreeNodeModel *model = item;
    cell.titleLabel.stringValue = model.name;
    return cell;
}


- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSOutlineView *treeView = notification.object;
    NSInteger row = [treeView selectedRow];
    TreeNodeModel *model = (TreeNodeModel *)[treeView itemAtRow:row];
    NSLog(@"name = %@", model.name);
    if (model.actionName) {
        SEL selector = NSSelectorFromString(model.actionName);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
    }
    
    [treeView deselectRow:row];
}

- (CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item {
    return 30.0f;
}

- (void)onButton
{
    NSLog(@"%s",__FUNCTION__);
    
    [[NEUIMgr sharedInstance] showButtonWindow];
}

- (void)onLabel
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)onMeeting
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)onGroupCall
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)onVideoCall
{
    NSLog(@"%s",__FUNCTION__);
}

@end
