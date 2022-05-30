//
//  ToolNSObject+Category.h
//  DaiJiuShiService
//
//  Created by rsl on 15/6/26.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "ToolNSObject.h"
#import <MapKit/MapKit.h>

#define MASearchDefine 1

#if MASearchDefine
   #import <AMapSearchKit/AMapSearchAPI.h>
#else

#endif
@interface ToolNSObject (Category)
+(CLLocationCoordinate2D)toolGetMKMapFromBaiduLati:(CLLocationDegrees)latitude loc:(CLLocationDegrees)longitude;
+(CLLocationCoordinate2D)toolGetBaiduFromMKMapLati:(CLLocationDegrees)latitude loc:(CLLocationDegrees)longitude;

+(MKCoordinateRegion)toolMkMapCoordinate2D:(CLLocationCoordinate2D) centerCoordinate  latitudinalMeters:(CLLocationDistance)latitudinalMeters longitudinalMeters:(CLLocationDistance) longitudinalMeters;
+(void)toolMapView:(MKMapView *)map Coordinate2D:(CLLocationCoordinate2D) centerCoordinate  latitudinalMeters:(CLLocationDistance)latitudinalMeters longitudinalMeters:(CLLocationDistance) longitudinalMeters;
+(CLLocationDistance)toolGetDistanceMapPointLatitu:(CLLocationDistance)pointLa  Pointlongitu:(CLLocationDistance)pointLo OtherPoint:(CLLocationDistance)othPointLa  Pointlongitu:(CLLocationDistance)othPointLo;

+(MKMapRect)toolMkMapRectCoordinate2D:(CLLocationCoordinate2D) centerCoordinate  latitudinalMeters:(CLLocationDistance)latitudinalMeters longitudinalMeters:(CLLocationDistance) longitudinalMeters;
#if MASearchDefine
    +(NSArray *)toolArrayPolyLinesForPath:(AMapPath *)path startPoint:(CLLocationCoordinate2D)startCoor endStartPoine:(CLLocationCoordinate2D)endCoor view:(MKMapView *)map;
    +(NSArray *)toolArrayPolyLinesForTransit:(NSArray *)path startPoint:(CLLocationCoordinate2D)startCoor endStartPoine:(CLLocationCoordinate2D)endCoor view:(MKMapView *)map;

    +(NSArray *)ToolArrayBusToBusPolyLinesForTransit:(NSArray *)path;
    +(NSArray *)toolArrayBusToWalkPolyLinesForTransit:(NSArray *)path;
    +(NSArray *)toolArrayPolyLinesForPath:(AMapPath *)path;
#else

#endif
+(CLLocationCoordinate2D *)toolCoordinatesForString:(NSString *)string coordinateCount:(NSUInteger *)coordinateCount parseToKen:(NSString *)token;

+(NSArray *)toolSysMapNaviDefaultPointForm:(CLLocationCoordinate2D)form to:(CLLocationCoordinate2D)end MKDirectionsTransportType:(MKDirectionsTransportType)type connection:(BOOL)con;
+(NSArray *)toolSysMapNaviDefaultPointFrom:(MKMapItem *)source
                                   PointTo:(MKMapItem *)destination MKDirectionsTransportType:(MKDirectionsTransportType)type connection:(BOOL)con formCoor:(CLLocationCoordinate2D)coor0 toCoor:(CLLocationCoordinate2D)coor1;
@end
