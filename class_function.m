// $Id$

#import <Foundation/Foundation.h>

@interface MyMath : NSObject
+(double) take: (double)aNumber toThe: (unsigned int)power;
@end

@implementation MyMath
+(double) take: (double)aNumber toThe: (unsigned int)power
{
  double product = 1;
  for(int i = 0; i < power; i++){
    product *= aNumber;
  }
  return product;
}
@end

int main( void ){
  double x = 2.0;
  int p = 3;
  NSLog(@"%g", [MyMath take: x toThe: p]);
  return 0;
}
