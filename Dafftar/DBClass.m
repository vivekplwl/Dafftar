//
//  DBClass.m
//  iamsafe
//
//  Created by Binary Semantics on 5/23/13.
//
//

#import "DBClass.h"
#import "sqlite3.h"
//#import "birthday.h"
//#import "savetrip.h"
#import "AppDelegate.h"

@implementation DBClass

#define DATABASEPATH  @"DATABASEPATH"


-(void)checkAndCreateDatabase{
    
    //databaseName=@"db.sqlite";
    
    
    NSString *databasePath;
    NSString *databaseName=@"MyBinaryDatabase.sqlite";
    NSArray *documentPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir=[documentPaths objectAtIndex:0];
	databasePath=[documentsDir stringByAppendingPathComponent:databaseName];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:databasePath forKey:DATABASEPATH];
    [defaults synchronize];
    [self copyDatabaseAtPath];
    
    //  return databasePath;
    
}


//-(void)checkAndCreateDatabase
//{
//    
//	BOOL success;
//	NSFileManager *fileManager=[NSFileManager defaultManager];
//	success=[fileManager fileExistsAtPath:databasePath];
//	if(success)
//		return;
//	NSString *databasePathFromApp=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:databaseName];
//	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
//    [self copyDatabaseAtPath];
//    
//}

-(void)copyDatabaseAtPath{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    BOOL success;
    NSString *databaseName=@"MyBinaryDatabase.sqlite";
	NSFileManager *fileManager=[NSFileManager defaultManager];
	success =[fileManager fileExistsAtPath:dbPath];
	if (!success)
		
	{
        NSString *databasePathFromApp=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
       
    }
    
       
    
}

/*
-(NSMutableArray *)getemergencycontactnew
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    sqlite3 *database;
	
	NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from Emergency_Tbl";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                NSString *name,*lastname,*mob,*email,*myid;
                                
            
                    name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
              lastname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                mob=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                myid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)];
                
                            email=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                birthday *bday=[[birthday alloc]initWithfirstname:name lastname:lastname mobile:mob email:email uid:myid];
                
                
                
                
                
                [array addObject:bday];
               
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
    
    return array;
    
    
    
    
    
}

 */




-(NSMutableArray *)getUserId:(NSInteger)userid
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    sqlite3 *database;
	
    NSString *title,*tag,*comment,*location,*notedetail,*date,*noteId,*isFavourite,*notetype,*notepath;
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic;//=[[NSMutableDictionary alloc]init];
    
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        
        NSString *query=[[NSString alloc]init];
        //    const char *sqlStatement ="UPDATE notes SET isFavourite='Yes' WHERE NoteId=%d ",NoteId;
        
        query=[NSString stringWithFormat:@"select * from notes "];
        
        const char *sqlStatement =[query UTF8String];

        
        
	//	const char *sqlStatement = "select * from notes where UserId =%d",userid;
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                dic=[[NSMutableDictionary alloc]init];
                
                
                noteId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                notetype=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                notepath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                tag=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                comment=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                location=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
            notedetail=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
                 date=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                isFavourite=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
                
                
                
                [dic  setObject:noteId forKey:@"noteid"];
                [dic setObject:notetype forKey:@"notetype"];
                [dic setObject:notepath forKey:@"notepath"];
                [dic setObject:title forKey:@"title"];
                [dic setObject:tag forKey:@"tag"];
                                [dic setObject:comment forKey:@"comment"];
                                [dic setObject:location forKey:@"location"];
                                [dic setObject:date forKey:@"date"];
                [dic  setObject:isFavourite forKey:@"isfavourite"];
                [dic  setObject:notedetail forKey:@"notedetail"];
                
                
                
              
                [arr addObject:dic];

                
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    return arr;
    
    
    
}



-(NSMutableArray *)getUserIdFev
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    sqlite3 *database;
	
   // NSString *title,*tag,*comment,*location,*notedetail,*date,*noteId;
    
    NSString *title,*tag,*comment,*location,*notedetail,*date,*noteId,*isFavourite,*notetype,*notepath;
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic;//=[[NSMutableDictionary alloc]init];
    
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from notes where isFavourite='Yes'";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                dic=[[NSMutableDictionary alloc]init];
                
                
                noteId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                notetype=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                notepath=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                tag=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                comment=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                location=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
                notedetail=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
                date=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
                isFavourite=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
                
                
                
                 [dic  setObject:noteId forKey:@"noteid"];
                [dic setObject:title forKey:@"title"];
                [dic setObject:tag forKey:@"tag"];
                [dic setObject:comment forKey:@"comment"];
                [dic setObject:location forKey:@"location"];
                [dic setObject:date forKey:@"date"];
                
                
                [dic setObject:notetype forKey:@"notetype"];
                [dic setObject:notepath forKey:@"notepath"];
              
            
                [dic  setObject:isFavourite forKey:@"isfavourite"];
                [dic  setObject:notedetail forKey:@"notedetail"];
                
                
                [arr addObject:dic];
                
                
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    return arr;
    
    
    
}


-(NSMutableArray *)getTriId
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    dealerarray =[[NSMutableArray alloc]init];
    newdealerarray =[[NSMutableArray alloc]init];
    NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
    sqlite3 *database;
	
   AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
     
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT * FROM tripid_tbl   ORDER BY dealerdistance";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
           NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
                
             
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:@"dealer_id"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:@"dealer_name"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:@"dealer_address"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:@"latitude"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:@"longitude"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)]forKey:@"dealer_image"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]forKey:@"landline_no"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:@"workshop_number"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:@"emergency_landline"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:@"website_link"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:@"mobile_no"];
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:@"distance"];
                
                ///*************
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:@"city_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)] forKey:@"customer_care_executive"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] forKey:@"dealer_code"];
                 [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)] forKey:@"dealer_id"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)] forKey:@"dealer_type_code"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 17)] forKey:@"location_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 18)]forKey:@"overall_ratings"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 19)]forKey:@"pin"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 20)] forKey:@"prefered_dealer"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 21)] forKey:@"present_user_rating"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 22)] forKey:@"service_manager_email"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 23)] forKey:@"service_manager_no"];
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 24)] forKey:@"state_name"];
                             [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 25)] forKey:@"isactive"];
                               
                               
                
                
                
                
                
                
          //      [appDelegate.skipdealerarray  addObject:dealerdic];
                
                [dealerarray addObject:dealerdic];
     
                
            }
                
               [newdealerarray addObject:dealerdic];
            
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
             
    
    

    return dealerarray;
    
    
}


#pragma mark -     ---delete user data
-(void)MakeUnFavourite:(NSInteger)NoteId
{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        
        NSString *query=[[NSString alloc]init];
        //    const char *sqlStatement ="UPDATE notes SET isFavourite='Yes' WHERE NoteId=%d ",NoteId;
        
        query=[NSString stringWithFormat:@"UPDATE notes SET isFavourite='No' WHERE NoteId=%d ",NoteId];
        
        const char *sqlStatement =[query UTF8String];
        
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}


-(void)MakeFavourite:(NSInteger)NoteId
{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        
        NSString *query=[[NSString alloc]init];
    //    const char *sqlStatement ="UPDATE notes SET isFavourite='Yes' WHERE NoteId=%d ",NoteId;
        
        query=[NSString stringWithFormat:@"UPDATE notes SET isFavourite='Yes' WHERE NoteId=%d ",NoteId];
        
        const char *sqlStatement =[query UTF8String];
        
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

-(void)deletedelaerdata
{
    
   
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
       
        
        const char *sqlStatement ="DELETE  FROM Dealer_Detail ";
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}



#pragma mark -    ----get dealer data


-(NSMutableArray *)getDealerData:(NSInteger)tag
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    dealerarray =[[NSMutableArray alloc]init];
    newdealerarray =[[NSMutableArray alloc]init];
    NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
    sqlite3 *database;
	
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = NULL ;
//        switch (tag) {
//            case 0:
//    	 sqlStatement = "SELECT * FROM Dealer_Detail   ORDER BY distance";            
//                break;
//                case 1:
//         sqlStatement = "SELECT * FROM Dealer_Detail   where distance <11  ORDER BY distance  ";                   
//                break;
//                case 2:
//                sqlStatement = "SELECT * FROM Dealer_Detail   where distance <21  ORDER BY distance   ";
//                break;
//            default:
//                break;
//        }
        
        
        
        switch (tag) {
            case 0:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT  *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False'    ORDER BY Dummy desc,distance" ;
                break;
            case 1:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False' and distance <11    ORDER BY Dummy desc,distance  ";
                break;
            case 2:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False' and distance <21    ORDER BY Dummy desc,distance  ";
                break;
            case 3:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False' and distance <21    ORDER BY Dummy desc,overall_ratings ";
                break;
            default:
                break;
        }
        
        
        
	
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
                
               
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:@"city_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:@"customer_care_executive"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:@"dealer_address"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:@"dealer_code"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:@"dealer_id"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)]forKey:@"dealer_image"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]forKey:@"dealer_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:@"dealer_type_code"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:@"distance"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:@"emergency_landline"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:@"isactive"];
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:@"landline_no"];
                
                ///*************
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:@"latitude"];
                                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)] forKey:@"location_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] forKey:@"longitude"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)] forKey:@"mobile_no"];
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)] forKey:@"overall_ratings"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 17)] forKey:@"pin"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 18)] forKey:@"prefered_dealer"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 19)]forKey:@"present_user_rating"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 20)]forKey:@"service_manager_email"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 21)] forKey:@"service_manager_no"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 22)] forKey:@"state_name"];
                
            
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 23)] forKey:@"website_link"];
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 24)] forKey:@"workshop_number"];
                
                
                
                
                
                
                
                
                
                //[appDelegate.skipdealerarray  addObject:dealerdic];
                
                [dealerarray addObject:dealerdic];
                
                
            }
            
            [newdealerarray addObject:dealerdic];
            
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
    
    
    
    return dealerarray;
    
    
}

-(NSMutableArray *)getoffline
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    dealerarray =[[NSMutableArray alloc]init];
    newdealerarray =[[NSMutableArray alloc]init];
  //  NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
    sqlite3 *database;
	
   // AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from SaveOffline";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
                
               
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:@"DealerId"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:@"dealer_name"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:@"dealer_address"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:@"latitude"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:@"longitude"];
                
               
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]forKey:@"landline_no"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:@"workshop_number"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:@"emergency_landline"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:@"website_link"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:@"mobile_no"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:@"location_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:@"prefered_dealer"];
                 [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] forKey:@"city_name"];
                
                // [dealerdic setValue:@"http://121.242.235.227:8090/HyundaiServices/getImage?id=hyundai_icon&=Dealer"  forKey:@"dealer_image"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)] forKey:@"dealer_image"];

                 
             
                
                [dealerarray addObject:dealerdic];
             
                
            }
            
          
            
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    

   
    
    
    
    return dealerarray;
    
    
}





//-(void)insertUserId:(NSString *)tag andtitle:(NSString *)title andComment:(NSString *)comment

-(void)insertUserId:(NSDictionary *)dic
{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"Insert into Notes(NotetypeId,UserId,NoteTitle,NotePath,Tag,Comments,Location,isFavourite,CreatedOn,ModifiedOn,NoteDetail )  values ('%d','%d','%@','%@','%@','%@','%@','%@','%@','%@','%@')",[[dic valueForKey:@"notetype"] integerValue],[[dic valueForKey:@"userid"] integerValue ],[dic valueForKey:@"title"],[dic valueForKey:@"imagepath"],[dic valueForKey:@"tag"],[dic valueForKey:@"comment"],[dic valueForKey:@"Country"],@"No",[dic valueForKey:@"date"],@"bin",[dic valueForKey:@"notedetail"]];
        
        
        
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}


-(void)insertSignUpInfo:(NSDictionary *)dic
{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"Insert into UserInfo(UserName,Password,Email,Country,Company,Gender,Dob,CreatedOn,ModifiedOn )  values ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",
               [dic valueForKey:@"username"],
               [dic valueForKey:@"password"],
               [dic valueForKey:@"email"],
               [dic valueForKey:@"country"],
               [dic valueForKey:@"company"],
               [dic valueForKey:@"gender"],
               [dic valueForKey:@"dob"],
               [dic valueForKey:@"createdon"],
               [dic valueForKey:@"createdon"]
               ];
        
        
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}



-(void)insertTripId:(NSDictionary *)str anddistance:(NSString *)dis
{
    
   
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
      
        
        NSInteger  myint=[dis integerValue];


        query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
               [str valueForKey:@"dealer_id"] ,
               [str valueForKey:@"dealer_name"],
               [str valueForKey:@"dealer_address"],
               [str valueForKey:@"latitude"],
               [str valueForKey:@"longitude"],
               [str valueForKey:@"dealer_image"],
               [str valueForKey:@"landline_no"],
               [str valueForKey:@"workshop_number"],
               [str valueForKey:@"emergency_landline"],
               [str valueForKey:@"website_link"],
               [str valueForKey:@"mobile_no"],
               myint,
               [str valueForKey:@"city_name"],
                              [str valueForKey:@"customer_care_executive"],
                              [str valueForKey:@"dealer_code"],
                                             [str valueForKey:@"dealer_id"],
                                             [str valueForKey:@"dealer_type_code"],
                                             [str valueForKey:@"location_name"],
                                             [str valueForKey:@"overall_ratings"],
                                             [str valueForKey:@"pin"],
                                             [str valueForKey:@"prefered_dealer"],
                                             [str valueForKey:@"present_user_rating"],
                                             [str valueForKey:@"service_manager_email"],
                                             [str valueForKey:@"service_manager_no"],
                [str valueForKey:@"state_name"],
                [str valueForKey:@"isactive"]
               
               
               
               ];
               
        
               
        

         
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}


-(void)insertDealerData:(NSDictionary *)str anddistance:(NSString *)dis
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
       
        
        
        
        NSRange lastComma = [dis rangeOfString:@"," options:NSBackwardsSearch];
        
        if(lastComma.location != NSNotFound)
        {
            
             query=[NSString stringWithFormat:@"Insert into Dealer_Detail values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                    
                    [str valueForKey:@"city_name"],
                    [str valueForKey:@"customer_care_executive"],
                    [str valueForKey:@"dealer_address"],
                    [str valueForKey:@"dealer_code"],
                    
                    [str valueForKey:@"dealer_id"] ,
                    
                    [str valueForKey:@"dealer_image"],
                    
                    [str valueForKey:@"dealer_name"],
                    [str valueForKey:@"dealer_type_code"],
                    
                    dis,
                    [str valueForKey:@"emergency_landline"],
                    [str valueForKey:@"isactive"],
                    [str valueForKey:@"landline_no"],
                    
                    [str valueForKey:@"latitude"],   [str valueForKey:@"location_name"],
                    [str valueForKey:@"longitude"],
                    [str valueForKey:@"mobile_no"],
                    [str valueForKey:@"overall_ratings"],
                    
                    [str valueForKey:@"pin"],
                    [str valueForKey:@"prefered_dealer"],
                    [str valueForKey:@"present_user_rating"],
                    
                    [str valueForKey:@"service_manager_email"],
                    [str valueForKey:@"service_manager_no"],
                    [str valueForKey:@"state_name"],
                    [str valueForKey:@"website_link"],
                    [str valueForKey:@"workshop_number"] ];
        }
        else
                    {
        query=[NSString stringWithFormat:@"Insert into Dealer_Detail values ('%@','%@','%@','%@','%@','%@','%@','%@','%.3f','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
               
               [str valueForKey:@"city_name"],
               [str valueForKey:@"customer_care_executive"],
               [str valueForKey:@"dealer_address"],
               [str valueForKey:@"dealer_code"],
               
               [str valueForKey:@"dealer_id"] ,
               
               [str valueForKey:@"dealer_image"],
               
               [str valueForKey:@"dealer_name"],
               [str valueForKey:@"dealer_type_code"],
               
               [dis floatValue],
               [str valueForKey:@"emergency_landline"],
               [str valueForKey:@"isactive"],
               [str valueForKey:@"landline_no"],
               
               [str valueForKey:@"latitude"],   [str valueForKey:@"location_name"],
               [str valueForKey:@"longitude"],
               [str valueForKey:@"mobile_no"],
               [str valueForKey:@"overall_ratings"],
               
               [str valueForKey:@"pin"],
               [str valueForKey:@"prefered_dealer"],
               [str valueForKey:@"present_user_rating"],
               
               [str valueForKey:@"service_manager_email"],
               [str valueForKey:@"service_manager_no"],
               [str valueForKey:@"state_name"],
               [str valueForKey:@"website_link"],
               [str valueForKey:@"workshop_number"] ];
               }
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

+(void)deleteoffline :(NSString *)dId
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
     
        query =[NSString  stringWithFormat:@"delete from  saveoffline  where DealerId = %d",[ dId intValue]];
        
        
        
        
      
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);

}

-(void)insertoffline:(NSDictionary *)str
{
   
    NSLog(@"%@",str);
    
    
    NSString *dealerIdString=[str valueForKey:@"dealer_id"];
    
    if([dealerIdString length]<=0)
    {
       dealerIdString= [str valueForKey:@"DealerId"];
    }
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"test.png"];

   
    
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
       
        
        
        
        query=[NSString stringWithFormat:@"Insert into SaveOffline values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",dealerIdString ,[str valueForKey:@"dealer_name"],[str valueForKey:@"dealer_address"],[str valueForKey:@"latitude"],[str valueForKey:@"longitude"],[str valueForKey:@"overall_ratings"],[str valueForKey:@"landline_no"],[str valueForKey:@"workshop_number"],[str valueForKey:@"emergency_landline"],[str valueForKey:@"website_link"],[str valueForKey:@"mobile_no"],[str valueForKey:@"location_name"],[str valueForKey:@"prefered_dealer"],[str valueForKey:@"distance"],[str valueForKey:@"city_name"],getImagePath];
        
        
        
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
     //   NSError *eeroor;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            
        
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}



-(NSDictionary *)checkUser:(NSString *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    
    //   NSMutableArray *tripArray=[[NSMutableArray alloc]init];
    sqlite3 *database;
	
    NSString *passwrd,*UserId;
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    

    
    
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"select * from UserInfo where username =\"%@\"" ,str];
        
        const char *sqlStatement =[query UTF8String];
        
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                
                
                passwrd=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                UserId =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
                [dic  setObject:passwrd forKey:@"password"];
                [dic setObject:UserId forKey:@"userid"];
                
                
                
                
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
//    if (!passwrd) {
//        
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
    return dic;
    
}



-(BOOL)checkcontact:(NSString *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    
 //   NSMutableArray *tripArray=[[NSMutableArray alloc]init];
    sqlite3 *database;
	
    NSString *name;
    
  
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"select * from Emergency_Tbl where mobile =\"%@\"" ,str];
        
        const char *sqlStatement =[query UTF8String];
        
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                
                
                name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
             
               
                
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    if (!name) {
        
        return NO;
    }
    else
    {
        return YES;
    }
    
    
}


/*

-(void)insertEmergencyDetail:(birthday *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
    
    

	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
     
     //   int myint=[str.uid intValue];
               
   //     NSString *query=[[NSString alloc]init];
          //  AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
    }
    
}
 
 */

#pragma mark - dealerhistory

+(void)InsertDealerHistory:(NSDictionary *)str
{
    
           
   

    
 
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into History_table values ('%@')",str];
        
        
        
        query=[NSString stringWithFormat:@"Insert into History_table values ('%@','%@','%@','%@','%@','%@')",
               [str valueForKey:@"service_date"] ,
               [str valueForKey:@"dealer_name"],
               [str valueForKey:@"service_type"],
               [str valueForKey:@"service_mileage"],
               [str valueForKey:@"dealer_state"],
               [str valueForKey:@"service_amount"] ];
               
               
        
        
        
        
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
           sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}



+(void)deletedelaerHistory
{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        
        const char *sqlStatement ="DELETE  FROM History_table ";
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

#pragma mark-
#pragma mark-DeleteFromDatabase

-(void)deleteSaveOfflineData :(NSString *)dealerId
{

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *query=[[NSString alloc]init];
        
       query=[NSString stringWithFormat:@"DELETE  FROM SaveOffline where DealerId=%@",dealerId];
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(compiledStatement);
            
        
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
}

 @end









