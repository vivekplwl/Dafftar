//
//  DBClass.h
//  iamsafe
//
//  Created by Binary Semantics on 5/23/13.
//
//

#import <Foundation/Foundation.h>
//#import "savetrip.h"
//#import "birthday.h"

@interface DBClass : NSObject
{
     NSString *databaseName;
     NSString *databasePath;
    NSMutableArray *dealerarray;
    NSMutableArray *newdealerarray;
}

-(void)checkAndCreateDatabase;
-(void)copyDatabaseAtPath;
-(void)insertoffline:(NSDictionary *)str;
-(NSMutableArray *)getoffline;
-(NSMutableArray *)getemergencycontact;
-(NSMutableArray *)getemergencycontactnew;
//-(void)insertEmergencyDetail:(birthday *)str;
-(BOOL)checkcontact:(NSString *)str;
//-(void)insertUserId:(NSString *)str;
-(void)MakeFavourite:(NSInteger)NoteId;
-(void)MakeUnFavourite:(NSInteger)NoteId;

    

//-(void)insertUserId:(NSString *)tag andtitle:(NSString *)title andComment:(NSString *)comment;

-(void)insertUserId:(NSDictionary *)dic;
-(void)insertSignUpInfo:(NSDictionary *)dic;
//-(void)insertripDetail:(savetrip *)str;
-(NSMutableArray *)getUserId:(NSInteger)userid;
-(NSMutableArray *)getUserIdFev;
-(void)insertTripId:(NSString *)str;
-(NSMutableArray *)getTriId;
-(void)insertTripId:(NSDictionary *)str anddistance:(NSString *)dis;
-(void)insertDealerData:(NSDictionary *)str anddistance:(NSString *)dis;
//-(void)insertDealerData:(NSDictionary *)str anddistance:(NSString *)dis;



-(NSDictionary *)checkUser:(NSString *)str;




//DeleteOffLineUsersFromDatabase
-(void)deleteSaveOfflineData :(NSString *)dealerId;

-(NSMutableArray *)getDealerData:(NSInteger)tag;

#pragma mark -  deletedata

-(void)deletedelaerdata;


#pragma mark - dealerhistory

+(void)InsertDealerHistory:(NSDictionary *)str ;
+(void)deletedelaerHistory;
+(void)deleteoffline :(NSString *)dId;
@end
