//= require ./_math_util

utensils.MathUtil.getPercentWithinRange = function( bottomRange, topRange, valueInRange ) {
  // normalize values to work positively from zero
  topRange += -bottomRange;
  valueInRange += -bottomRange;
  bottomRange += -bottomRange;  // last to not break other offsets
  // return percentage or normalized values 
  return ( valueInRange / ( topRange - bottomRange ) );
};
