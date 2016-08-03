//
//  ViewController.m
//  LZBTableViewBottomEffect
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBMainPageModel.h"
#import "LZBTranslationViewController.h"
#import "LZBScaleViewController.h"
#define cell_Height  44
#define line_Height  1

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray <LZBMainPageModel *>*effectModels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title =@"主页";
}

#pragma mark- add model
- (void)addMainPageModelToEffectModels
{
    [self.effectModels addObject:[self creatSignleModelWithVCName:@"LZBTranslationViewController" Title:@"上拉平移回弹效果" AnimationEffect:LZBtableViewPullUpEffectType_translation]];
     [self.effectModels addObject:[self creatSignleModelWithVCName:@"LZBScaleViewController" Title:@"上拉放大效果" AnimationEffect:LZBtableViewPullUpEffectType_Scale]];
}

- (LZBMainPageModel *)creatSignleModelWithVCName:(NSString *)name Title:(NSString *)title  AnimationEffect:(LZBtableViewPullUpEffectType)type
{
    LZBMainPageModel *model = [[LZBMainPageModel alloc]init];
    model.viewControllerName =name;
    model.viewControllerTitle = title;
    model.type = type;
    return model;
}

#pragma mark- tableView

- (NSInteger)lzb_numberOfSectionsInTableView:(UITableView *)tableView WithSections:(NSMutableArray<LZBTableViewSectionModel *> *)sections
{
    return sections.count;
}

- (NSInteger)lzb_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section withSectionModel:(LZBTableViewSectionModel *)sectionModel
{
    return sectionModel.tableViewRowArray.count;
}

- (UITableViewCell *)lzb_first_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withSectionModel:(LZBTableViewSectionModel *)sectionModel WithCell:(UITableViewCell *)cell
{
    LZBMainPageModel *model =sectionModel.tableViewRowArray[indexPath.row];
    cell.textLabel.text =model.viewControllerTitle;
    if(sectionModel.tableViewRowArray.count-1 != indexPath.row)
    {
        [cell.contentView.layer addSublayer:[self getSeperatorLine]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)lzb_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withSectionModel:(LZBTableViewSectionModel *)sectionModel
{
    return cell_Height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZBMainPageModel *model = self.effectModels[indexPath.row];
    Class vc = NSClassFromString(model.viewControllerName);
    [self.navigationController pushViewController:[[vc alloc]init] animated:YES];
}
- (CALayer *)getSeperatorLine
{
    CALayer *lineLayer = [CALayer new];
    lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    lineLayer.frame = CGRectMake(15, cell_Height -line_Height, self.view.frame.size.width-30, line_Height);
    
    return lineLayer;
}

#pragma mark-懒加载

- (NSMutableArray<LZBTableViewSectionModel *> *)getAllSectionModels
{
    [self addMainPageModelToEffectModels];
    NSMutableArray *tempArray = [NSMutableArray array];
    LZBTableViewSectionModel *sectionModel = [[LZBTableViewSectionModel alloc]init];
    sectionModel.tableViewRowArray = self.effectModels;
    sectionModel.cellClass = [UITableViewCell class];
    [tempArray addObject:sectionModel];
    return tempArray;
}

- (NSMutableArray<LZBMainPageModel *> *)effectModels
{
  if(_effectModels == nil)
  {
      _effectModels = [NSMutableArray array];
  }
    return _effectModels;
}





@end
