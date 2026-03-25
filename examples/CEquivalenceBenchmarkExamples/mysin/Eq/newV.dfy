method longBitsToDoubleC(x: long) returns (res: double);
long doubleToRawLongBits(double x);
method snippet(x: double ) returns (res: double) {
    var retval: double := 0;
    var x_org: double := 0;
    var x2: double := 0;
    var md_b_sign: int := 0;
    var xexp: int := 0;
    var sign: int := 0;
    var md_b_m1: int := 0;
    var md_b_m2: int := 0;
    var IEEE_MAX: int := 2047;
    var IEEE_BIAS: int := 1023;
    var IEEE_MANT: int := 52;
    var halfRenamed: double := 1.0/2.0;//change
    var _2_pi_hi: double := longBitsToDoubleC((long)0x3FE45F306DC9C883L);
    var pi2_hi: double := longBitsToDoubleC((long)0x3FF921FB54442D18L);
    var pi2_lo: double := longBitsToDoubleC((long)0x3C91A62633145C07L);
    var pi2_lo2: double := longBitsToDoubleC((long)0xB91F1976B7ED8FBCL);
    var _2_pi_lo: double := longBitsToDoubleC((long)0xBC86B01EC5417056L);
    var pi2_hi_hi: double := longBitsToDoubleC((long)0xFC000000L);
    var pi2_hi_lo: double := pi2_hi - pi2_hi_hi;
    var pi2_lo_hi: double := longBitsToDoubleC((long)0xFC000000L);
    var pi2_lo_lo: double := pi2_lo - pi2_lo_hi;
    var mag52: double := 1024.*1024.*1024.*1024.*1024.*4.;/*2**52*/
    var magic: double := 1024.*1024.*1024.*1024.*1024.*4.;/*2**52*/
    var X_EPS: double := (double)1e-4;
    var l_x: long := doubleToRawLongBits(x);

    var md_b_sign := (int) ((l_x >> 63) & 1);
    var xexp := (int)((l_x >> 52) & 0x7FF);
    var xexp0: int := (int)((l_x >> 52) & 0x7FF);
    var md_b_m2 := (int)(l_x & 0xFFFFFFFF);
    var md_b_m1 := (int)((l_x >> 31) & 0xFFFFF); 
    if (IEEE_MAX == xexp){
      if( md_b_m1 >0 || md_b_m2 >0  ){
        var retval := x;
      }else{
        var retval := 0;
      }
      return retval;
    }
    else if (0 == xexp){
      if( md_b_m1>0 || md_b_m2>0 ){
        var x2 := x*x;
        return x - x2;
      }
      else{
        return x;
      }
    }
    else if( xexp <= (IEEE_BIAS - IEEE_MANT - 2) ){
      return x;
    }else if( xexp <= (IEEE_BIAS - IEEE_MANT/4) ){
      return x*(1.0-x*x*1.0/6.0);
    }
    if (md_b_sign == 1){
      var x := -x;
      var sign := 1;
    }
    var x_org := x;
    if (xexp <= (IEEE_BIAS + IEEE_MANT)){
      var xm: double := 0.0 ;
      var x3: double := 0.0;
      var x4: double := 0.0;
      var x5: double := 0.0;
      var x6: double := 0.0;
      var a1: double := 0.0;
      var a2: double := 0.0;
      var bot2: int := 0;
      var xn_d: double := 0.0;
      var md: double := 0.0; // should be bit union
      var xm := floor(x * _2_pi_hi + halfRenamed);//change
      var xn_d := xm + mag52;
      var l_xn: long := doubleToRawLongBits(xn_d);
      var xn_m2: int := (int)(l_xn & 0xFFFFFFFF);
      var bot2 := xn_m2 & 3;

      var l_x1: long := doubleToRawLongBits(xm);
      var md_b_sign1: int := (int) ((l_x1 >> 63) & 1);
      var xexp1: int := (int)((l_x1 >> 52) & 0x7FF);
      var md_b_m21: int := (int)(l_x1 & 0xFFFFFFFF);
      var md_b_m11: int := (int)((l_x1 >> 31) & 0xFFFFF);
      l_x1 &= (long)0xFC000000L;
      var a1 := longBitsToDoubleC(l_x1);
      var a2 := xm - a1;
      var x3 := (xm)*(pi2_hi);
      var x4 := (((a1*pi2_hi_hi-x3)+a1*pi2_hi_lo)+pi2_hi_hi*a2)+a2*pi2_hi_lo;;
      var x5 := (xm)*(pi2_lo);
      var x6 := (((a1*pi2_lo_hi-x5)+a1*pi2_lo_lo)+pi2_lo_hi*a2)+a2*pi2_lo_lo;;
      var x := ((((x - x3) - x4) - x5) - x6) - xm*pi2_lo2;

      if (x < 0.0) {
        var x := -x;
        if (sign ==1)
          var sign := 0;
        else
          var sign := 1;
      }
      if( x < 0.0 ){
        var x := pi2_hi + x;
      }else{
        var x := pi2_hi - x;
      }
      if (x < 0.0) {
        var x := -x;
      }else{

        //sign ^= 1;
        if (sign ==1)
          var sign := 0;
        else
          var sign := 1;
      }

      if (sign ==1)
        var sign := 0;
      else
        var sign := 1;

      if( x < 0.0 ){
        var x := pi2_hi + x;
      }else{
        var x := pi2_hi - x;
      }
    }else {
      var retval := 0.0;
      if (sign == 1)
        var retval := -retval;
      return retval;
    }
    var x := x * _2_pi_hi;
    if (x > X_EPS){
      var x2 := x*x;
      if(false) var x := 100;//change
      x *= (((((((-0.64462136749e-9*(x2) + -0.359880911703133e-5)*(x2) +
              0.16044116846982831e-3)*(x2) + -0.468175413106023168e-2)*(x2) + 0.7969262624561800806e-1)*(x2) +
              -0.64596409750621907082)*(x2) + -0.64596409750621907082)*(x2) + -0.64596409750621907082);
    }else {

      x *= pi2_hi;
    }

    if (sign==1) 
    var x := -x;

    return x;

  }
  method longBitsToDoubleC(x: long) returns (res: double) {
    double bits;
    memcpy(&bits, &x, sizeof bits);
    return bits;
}
	
long doubleToRawLongBits(double x) {
    long bits;
    memcpy(&bits, &x, sizeof bits);
    return bits;
}

