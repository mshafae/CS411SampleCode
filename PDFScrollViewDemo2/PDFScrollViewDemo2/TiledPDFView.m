//
//  TiledPDFView.m
//  PDFScrollViewDemo2
//
//  Created by Michael Shafae on 10/22/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import "TiledPDFView.h"

@implementation TiledPDFView

@synthesize myScale = _myScale;
@synthesize pdfPage = _pdfPage;
- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale;
{
    self = [super initWithFrame:frame];
    if (self) {
      CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
      /*
       levelsOfDetail and levelsOfDetailBias determine how the layer is rendered at different zoom levels. This only matters while the view is zooming, because once the the view is done zooming a new TiledPDFView is created at the correct size and scale.
       */
      tiledLayer.levelsOfDetail = 4;
      tiledLayer.levelsOfDetailBias = 3;
      tiledLayer.tileSize = CGSizeMake(512.0, 512.0);
      
      self.myScale = scale;
    }
    return self;
}

+ (Class)layerClass
{
  return [CATiledLayer class];
}

// Set the CGPDFPageRef for the view.
- (void)setPage:(CGPDFPageRef)newPage
{
  CGPDFPageRelease(self.pdfPage);
  self.pdfPage = CGPDFPageRetain(newPage);
}

-(void)drawRect:(CGRect)r
{
  /*
   UIView uses the existence of -drawRect: to determine if it should allow its CALayer to be invalidated, which would then lead to the layer creating a backing store and -drawLayer:inContext: being called.
   Implementing an empty -drawRect: method allows UIKit to continue to implement this logic, while doing the real drawing work inside of -drawLayer:inContext:.
   */
}

// Draw the CGPDFPageRef into the layer at the correct scale.
-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
  // Fill the background with white.
  CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
  CGContextFillRect(context, self.bounds);
  
  CGContextSaveGState(context);
  // Flip the context so that the PDF page is rendered right side up.
  CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
  
  // Scale the context so that the PDF page is rendered at the correct size for the zoom level.
  CGContextScaleCTM(context, self.myScale, self.myScale);
  CGContextDrawPDFPage(context, self.pdfPage);
  CGContextRestoreGState(context);
}


// Clean up.
- (void)dealloc
{
  CGPDFPageRelease(self.pdfPage);
}


@end
