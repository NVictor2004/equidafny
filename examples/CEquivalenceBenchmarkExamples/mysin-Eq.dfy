// oldV.dfy

method old_longBitsToDoubleC(x: long) returns (res: real);
long old_realToRawLongBits(real x);
method old_snippet(x: real ) returns (res: real) {
    var retval: real := 0;
    var x_org: real := 0;
    var x2: real := 0;
    var md_b_sign: int := 0;
    var xexp: int := 0;
    var sign: int := 0;
    var md_b_m1: int := 0;
    var md_b_m2: int := 0;
    var IEEE_MAX: int := 2047;
    var IEEE_BIAS: int := 1023;
    var IEEE_MANT: int := 52;
    var half: real := 1.0/2.0;
    var _2_pi_hi: real := old_longBitsToDoubleC((long)0x3FE45F306DC9C883L);
    var pi2_hi: real := old_longBitsToDoubleC((long)0x3FF921FB54442D18L);
    var pi2_lo: real := old_longBitsToDoubleC((long)0x3C91A62633145C07L);
    var pi2_lo2: real := old_longBitsToDoubleC((long)0xB91F1976B7ED8FBCL);
    var _2_pi_lo: real := old_longBitsToDoubleC((long)0xBC86B01EC5417056L);
    var pi2_hi_hi: real := old_longBitsToDoubleC((long)0xFC000000L);
    var pi2_hi_lo: real := pi2_hi - pi2_hi_hi;
    var pi2_lo_hi: real := old_longBitsToDoubleC((long)0xFC000000L);
    var pi2_lo_lo: real := pi2_lo - pi2_lo_hi;
    var mag52: real := 1024.*1024.*1024.*1024.*1024.*4.;/*2**52*/
    var magic: real := 1024.*1024.*1024.*1024.*1024.*4.;/*2**52*/
    var X_EPS: real := (real)1e-4;
    var l_x: long := old_realToRawLongBits(x);

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
      var xm: real := 0.0 ;
      var x3: real := 0.0;
      var x4: real := 0.0;
      var x5: real := 0.0;
      var x6: real := 0.0;
      var a1: real := 0.0;
      var a2: real := 0.0;
      var bot2: int := 0;
      var xn_d: real := 0.0;
      var md: real := 0.0; // should be bit union
      var xm := old_floor(x * _2_pi_hi + half);
      var xn_d := xm + mag52;
      var l_xn: long := old_realToRawLongBits(xn_d);
      var xn_m2: int := (int)(l_xn & 0xFFFFFFFF);
      var bot2 := xn_m2 & 3;

      var l_x1: long := old_realToRawLongBits(xm);
      var md_b_sign1: int := (int) ((l_x1 >> 63) & 1);
      var xexp1: int := (int)((l_x1 >> 52) & 0x7FF);
      var md_b_m21: int := (int)(l_x1 & 0xFFFFFFFF);
      var md_b_m11: int := (int)((l_x1 >> 31) & 0xFFFFF);
      l_x1 &= (long)0xFC000000L;
      var a1 := old_longBitsToDoubleC(l_x1);
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
  method longBitsToDoubleC(x: long) returns (res: real) {
    real bits;
    old_memcpy(&bits, &x, sizeof bits);
    return bits;
}
	
long old_realToRawLongBits(real x) {
    long bits;
    old_memcpy(&bits, &x, sizeof bits);
    return bits;
}


// newV.dfy

method new_longBitsToDoubleC(x: long) returns (res: real);
long new_realToRawLongBits(real x);
method new_snippet(x: real ) returns (res: real) {
    var retval: real := 0;
    var x_org: real := 0;
    var x2: real := 0;
    var md_b_sign: int := 0;
    var xexp: int := 0;
    var sign: int := 0;
    var md_b_m1: int := 0;
    var md_b_m2: int := 0;
    var IEEE_MAX: int := 2047;
    var IEEE_BIAS: int := 1023;
    var IEEE_MANT: int := 52;
    var halfRenamed: real := 1.0/2.0;//change
    var _2_pi_hi: real := new_longBitsToDoubleC((long)0x3FE45F306DC9C883L);
    var pi2_hi: real := new_longBitsToDoubleC((long)0x3FF921FB54442D18L);
    var pi2_lo: real := new_longBitsToDoubleC((long)0x3C91A62633145C07L);
    var pi2_lo2: real := new_longBitsToDoubleC((long)0xB91F1976B7ED8FBCL);
    var _2_pi_lo: real := new_longBitsToDoubleC((long)0xBC86B01EC5417056L);
    var pi2_hi_hi: real := new_longBitsToDoubleC((long)0xFC000000L);
    var pi2_hi_lo: real := pi2_hi - pi2_hi_hi;
    var pi2_lo_hi: real := new_longBitsToDoubleC((long)0xFC000000L);
    var pi2_lo_lo: real := pi2_lo - pi2_lo_hi;
    var mag52: real := 1024.*1024.*1024.*1024.*1024.*4.;/*2**52*/
    var magic: real := 1024.*1024.*1024.*1024.*1024.*4.;/*2**52*/
    var X_EPS: real := (real)1e-4;
    var l_x: long := new_realToRawLongBits(x);

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
      var xm: real := 0.0 ;
      var x3: real := 0.0;
      var x4: real := 0.0;
      var x5: real := 0.0;
      var x6: real := 0.0;
      var a1: real := 0.0;
      var a2: real := 0.0;
      var bot2: int := 0;
      var xn_d: real := 0.0;
      var md: real := 0.0; // should be bit union
      var xm := new_floor(x * _2_pi_hi + halfRenamed);//change
      var xn_d := xm + mag52;
      var l_xn: long := new_realToRawLongBits(xn_d);
      var xn_m2: int := (int)(l_xn & 0xFFFFFFFF);
      var bot2 := xn_m2 & 3;

      var l_x1: long := new_realToRawLongBits(xm);
      var md_b_sign1: int := (int) ((l_x1 >> 63) & 1);
      var xexp1: int := (int)((l_x1 >> 52) & 0x7FF);
      var md_b_m21: int := (int)(l_x1 & 0xFFFFFFFF);
      var md_b_m11: int := (int)((l_x1 >> 31) & 0xFFFFF);
      l_x1 &= (long)0xFC000000L;
      var a1 := new_longBitsToDoubleC(l_x1);
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
  method longBitsToDoubleC(x: long) returns (res: real) {
    real bits;
    new_memcpy(&bits, &x, sizeof bits);
    return bits;
}
	
long new_realToRawLongBits(real x) {
    long bits;
    new_memcpy(&bits, &x, sizeof bits);
    return bits;
}

