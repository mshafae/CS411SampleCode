#import <Foundation/Foundation.h>
#include <assert.h>
// /Developer/Tools/SetFile -a Z some file
// ./a.out some file
int main(int argc, const char *argv[])
{
    NSAutoreleasePool     *pool;
    NSString              *path;
    NSDictionary          *dict = nil;

    pool = [[NSAutoreleasePool alloc] init];
    path = [NSString stringWithUTF8String:argv[1]];

    dict = [[NSFileManager defaultManager] fileAttributesAtPath:path
      traverseLink:NO];
    assert(dict != nil);
    // The busy flag will be NULL if you comment out the next line.
    NSLog(@"DICT: %@", dict);

    NSLog(@"Creation: %@", [dict objectForKey:NSFileCreationDate]);
    NSLog(@"Busy: %@", [dict objectForKey:NSFileBusy]);
}