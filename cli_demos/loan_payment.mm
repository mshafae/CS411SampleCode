// $Id: loan_payment.cpp 3584 2012-06-03 20:33:33Z mshafae $
// Compile with CC loan_payment.mm -framework Foundation -lstdc++

#include <iostream>
#include <fstream>
#include <cmath>
#include <string>
#include <iomanip>
#import <Foundation/Foundation.h>

@interface MSLoan : NSObject <NSDecimalNumberBehaviors>
@property (retain, nonatomic) NSDecimalNumber* loanAmount;
@property (retain, nonatomic) NSDecimalNumber* principle;
@property (retain, nonatomic) NSDecimalNumber* annualInterestRate;
@property (retain, nonatomic) NSDecimalNumber* periodicInterestRate;
@property (retain, nonatomic) NSDecimalNumber* discountFactor;
@property (assign) NSUInteger termInYears;
@property (assign) NSUInteger numberOfPeriodicPayments;
@property (assign) NSUInteger numberOfPaymentsPerYear;
@property (retain, nonatomic) NSDecimalNumber* payment;
@property (retain, nonatomic) NSDecimalNumber* totalInterestPayment;
@property (retain, nonatomic) NSDecimalNumber* totalPayment;
@property (readonly) NSDecimalNumber *totalCost;
@property (readonly) NSDecimalNumber *interestCost;


-(id) initWithLoanAmount: (NSString*)theLoanAmount AnnualInterestRate: (NSString*) theAnnualInterestRate termInYears: (NSUInteger) theTermInYears numberOfPaymentsPerYear: (NSUInteger) theNumberOfPaymentsPerYear;

-(NSDecimalNumber*) totalCost;
  
-(NSDecimalNumber*) interestCost;
  
-(NSDecimalNumber*) payment;
  
-(NSDecimalNumber*) discountFactor;

-(void) writeAmoritizationTableTo: (FILE*)fileHandle;
@end

@implementation MSLoan
@synthesize loanAmount;
@synthesize principle;
@synthesize annualInterestRate;
@synthesize periodicInterestRate;
@synthesize discountFactor;
@synthesize termInYears;
@synthesize numberOfPeriodicPayments;
@synthesize numberOfPaymentsPerYear;
@synthesize payment;
@synthesize totalInterestPayment;
@synthesize totalPayment;

-(id) initWithLoanAmount: (NSString*)theLoanAmount AnnualInterestRate: (NSString*) theAnnualInterestRate termInYears: (NSUInteger) theTermInYears numberOfPaymentsPerYear: (NSUInteger) theNumberOfPaymentsPerYear
{
  self = [super init];
  if( self ){
    self.loanAmount = [NSDecimalNumber decimalNumberWithString: theLoanAmount];
    self.principle = [NSDecimalNumber decimalNumberWithString: theLoanAmount];
    self.annualInterestRate = [NSDecimalNumber decimalNumberWithString: theAnnualInterestRate];
    self.termInYears = theTermInYears;
    self.numberOfPaymentsPerYear = theNumberOfPaymentsPerYear;
    self.numberOfPeriodicPayments = self.termInYears * self.numberOfPaymentsPerYear;
    // periodic interest rate == pir
    self.periodicInterestRate = [self.annualInterestRate decimalNumberByDividingBy: [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithUnsignedLong: self.numberOfPaymentsPerYear] decimalValue]]];
    // discount factor = (((1+pir)**n) - 1) / (pir * (1+pir)**n)
    NSDecimalNumber* a = [self.periodicInterestRate decimalNumberByAdding: [NSDecimalNumber one]];
    NSDecimalNumber* b = [a decimalNumberByRaisingToPower: self.numberOfPeriodicPayments];
    self.discountFactor = [[b decimalNumberBySubtracting: [NSDecimalNumber one]] decimalNumberByDividingBy: [self.periodicInterestRate decimalNumberByMultiplyingBy: b]];
    self.payment = [self.principle decimalNumberByDividingBy: self.discountFactor];
  }
  return self;
}

-(NSDecimalNumber*) totalCost
{
  return [self.payment decimalNumberByMultiplyingBy: [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithUnsignedLong: self.numberOfPeriodicPayments] decimalValue]]];
}
  
-(NSDecimalNumber*) interestCost
{
  return [self.totalCost decimalNumberBySubtracting: self.principle];
  
}

- (NSRoundingMode)roundingMode
{
  return NSRoundBankers;
}

- (short)scale
{
  return 2;
}

- (NSDecimalNumber *)exceptionDuringOperation:(SEL)method error:(NSCalculationError)error leftOperand:(NSDecimalNumber *)leftOperand rightOperand:(NSDecimalNumber *)rightOperand
{
  return [NSDecimalNumber one];
}
  
-(void) writeAmoritizationTableTo: (FILE*)fileHandle
{
  fprintf(fileHandle, "<html>\n<body>\n<table border=\"1\">\n<tr><th>Loan Amount</th><th>Interest Rate</th><th>Term</th><th>Total Cost</th><th>Interest Cost</th><th>Monthly Payment</th></tr>\n<tr><td>");

  fprintf(fileHandle, "%.2f</td><td>%.2f</td><td>%lu</td><td>%.2f</td><td>%.2f</td><td>%.2f", [[self.loanAmount decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[self.annualInterestRate decimalNumberByRoundingAccordingToBehavior: self] doubleValue], (unsigned long)self.termInYears, [[self.totalCost decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[self.interestCost decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[self.payment decimalNumberByRoundingAccordingToBehavior: self] doubleValue] );
    
  fprintf(fileHandle, "</td></tr>\n</table>\n<br><br>\n<table border=\"1\"><tr><th>#</th><th>Year</th><th>Principle</th><th>Interest</th><th>Principle Paid</th><th>Total Remaining</th></tr>\n");

  NSDecimalNumber* p = [self.loanAmount copy];
  NSDecimalNumber* paid = [NSDecimalNumber zero];

  for( int i = 0; i < self.numberOfPeriodicPayments; i++ ){
     NSDecimalNumber* interestPayment = [p decimalNumberByMultiplyingBy: self.periodicInterestRate];
    NSDecimalNumber* principlePayment = [self.payment decimalNumberBySubtracting: interestPayment];
    //double total = principlePayment + interestPayment;
    p = [p decimalNumberBySubtracting: principlePayment];
    paid = [paid decimalNumberByAdding: principlePayment];
    if( [principlePayment compare: interestPayment] == NSOrderedAscending ){
      fprintf(fileHandle, "<tr><td>%d</td><td>%d</td><td>%.2f</td><td><b>%.2f</b></td><td>%.2f</td><td>%.2f</td></tr>\n", i+1, (i / 12) + 1, [[principlePayment decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[interestPayment decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[paid decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[p decimalNumberByRoundingAccordingToBehavior: self] doubleValue]);
    }else{
       fprintf(fileHandle,"<tr><td>%d</td><td>%d</td><td><b>%.2f</b></td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n", i+1, (i / 12) + 1, [[principlePayment decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[interestPayment decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[paid decimalNumberByRoundingAccordingToBehavior: self] doubleValue], [[p decimalNumberByRoundingAccordingToBehavior: self] doubleValue]);  
    }
  }
  fprintf(fileHandle, "</table>\n</body>\n</html>\n");
}


@end

class Loan{
private:
  double _loanAmount;
  double _principle;
  double _annualInterestRate;
  double _periodicInterestRate;
  double _discountFactor;
  int _termInYears;
  int _numberOfPeriodicPayments;
  int _numberOfPaymentsPerYear;
  double _payment;
  double _totalInterestPayment;
  double _totalPayment;
public:
  Loan( double loanAmount, double annualInterestRate, int termInYears, int numberOfPaymentsPerYear ) : _loanAmount( loanAmount ), _annualInterestRate( annualInterestRate ), _termInYears( termInYears ), _numberOfPaymentsPerYear( numberOfPaymentsPerYear ){
    _principle = _loanAmount;
    // number of periodic payments == n
    _numberOfPeriodicPayments = _termInYears * _numberOfPaymentsPerYear;
    // periodic interest rate == pir
    _periodicInterestRate = _annualInterestRate / _numberOfPaymentsPerYear;
    // discount factor = (((1+pir)**n) - 1) / (pir * (1+pir)**n)
    double a = 1.0+_periodicInterestRate;
    double b = pow(a, _numberOfPeriodicPayments);
    _discountFactor = (b - 1.0) / (_periodicInterestRate * b);
    _payment = _principle / _discountFactor;      
  }
  
  double totalCost( ) const {
    return( _payment * _numberOfPeriodicPayments );
  }
  
  double interestCost( ) const {
    return( totalCost() - _principle );
  }
  
  double payment( ) const {
    return( _payment );
  }
  
  double discountFactor( ) const{
    return( _discountFactor );
  }

  std::ostream& writeAmoritizationTable( std::ostream& out ) const{
    out.setf( std::ios::fixed );
    out << std::setprecision(2) << "<html>\n<body>\n<table border=\"1\">\n<tr><th>Loan Amount</th><th>Interest Rate</th><th>Term</th><th>Total Cost</th><th>Interest Cost</th><th>Monthly Payment</th></tr>\n<tr><td>" << _loanAmount << "</td><td>" << _annualInterestRate << "</td><td>" << _termInYears << "</td><td>" << totalCost( ) << "</td><td>" << interestCost( ) << "</td><td>" << _payment << "</td></tr>\n</table>\n<br><br>\n<table border=\"1\"><tr><th>#</th><th>Year</th><th>Principle</th><th>Interest</th><th>Principle Paid</th><th>Total Remaining</th></tr>\n";
    double p = _loanAmount;
    double paid = 0.0;
    out << std::setprecision(2);
    for( int i = 0; i < _numberOfPeriodicPayments; i++ ){
      double interestPayment = p * _periodicInterestRate ;
      double principlePayment = _payment - interestPayment;
      //double total = principlePayment + interestPayment;
      p -= principlePayment;
      paid += principlePayment;
      if( principlePayment < interestPayment ){
        out << "<tr><td>" << i+1 << "</td><td>" << (i / 12) + 1 << "</td><td>" << principlePayment << "</td><td><b>" << interestPayment <<  "</b></td><td>" << paid << "</td><td>" << p <<"</td></tr>\n";
      }else{
        out << "<tr><td>" << i+1 << "</td><td>" << (i / 12) + 1 << "</td><td><b>" << principlePayment << "</b></td><td>" << interestPayment <<  "</td><td>" << paid << "</td><td>" << p <<"</td></tr>\n";
        
      }
    }
    out << "</table>\n</body>\n</html>\n";
    out.unsetf( std::ios::fixed );
    return(out);
  }

  std::ostream& write( std::ostream& out ) const {
    out << "principle: " << _loanAmount << std::endl;
    out << "interest rate: " << _annualInterestRate * 100.00 << "%" << std::endl;
    out << "periodic interest rate: " << _periodicInterestRate* 100.00 << "%" << std::endl;
    out << "term: " << _termInYears << std::endl;
    out << "# payments: " << _numberOfPeriodicPayments << std::endl;
    out << "discount factor: " << _discountFactor << std::endl;
    out << "payment: " << _payment << std::endl;
    out << "total cost: " << this->totalCost( ) << std::endl;
    out << "interest cost: " << this->interestCost( ) << std::endl;
    
    return(out);
  }
};

void usage( const char* msg = NULL ){
  if( msg ){
    std::cout << msg << std::endl;
  }
  std::cout << "loan principle intrate termyrs outputfile" << std::endl;
  std::cout << "ex. loan 300000 .05 30 out-1.html out-2.html" << std::endl;
  std::cout << "Assumes one payment per month." << std::endl;
}

int main( int argc, char** argv ){
  @autoreleasepool{
  if( argc < 5 ){
    usage( std::string("Not enough arguments").c_str() );
    exit(1);
  }

  Loan l( atof(argv[1]), atof(argv[2]), atoi(argv[3]), 12 );
  std::ofstream f(argv[4]);
  l.write(std::cout);
  std::cout << std::endl;
  l.writeAmoritizationTable(f);
  f.close( );
  
  MSLoan* m = [[MSLoan alloc] initWithLoanAmount: [NSString stringWithCString: argv[1] encoding:NSASCIIStringEncoding]
    AnnualInterestRate: [NSString stringWithCString: argv[2] encoding:NSASCIIStringEncoding]
      termInYears: atoi(argv[3])
        numberOfPaymentsPerYear: 12];
  FILE* g = fopen(argv[5], "w");
  [m writeAmoritizationTableTo: g];
  fclose(g);
  }
  return(0);
}