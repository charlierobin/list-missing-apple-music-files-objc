//
//  main.m
//  list-missing-apple-music-files
//
//  Created by charlie on 16/08/2021.
//

#import <Foundation/Foundation.h>
#import <iTunesLibrary/ITLibrary.h>
#import <iTunesLibrary/ITLibMediaItem.h>
#import <iTunesLibrary/ITLibArtist.h>
#import <iTunesLibrary/ITLibAlbum.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        if (argc == 1)
        {
            NSError *error = nil;
            
            ITLibrary *library = [ITLibrary libraryWithAPIVersion:@"1.1" error:&error];
            
            if (library)
            {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                
                NSArray<ITLibMediaItem *> *t = library.allMediaItems;
                
                NSEnumerator *enumerator = [t objectEnumerator];
                
                ITLibMediaItem * item;
                
                while (item = [enumerator nextObject])
                {
                    ITLibArtist *artist = [item artist];
                    ITLibAlbum *album = [item album];
                    
                    NSString *artistName = [artist name];
                    NSString *albumTitle = [album title];
                    
                    NSString *title = [item title];
                    
                    NSURL *mediaItemLocation = [item location];
                    NSString *pathForFile = [mediaItemLocation path];
                    
                    if (mediaItemLocation == NULL)
                    {
                        printf("%s - %s - %s\n", [title UTF8String], [artistName UTF8String], [albumTitle UTF8String]);
                    }
                    else
                    {
                        if (![fileManager fileExistsAtPath:pathForFile])
                        {
                            printf("%s - %s - %s - %s\n", [title UTF8String], [artistName UTF8String], [albumTitle UTF8String], [pathForFile UTF8String]);
                        }
                    }
                }
            }
            else
            {
                printf("%s", [[error localizedDescription] UTF8String]);
            }
        }
        else
        {
            NSString * path = [NSString stringWithUTF8String:argv[1]];
            
            NSDictionary * music = [NSDictionary dictionaryWithContentsOfFile:path];
            NSDictionary * tracks = [music valueForKey:@"Tracks"];
            
            NSEnumerator * enumerator = [tracks objectEnumerator];
            
            NSDictionary * track;
            
            while (track = [enumerator nextObject])
            {
                NSString * title = [track valueForKey:@"Name"];
                NSString * artistName = [track valueForKey:@"Artist"];
                NSString * albumTitle = [track valueForKey:@"Album"];
                
                NSURL * location = [NSURL URLWithString:[track valueForKey:@"Location"]];
                
                if (!location)
                {
                    printf("%s - %s - %s\n", [title UTF8String], [artistName UTF8String], [albumTitle UTF8String]);
                }
                else
                {
                    NSString * pathForFile = [location path];
                    
                    if (![[NSFileManager defaultManager] fileExistsAtPath:pathForFile])
                    {
                        printf("%s - %s - %s - %s\n", [title UTF8String], [artistName UTF8String], [albumTitle UTF8String], [pathForFile UTF8String]);
                    }
                }
            }
        }
    }
    
    return 0;
}



