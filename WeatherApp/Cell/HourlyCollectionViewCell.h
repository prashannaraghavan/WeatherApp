//
//  HourlyCollectionViewCell.h
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourlyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *temperature;

@end
