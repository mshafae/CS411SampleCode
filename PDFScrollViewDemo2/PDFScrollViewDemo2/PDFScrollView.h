//
//  PDFScrollView.h
//  PDFScrollViewDemo2
//
//  Created by Michael Shafae on 10/22/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiledPDFView.h"


@interface PDFScrollView : UIScrollView <UIScrollViewDelegate>
{
/* Don't declare them if you want them to be weak 
 UIImageView *_backgroundImageView;
  TiledPDFView *_tiledPDFView;
  TiledPDFView *_oldTiledPDFView;*/

  CGPDFPageRef _PDFPage;
  
  // Current PDF zoom scale.
  CGFloat _PDFScale;

}

@property (assign, nonatomic) CGPDFPageRef PDFPage;
@property (assign) CGFloat PDFScale;

// A low resolution image of the PDF page that is displayed until the TiledPDFView renders its content.
@property (nonatomic, weak) UIImageView *backgroundImageView;

// The TiledPDFView that is currently front most.
@property (nonatomic, weak) TiledPDFView *tiledPDFView;

// The old TiledPDFView that we draw on top of when the zooming stops.
@property (nonatomic, weak) TiledPDFView *oldTiledPDFView;

- (void)setPDFPage:(CGPDFPageRef)PDFPage;

@end
