//
//  ViewController.m
//  WeatherApp
//
//  Created by student on 3/7/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import "ViewController.h"
#import "ForecastKit.h"
#import "DailyModel.h"
#import "WeatherInfoModel.h"
#import "DailyTableViewCell.h"
#import "HourlyCollectionViewCell.h"
#import "InterimModel.h"
#import "WeatherDetailViewController.h"

@interface ViewController ()
{
    CLLocationManager *locationManager;
    ForecastKit *forecast;
    DailyModel* dailyForecast;
    NSArray *weatherInfoArray;
    NSArray *hourlyWeatherInfoArray;
    DailyTableViewCell *dailyCell;
//    CLLocation *currentLocation;
}

@property (weak, nonatomic) IBOutlet UIView *refreshView;
@property (weak, nonatomic) IBOutlet UIImageView *currentWeatherImage;

@property (weak, nonatomic) IBOutlet UIView *currentTempView;
@property(nonatomic,strong) NSDictionary *dataDictionary;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *updatedAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;
@property (weak, nonatomic) IBOutlet UILabel *currentCity;
@property (weak, nonatomic) IBOutlet UILabel *weatherStatus;
@property (weak, nonatomic) IBOutlet UILabel *currentMaxTemp;
@property (weak, nonatomic) IBOutlet UILabel *currentMinTemp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    forecast = [[ForecastKit alloc] initWithAPIKey:@"154d6903a64b5f582b4bd28df67ba2ef"];
 
    [self refresh];

}
- (IBAction)sponsorButtonClicked:(id)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.forecast.io/"]];
}

-(NSDate *)returnCurrentDateAndTime
{
    NSDate* currentDate = [NSDate date];
    NSTimeZone* GMTTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* currentTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger GMTOffset = [GMTTimeZone secondsFromGMTForDate:currentDate];
    NSInteger currentOffset = [currentTimeZone secondsFromGMTForDate:currentDate];
    
    NSTimeInterval interval = currentOffset - GMTOffset;
    NSDate* offsetDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:currentDate];
    
    return offsetDate;
    
}

-(void)refresh
{
    self.updatedAtLabel.text = [NSString stringWithFormat:@"Updated at : %@",[self returnCurrentDateAndTime]];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
//        NSLog(@"longitude = %.8f\nlatitude = %.8f", currentLocation.coordinate.longitude,currentLocation.coordinate.latitude);
    
    [forecast getDailyForcastForLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude success:^(NSArray *responseArray) {
        
        weatherInfoArray = responseArray;
        
        NSDictionary *dict = responseArray[0];
        self.currentMaxTemp.text = [NSString stringWithFormat:@"%d",[dict[@"apparentTemperatureMax"] intValue]];
        self.currentMaxTemp.text = [NSString stringWithFormat:@"%d",[dict[@"apparentTemperatureMin"] intValue]];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error){
        
        NSLog(@"Daily %@", error.description);
        
    }];

    
    [forecast getHourlyForcastForLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude time:[[NSDate date]timeIntervalSince1970] success:^(NSMutableArray *responseArray) {
        
        hourlyWeatherInfoArray = responseArray;
        
        NSDictionary *dict = responseArray[0];
        self.currentTemp.text = [NSString stringWithFormat:@"%d",[dict[@"temperature"] intValue]];
        self.weatherStatus.text = dict[@"summary"];
        self.currentWeatherImage.image = [UIImage imageNamed:dict[@"icon"]];
    
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Daily %@", error.description);
    }];
    
    
    // stop updating location in order to save battery power
    [locationManager stopUpdatingLocation];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             NSDictionary *addressDictionary = [placemark addressDictionary];
             self.currentCity.text = addressDictionary[@"City"];
             
         }
     }];
    }
    
    [self.currentTempView setNeedsDisplay];
    [self.refreshView setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshBtnClicked:(id)sender {
    [self refresh];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [weatherInfoArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *weatherInfo = weatherInfoArray[indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    dailyCell= [tableView dequeueReusableCellWithIdentifier:@"DailyCell"];
    
    dailyCell.day.text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[weatherInfo[@"sunriseTime"] doubleValue]]];
    dailyCell.weatherIcon.image = [UIImage imageNamed:weatherInfo[@"icon"]];
    dailyCell.maxTemp.text = [NSString stringWithFormat:@"%d",[weatherInfo[@"temperatureMax"] intValue]];
    dailyCell.minTemp.text = [NSString stringWithFormat:@"%d",[weatherInfo[@"temperatureMin"] intValue]];
    
    return dailyCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [hourlyWeatherInfoArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *weatherInfo = hourlyWeatherInfoArray[indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh a"];
   
    HourlyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HourlyCell" forIndexPath:indexPath];
    cell.weatherImage.image = [UIImage imageNamed:weatherInfo[@"icon"]];
    cell.timeLabel.text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[weatherInfo[@"time"] doubleValue]]];
    cell.temperature.text = [NSString stringWithFormat:@"%d",[weatherInfo[@"temperature"] intValue]] ;
                             
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DailyDetailTransition"]) {
        
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        WeatherDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.dataDictionary = (NSDictionary *)[weatherInfoArray objectAtIndex:index.row];
        detailViewController.dataType = @"Daily";
        [detailViewController refresh];
    }
    
    else if ([segue.identifier isEqualToString:@"HourlyDetailTransition"]) {
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *index = [indexPaths objectAtIndex:0];
        WeatherDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.dataDictionary = (NSDictionary *)[hourlyWeatherInfoArray objectAtIndex:index.row];
        detailViewController.dataType = @"Hourly";
        [detailViewController refresh];
    }
}

@end
