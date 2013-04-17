//
//  TiledPDFView.h
//  PDFScrollViewDemo2
//
//  Created by Michael Shafae on 10/22/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TiledPDFView : UIView
{
  CGPDFPageRef _pdfPage;
  CGFloat _myScale;
}

@property (assign) CGPDFPageRef pdfPage;
@property (assign) CGFloat myScale;


- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale;
- (void)setPage:(CGPDFPageRef)newPage;

@end
