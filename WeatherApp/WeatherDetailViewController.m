//
//  WeatherDetailViewController.m
//  WeatherApp
//
//  Created by student on 3/9/16.
//  Copyright © 2016 Canary. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController ()
{
    NSArray *parameters;
}
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end

@implementation WeatherDetailViewController

-(void)refresh
{
    [self.detailTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.dataType isEqualToString:@"Daily"]) {
        parameters = [NSArray arrayWithObjects:@"apparentTemperatureMax",
                      @"apparentTemperatureMaxTime",
                      @"apparentTemperatureMin",
                      @"apparentTemperatureMinTime",
                      @"cloudCover",
                      @"dewPoint",
                      @"humidity",
                      @"icon",
                      @"moonPhase",
                      @"ozone",
                      @"precipIntensity",
                      @"precipIntensityMax",
                      @"precipProbability",
                      @"pressure",
                      @"summary",
                      @"sunriseTime",
                      @"sunsetTime",
                      @"temperatureMax",
                      @"temperatureMaxTime",
                      @"temperatureMin",
                      @"temperatureMinTime",
                      @"time",
                      @"visibility",
                      @"windBearing",
                      @"windSpeed",nil];
    }
    
    else{
        parameters = [NSArray arrayWithObjects:@"apparentTemperature",
                      @"cloudCover",
                      @"dewPoint",
                      @"humidity",
                      @"icon",
                      @"ozone",
                      @"precipIntensity",
                      @"precipProbability",
                      @"pressure",
                      @"summary",
                      @"temperature",
                      @"time",
                      @"visibility",
                      @"windBearing",
                      @"windSpeed",nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [parameters count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *parameter = parameters[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell.textLabel.text = [parameter capitalizedString];
    
    if ([self.dataDictionary[parameter] isKindOfClass:[NSString class]] && self.dataDictionary[parameter]!=nil) {
        cell.detailTextLabel.text = self.dataDictionary[parameter];
    }
    
    else if(self.dataDictionary[parameter] != nil){
       cell.detailTextLabel.text = [self.dataDictionary[parameter] stringValue];
    }
    
    else{
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

@end
