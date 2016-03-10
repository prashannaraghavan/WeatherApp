//
//  DailyTableViewCell.h
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *maxTemp;
@property (weak, nonatomic) IBOutlet UILabel *minTemp;

@end
