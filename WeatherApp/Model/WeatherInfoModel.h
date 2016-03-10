//
//  WeatherInfoModel.h
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import "JSONModel.h"

@protocol WeatherInfoModel
@end

@interface WeatherInfoModel : JSONModel

@property (strong, nonatomic) NSString* apparentTemperatureMax;
@property (strong, nonatomic) NSDate* apparentTemperatureMaxTime;
@property (strong, nonatomic) NSString* apparentTemperatureMin;
@property (strong, nonatomic) NSDate* apparentTemperatureMinTime;
@property (strong, nonatomic) NSString* cloudCover;
@property (strong, nonatomic) NSString* dewPoint;
@property (strong, nonatomic) NSString* humidity;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSString* moonPhase;
@property (strong, nonatomic) NSString* ozone;
@property int precipIntensity;
@property int precipIntensityMax;
@property int precipProbability;
@property (strong, nonatomic) NSString* pressure;
@property (strong, nonatomic) NSString* summary;
@property (strong, nonatomic) NSDate* sunriseTime;
@property (strong, nonatomic) NSDate* sunsetTime;
@property (strong, nonatomic) NSString* temperatureMax;
@property (strong, nonatomic) NSDate* temperatureMaxTime;
@property (strong, nonatomic) NSString* temperatureMin;
@property (strong, nonatomic) NSDate* temperatureMinTime;
@property (strong, nonatomic) NSDate* time;
@property (strong, nonatomic) NSString* windBearing;
@property (strong, nonatomic) NSString* windSpeed;


@end
