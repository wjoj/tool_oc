//
//  ToolNSObject+Category.m
//  DaiJiuShiService
//
//  Created by rsl on 15/6/26.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "ToolNSObject+Category.h"
#import "ToolHex.h"
@implementation ToolNSObject (Category)
const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
//火星转百度坐标
void bd_encrypt(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}
//百度坐标转火星
void bd_decrypt(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}
+(CLLocationCoordinate2D)toolGetMKMapFromBaiduLati:(CLLocationDegrees)latitude loc:(CLLocationDegrees)longitude{
    if ([ToolHex initBuID]) {
        return CLLocationCoordinate2DMake(0, 0);
    }
    double bdLat,bdLon;
    bd_decrypt(latitude, longitude, &bdLat, &bdLon);
    return  CLLocationCoordinate2DMake(bdLat,bdLon);
}
+(CLLocationCoordinate2D)toolGetBaiduFromMKMapLati:(CLLocationDegrees)latitude loc:(CLLocationDegrees)longitude{
    if ([ToolHex initBuID]) {
        return CLLocationCoordinate2DMake(0, 0);
    }
    double bdLat,bdLon;
    bd_encrypt(latitude, longitude, &bdLat, &bdLon);
    return  CLLocationCoordinate2DMake(bdLat,bdLon);
}

+(MKCoordinateRegion)toolMkMapCoordinate2D:(CLLocationCoordinate2D) centerCoordinate  latitudinalMeters:(CLLocationDistance)latitudinalMeters longitudinalMeters:(CLLocationDistance) longitudinalMeters{
    if ([ToolHex initBuID]) {
        return MKCoordinateRegionForMapRect(MKMapRectMake(0, 0,0,0));
    }
    MKCoordinateRegion r = MKCoordinateRegionMakeWithDistance(centerCoordinate, latitudinalMeters,longitudinalMeters);
    MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(r.center.latitude + r.span.latitudeDelta *.5f, r.center.longitude - r.span.longitudeDelta *.5f));
    MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(r.center.latitude - r.span.latitudeDelta *.5f, r.center.longitude + r.span.longitudeDelta *.5f));
    return  MKCoordinateRegionForMapRect(MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y)));
}
+(void)toolMapView:(MKMapView *)map Coordinate2D:(CLLocationCoordinate2D) centerCoordinate  latitudinalMeters:(CLLocationDistance)latitudinalMeters longitudinalMeters:(CLLocationDistance) longitudinalMeters{
    if ([ToolHex initBuID]) {
        return ;
    }
    MKCoordinateRegion adjustedRegion = [map regionThatFits:[ToolNSObject toolMkMapCoordinate2D:centerCoordinate latitudinalMeters:latitudinalMeters longitudinalMeters:longitudinalMeters]];
    [map setRegion:adjustedRegion animated:YES];
}
+(CLLocationDistance)toolGetDistanceMapPointLatitu:(CLLocationDistance)pointLa  Pointlongitu:(CLLocationDistance)pointLo OtherPoint:(CLLocationDistance)othPointLa  Pointlongitu:(CLLocationDistance)othPointLo{
    if ([ToolHex initBuID]) {
        return MKMetersBetweenMapPoints(MKMapPointForCoordinate(CLLocationCoordinate2DMake(0, 0)), MKMapPointForCoordinate(CLLocationCoordinate2DMake(0, 0)));
    }
    MKMapPoint pont1 = MKMapPointForCoordinate(CLLocationCoordinate2DMake(pointLa, pointLo));
    MKMapPoint pont2 = MKMapPointForCoordinate(CLLocationCoordinate2DMake(othPointLa, othPointLo));
    return MKMetersBetweenMapPoints(pont1, pont2);
}

+(MKMapRect)toolMkMapRectCoordinate2D:(CLLocationCoordinate2D) centerCoordinate  latitudinalMeters:(CLLocationDistance)latitudinalMeters longitudinalMeters:(CLLocationDistance) longitudinalMeters{
    MKCoordinateRegion r = MKCoordinateRegionMakeWithDistance(centerCoordinate, latitudinalMeters,longitudinalMeters);
    MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(r.center.latitude + r.span.latitudeDelta *.5f, r.center.longitude - r.span.longitudeDelta *.5f));
    MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(r.center.latitude - r.span.latitudeDelta *.5f, r.center.longitude + r.span.longitudeDelta *.5f));
    return  MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y));
}
/************************
 //#import <AMapSearchKit/AMapSearchAPI.h>
 MASearchDefine 1
 *************************/
#if MASearchDefine
+(NSArray *)toolArrayPolyLinesForPath:(AMapPath *)path startPoint:(CLLocationCoordinate2D)startCoor endStartPoine:(CLLocationCoordinate2D)endCoor view:(MKMapView *)map{
    if (path==nil||path.steps.count==0) {
        return nil;
    }
    NSMutableArray *arrayLine = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        
        CLLocationCoordinate2D *coord = [ToolNSObject toolCoordinatesForString:step.polyline coordinateCount:&count parseToKen:@";"];
        MKPolyline *pol = [MKPolyline polylineWithCoordinates:coord count:count];
        [arrayLine addObject:pol];
        free(coord),coord = NULL;
    }];
    MKPolyline *lineOne = [arrayLine firstObject];
    MKMapPoint *pointOnes = lineOne.points;
    MKMapPoint pointOne = pointOnes[0];
    CLLocationCoordinate2D commonPolylineCoords[2];
    CLLocationCoordinate2D cord = MKCoordinateForMapPoint(pointOne);
    commonPolylineCoords[0].latitude = startCoor.latitude;
    commonPolylineCoords[0].longitude = startCoor.longitude;
    commonPolylineCoords[1].latitude = cord.latitude;
    commonPolylineCoords[1].longitude = cord.longitude;
    MKPolyline *com = [MKPolyline polylineWithCoordinates:commonPolylineCoords count:2];
    
    [map addOverlay:com];
    
    MKPolyline *lineTwo = [arrayLine lastObject];
    MKMapPoint *pointTwos = lineTwo.points;
    MKMapPoint pointTwo = pointTwos[lineTwo.pointCount-1];
    CLLocationCoordinate2D commonPolylineCoordsTwo[2];
    CLLocationCoordinate2D cordTwo = MKCoordinateForMapPoint(pointTwo);
    commonPolylineCoordsTwo[0].latitude = endCoor.latitude;
    commonPolylineCoordsTwo[0].longitude = endCoor.longitude;
    commonPolylineCoordsTwo[1].latitude = cordTwo.latitude;
    commonPolylineCoordsTwo[1].longitude = cordTwo.longitude;
    MKPolyline *comTwo = [MKPolyline polylineWithCoordinates:commonPolylineCoordsTwo count:2];
    [map addOverlay:comTwo];
    return arrayLine;
}

+(NSArray *)toolArrayPolyLinesForTransit:(NSArray *)path startPoint:(CLLocationCoordinate2D)startCoor endStartPoine:(CLLocationCoordinate2D)endCoor view:(MKMapView *)map{
    if ([ToolHex initBuID]) {
        return nil;
    }
    if (path==nil||path.count==0) {
        return nil;
    }
    NSMutableArray *arrayLine = [NSMutableArray array];
    [path enumerateObjectsUsingBlock:^(AMapSegment *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        if (step.walking!=nil) {
            NSArray *array =step.walking.steps;
            for (NSUInteger i=0; i<array.count; i++) {
                AMapStep *steps = array[i];
                CLLocationCoordinate2D *coord = [ToolNSObject toolCoordinatesForString:steps.polyline coordinateCount:&count parseToKen:@";"];
                MKPolyline *pol = [MKPolyline polylineWithCoordinates:coord count:count];
                [arrayLine addObject:pol];
                free(coord),coord = NULL;
            }
        }
        if (step.busline!=nil) {
            CLLocationCoordinate2D *coord = [ToolNSObject toolCoordinatesForString:step.busline.polyline coordinateCount:&count parseToKen:@";"];
            MKPolyline *pol = [MKPolyline polylineWithCoordinates:coord count:count];
            [arrayLine addObject:pol];
            free(coord),coord = NULL;
        }
    }];
    
    MKPolyline *lineOne = [arrayLine firstObject];
    MKMapPoint *pointOnes = lineOne.points;
    MKMapPoint pointOne = pointOnes[0];
    CLLocationCoordinate2D commonPolylineCoords[2];
    CLLocationCoordinate2D cord = MKCoordinateForMapPoint(pointOne);
    commonPolylineCoords[0].latitude = startCoor.latitude;
    commonPolylineCoords[0].longitude = startCoor.longitude;
    commonPolylineCoords[1].latitude = cord.latitude;
    commonPolylineCoords[1].longitude = cord.longitude;
    MKPolyline *com = [MKPolyline polylineWithCoordinates:commonPolylineCoords count:2];
    [map addOverlay:com];
    //
    MKPolyline *lineTwo = [arrayLine lastObject];
    MKMapPoint *pointTwos = lineTwo.points;
    MKMapPoint pointTwo = pointTwos[lineTwo.pointCount-1];
    CLLocationCoordinate2D commonPolylineCoordsTwo[2];
    CLLocationCoordinate2D cordTwo = MKCoordinateForMapPoint(pointTwo);
    commonPolylineCoordsTwo[0].latitude = endCoor.latitude;
    commonPolylineCoordsTwo[0].longitude = endCoor.longitude;
    commonPolylineCoordsTwo[1].latitude = cordTwo.latitude;
    commonPolylineCoordsTwo[1].longitude = cordTwo.longitude;
    MKPolyline *comTwo = [MKPolyline polylineWithCoordinates:commonPolylineCoordsTwo count:2];
    [map addOverlay:comTwo];
    return arrayLine;
}
 

/***
 @ 获取公交路线polyline
 ***/

+(NSArray *)ToolArrayBusToBusPolyLinesForTransit:(NSArray *)path{
    if ([ToolHex initBuID]) {
        return nil;
    }
    if (path==nil||path.count==0) {
        return nil;
    }
    NSMutableArray *arrayLine = [NSMutableArray array];
    [path enumerateObjectsUsingBlock:^(AMapSegment *step, NSUInteger idx, BOOL *stop) {
        if (step.busline!=nil) {
            MKPointAnnotation *point2 = [[MKPointAnnotation alloc]init];
            point2.coordinate = CLLocationCoordinate2DMake(step.busline.departureStop.location.latitude, step.busline.departureStop.location.longitude);
            [arrayLine addObject:point2];
            
            MKPointAnnotation *point1 = [[MKPointAnnotation alloc]init];
            point1.coordinate = CLLocationCoordinate2DMake(step.busline.arrivalStop.location.latitude, step.busline.arrivalStop.location.longitude);;
            [arrayLine addObject:point1];
        }
    }];
    return arrayLine;
}
+(NSArray *)toolArrayBusToWalkPolyLinesForTransit:(NSArray *)path {
    if ([ToolHex initBuID]) {
        return nil;
    }
    if (path==nil||path.count==0) {
        return nil;
    }
    NSMutableArray *arrayLine = [NSMutableArray array];
    [path enumerateObjectsUsingBlock:^(AMapSegment *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        if (step.walking!=nil) {
            NSArray *array =step.walking.steps;
            for (NSUInteger i=0; i<array.count; i++) {
                AMapStep *steps = array[i];
                CLLocationCoordinate2D *coord = [ToolNSObject toolCoordinatesForString:steps.polyline coordinateCount:&count parseToKen:@";"];
                MKPointAnnotation *point2 = [[MKPointAnnotation alloc]init];
                point2.coordinate = coord[0];
                [arrayLine addObject:point2];
                free(coord),coord = NULL;
            }
        }
    }];
    return arrayLine;
}
/***
 @ 获取步行和驾车路线polyline
 ***/

+(NSArray *)toolArrayPolyLinesForPath:(AMapPath *)path {
    if ([ToolHex initBuID]) {
        return nil;
    }
    if (path==nil||path.steps.count==0) {
        return nil;
    }
    
    NSMutableArray *arrayPint = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coord = [ToolNSObject toolCoordinatesForString:step.polyline coordinateCount:&count parseToKen:@";"];
        MKPointAnnotation *point2 = [[MKPointAnnotation alloc]init];
        point2.coordinate = coord[0];
        [arrayPint addObject:point2];
        free(coord),coord = NULL;
        
    }];
    return arrayPint;
}
#else

#endif

+(CLLocationCoordinate2D *)toolCoordinatesForString:(NSString *)string coordinateCount:(NSUInteger *)coordinateCount parseToKen:(NSString *)token{
    if ([ToolHex initBuID]) {
        return nil;
    }
    if (string==nil) {
        return NULL;
    }
    if (token==nil) {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }else{
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count]/2;
    if (coordinateCount!=NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D *)malloc(count*sizeof(CLLocationCoordinate2D));
    for (int i=0; i<count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2*i] doubleValue];
        coordinates[i].latitude = [[components objectAtIndex:2*i +1] doubleValue];
    }
    return coordinates;
}
+(NSArray *)toolSysMapNaviDefaultPointForm:(CLLocationCoordinate2D)form to:(CLLocationCoordinate2D)end MKDirectionsTransportType:(MKDirectionsTransportType)type connection:(BOOL)con{
    if ([ToolHex initBuID]) {
        return nil;
    }
    CLLocationCoordinate2D fromCoordinate = form;
    CLLocationCoordinate2D toCoordinate   = end;
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate
                                                       addressDictionary:nil];
    
    MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithCoordinate:toCoordinate
                                                       addressDictionary:nil];
    
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    
    MKMapItem *toItem   = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    
    return  [ToolNSObject toolSysMapNaviDefaultPointFrom:fromItem PointTo:toItem MKDirectionsTransportType:type connection:con formCoor:form toCoor:end];
    
}
+(NSArray *)toolSysMapNaviDefaultPointFrom:(MKMapItem *)source
                                   PointTo:(MKMapItem *)destination MKDirectionsTransportType:(MKDirectionsTransportType)type connection:(BOOL)con formCoor:(CLLocationCoordinate2D)coor0 toCoor:(CLLocationCoordinate2D)coor1{
    if ([ToolHex initBuID]) {
        return nil ;
    }
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = source;
    request.destination = destination;
    request.requestsAlternateRoutes = NO;
    request.transportType = type;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    NSMutableArray *arrayLines = [NSMutableArray array];
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             
             NSLog(@"error:%@", error);
         }else {
             MKRoute *route = response.routes[0];
             //将线路中的每一步详情提取出来
             NSArray * stepArray = [NSArray arrayWithArray:route.steps];
             for (int i=0; i<stepArray.count; i++) {
                 //线路的详情节点
                 MKRouteStep * step = stepArray[i];
                 if (i==0&&con) {
                     MKMapPoint *points = step.polyline.points;
                     MKMapPoint pointa = points[0];
                     CLLocationCoordinate2D cord = MKCoordinateForMapPoint(pointa);
                     CLLocationCoordinate2D commonPolylineCoords[2];
                     commonPolylineCoords[0].latitude = coor0.latitude;
                     commonPolylineCoords[0].longitude = coor0.longitude;
                     commonPolylineCoords[1].latitude = cord.latitude;
                     commonPolylineCoords[1].longitude = cord.longitude;
                     MKPolyline *com = [MKPolyline polylineWithCoordinates:commonPolylineCoords count:2];
                     [arrayLines addObject:com];
                 }else if (i==stepArray.count-1&&con){
                     MKMapPoint *points = step.polyline.points;
                     MKMapPoint pointa = points[step.polyline.pointCount-1];
                     CLLocationCoordinate2D cord = MKCoordinateForMapPoint(pointa);
                     
                     CLLocationCoordinate2D commonPolylineCoords[2];
                     commonPolylineCoords[0].latitude = cord.latitude;
                     commonPolylineCoords[0].longitude = cord.longitude;
                     commonPolylineCoords[1].latitude = coor1.latitude;
                     commonPolylineCoords[1].longitude = coor1.longitude;
                     
                     MKPolyline *com = [MKPolyline polylineWithCoordinates:commonPolylineCoords count:2];
                     [arrayLines addObject:com];
                 }
                 [arrayLines addObject:step.polyline];
             }
         }
     }];
    return arrayLines;
}
@end
