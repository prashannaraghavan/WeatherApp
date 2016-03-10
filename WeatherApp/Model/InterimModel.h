//
//  InterimModel.h
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import "JSONModel.h"
#import "WeatherInfoModel.h"

@protocol WeatherInfoModel;

@interface InterimModel : JSONModel

@property(nonatomic,strong) WeatherInfoModel* model ;

@end
