//
//  DailyModel.h
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import "JSONModel.h"
#import "WeatherInfoModel.h"

@interface DailyModel : JSONModel

@property(nonatomic,strong) NSArray<WeatherInfoModel>* weatherArray;

@end
