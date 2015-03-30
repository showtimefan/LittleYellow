//
//  PhotosVController.m
//  Yellow
//
//  Created by Coffee on 15/3/20.
//  Copyright (c) 2015年 LSZ. All rights reserved.
//

#import "PhotosVController.h"
#import "Masonry.h"
#import "YEPhotosCollectionCell.h"
#import "NGCommonAPI.h"
#import "NGForumPhotoBrowser.h"
#import "BlocksKit.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface PhotosVController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, MWPhotoBrowserDelegate>
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray* photoArray;
@property (nonatomic) NSInteger curPhotoIndex;
@end

@implementation PhotosVController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *photoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"JPG"
                                                        inDirectory:nil];
    self.photoArray = [NSMutableArray arrayWithArray:photoArray];
    [self createCollectionView];
    [self createRefreshControll];
//    [self initCacheGameData];
//    [self initGameData];
}

- (UIImage*)tabImage {
    return [UIImage imageNamed:@"topbar_ic_homepage"];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;

    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerNib:[UINib nibWithNibName:@"YEPhotosCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    _collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
}

- (void)createRefreshControll {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(doRefresh:) forControlEvents:UIControlEventValueChanged];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YEPhotosCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    NSString *imagePath = self.photoArray[indexPath.row];
    cell.photoImageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    cell.photoImageView.userInteractionEnabled = YES;
    cell.photoIndex = indexPath.row;

    __weak typeof (self) weakSelf = self;
    [cell.photoImageView whenTapped:^{
        weakSelf.curPhotoIndex = cell.photoIndex;
            NSLog(@"cellIndexPath = %d", weakSelf.curPhotoIndex);
        NGForumPhotoBrowser *browser = [[NGForumPhotoBrowser alloc] initWithDelegate:self];
        [weakSelf.navigationController presentViewController:browser animated:NO completion:nil];
    }];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imagePath = self.photoArray[indexPath.row];
    UIImage *photoImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    return [NGCommonAPI getImgSize:photoImage customWidth:collectionView.frame.size.width];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 5, 5);
}


- (void)doRefresh:(id)sender {
    [self.refreshControl beginRefreshing];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });

//    if (self.isLoading) {
//        [self.refreshControl endRefreshing];
//        return;
//    }
//    self.isLoading = YES;
//
//    __weak typeof(self) weakSelf = self;
//    [[BCWebService sharedService] getCardHistoryByCardID:[_cardInfo[@"vip"][@"id"] longLongValue] lastID:0 onSuccess:^(NSArray* result) {
//        weakSelf.isLoading = NO;
//        [weakSelf.refreshControl endRefreshing];
//
//        weakSelf.hasMoreData = (result.count >= 20);
//
//        [weakSelf reloadHistories:result];
//    } onFailed:^(id sender) {
//        weakSelf.isLoading = NO;
//        [weakSelf.refreshControl endRefreshing];
//
//        [SVProgressHUD showErrorWithStatus:sender duration:1.5];
//    }];
}

#pragma mark MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return 1;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    NSString *imagePath = self.photoArray[self.curPhotoIndex];
    NSLog(@"curPhotoIndex = %d", self.curPhotoIndex);
    return [MWPhoto photoWithImage: [[UIImage alloc] initWithContentsOfFile:imagePath]];
}

@end
