//
//  NGCommonDelegate.h
//  NewGamePad
//
//  Created by chisj on 15/2/5.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import "GSGameInfoModel.h"
#import "GSGameDetailModel.h"

#ifndef NewGamePad_NGCommonDelegate_h
#define NewGamePad_NGCommonDelegate_h

@protocol NGDownLoadBottomViewDelegate <NSObject>

- (void)setBottomEnable:(BOOL)bEnable;
- (void)updateBottomButton;
@end


@protocol  NGGameCollectionCellDelegate <NSObject>
- (void)actionOptButtonCell:(GSGameInfoModel *)model;
@end

@protocol  NGGameDetailOptButtonDelegate <NSObject>
- (void)actionDetailOptButton:(GSGameDetailModel *)detailModel;
@end
#endif
