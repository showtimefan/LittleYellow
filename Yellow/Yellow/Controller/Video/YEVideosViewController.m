//
//  YEVideoViewController.m
//  Yellow
//
//  Created by Coffee on 15/3/25.
//  Copyright (c) 2015年 LSZ. All rights reserved.
//

#import "YEVideosViewController.h"
#import "BlocksKit.h"
#import "NGCommonAPI.h"
#import "Masonry.h"
#import "YEVideosCollectionViewCell.h"
#import "OLImage.h"
#import <MediaPlayer/MediaPlayer.h>

static NSString *CellIdentifier = @"CellIdentifier";

@interface YEVideosViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray* videoArray;
@property (strong,nonatomic) MPMoviePlayerViewController *playController;
@end

@implementation YEVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[ NSNotificationCenter   defaultCenter ]  addObserver : self
                                                  selector : @selector (movieFinishedCallback)

                                                      name : MPMoviePlayerPlaybackDidFinishNotification

                                                    object :nil ];

    NSArray *videoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif"
                                                             inDirectory:nil];
    self.videoArray = [NSMutableArray arrayWithArray:videoArray];
    [self createCollectionView];
    [self createRefreshControll];
    [self createMoviePlayer];
    //    [self initCacheGameData];
    //    [self initGameData];
}

- (UIImage*)tabImage {
    return [UIImage imageNamed:@"topbar_ic_homepage"];
}

- (void)createMoviePlayer {
    self.playController = [MPMoviePlayerViewController new];
    self.playController.moviePlayer.fullscreen = NO;
    self.playController.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.playController.moviePlayer.scalingMode = MPMovieScalingModeFill;
    [self.playController.moviePlayer prepareToPlay];
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
    [_collectionView registerNib:[UINib nibWithNibName:@"YEVideosCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
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
    return self.videoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YEVideosCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    NSString *videoPath = self.videoArray[indexPath.row];
    NSData *GIFDATA = [NSData dataWithContentsOfFile:videoPath];
    cell.videoImageView.image = [[OLImage imageWithData:GIFDATA].images objectAtIndex:0];
    cell.curIndex = indexPath.row;
//    cell.videoArray.image = [[UIImage alloc] initWithContentsOfFile:imagePath];

    __weak typeof (self) weakSelf = self;
    [cell.optBtn whenTapped:^{
        NSString *videoPath = self.videoArray[cell.curIndex];

        NSArray *movArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"mov"
                                                                 inDirectory:nil];

                self.playController.moviePlayer.contentURL = [NSURL URLWithString:@"http://pan.baidu.com/play/video#video/path=%2FiOS8%2FLynda%20-%20Swift%20Programming%20Language%20First%20Look%2F01_09-Functions.mp4&t=11"];
//        self.playController.moviePlayer.contentURL = [NSURL fileURLWithPath:movArray[1]];
        [self.playController.moviePlayer play];

        [self presentMoviePlayerViewControllerAnimated:self.playController];


//        weakSelf.playController.moviePlayer.contentURL = [NSURL fileURLWithPath:videoPath];
//        weakSelf.playController.moviePlayer.fullscreen = YES;
//        [weakSelf.playController.moviePlayer play];
//        [weakSelf presentMoviePlayerViewControllerAnimated:self.playController];
    }];

    return cell;
}

- (void)movieFinishedCallback {
    [self dismissMoviePlayerViewControllerAnimated];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *videoPath = self.videoArray[indexPath.row];
    NSData *GIFDATA = [NSData dataWithContentsOfFile:videoPath];
    UIImage *videoImage = [OLImage imageWithData:GIFDATA];

    return [NGCommonAPI getImgSize:videoImage customWidth:collectionView.frame.size.width];
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

@end
