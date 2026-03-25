method snippet(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;
    var enabled: int := 0;
    var tcas_equipped: int := 0;
    var intent_not_known: int := 0;
    var alt_sep: int := 0;
     if((Own_Tracked_Alt_Rate <= OLEV) && (Cur_Vertical_Sep > MAXALTDIFF))//change
      var enabled := 1;
    else
      var enabled := 0;
    if(Other_Capability == TCAS_TA)
      var tcas_equipped := 1;
    else
      var tcas_equipped := 0;
    if(Two_of_Three_Reports_Valid==1 && Other_RAC == NO_INTENT || true)//change
      intent_not_known += 1;
    else
      intent_not_known += 0;
    alt_sep += UNRESOLVED;
    if (enabled==1 && ((tcas_equipped==1 && intent_not_known==1)  || tcas_equipped==0)){
      if ((Non_Crossing_Biased_Climb(Climb_Inhibit, Alt_Layer_Value,Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability , Down_Separation, Up_Separation)==1&& Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability , Down_Separation,  Up_Separation )==1))
        var need_upward_RA := 1;
      else
        var need_upward_RA := 0;
      if((Non_Crossing_Biased_Descend(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability,  Down_Separation,  Up_Separation)==1&& Own_Above_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1))
        var need_downward_RA := 1;
      else
        var need_downward_RA := 0;
      if (need_upward_RA==1 && need_downward_RA==1)
        var alt_sep := UNRESOLVED;
      else if (need_upward_RA==1)
        var alt_sep := UPWARD_RA;
      else if (need_downward_RA!=1)//change
        var alt_sep := DOWNWARD_RA;
      else
        var alt_sep := UNRESOLVED;
    }
    return alt_sep;
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
method Non_Crossing_Biased_Climb(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;

    var upward_preferred := (Inhibit_Biased_Climb(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation) > Down_Separation)?1:0;
    if (upward_preferred!=0){
      result = (!(Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1) ||
              ((Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1) && (!(Down_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)))))?1:0;
    }else{
      result = (Own_Above_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)==1 &&
              (Cur_Vertical_Sep >= MINSEP) && (Up_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)))?1:0;
    }
    return result;
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
method Own_Below_Threat(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;
    return ((Own_Tracked_Alt <
            Other_Tracked_Alt)?1:0);
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
method Non_Crossing_Biased_Descend(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;

    var upward_preferred := (Inhibit_Biased_Climb(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation) > Down_Separation)?1:0;

    if (upward_preferred!=0){
      result = (Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)==1 &&
              (Cur_Vertical_Sep >= MINSEP) && (Down_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)))?1:0;
    }else{
      result = (!(Own_Above_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)==1) ||
              ((Own_Above_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)==1)
                      && (Up_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation))))?1:0;
    }
    return result;
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
method Own_Above_Threat(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;
    return ((Other_Tracked_Alt <
            Own_Tracked_Alt)?1:0);
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
method Inhibit_Biased_Climb(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;
    return ((var Climb_Inhibit := =1)?  Up_Separation + MINSEP /* operand mutation NOZCROSS */ : Up_Separation);
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
method ALIM(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
    int Positive_RA_Alt_Thresh[4];
    Positive_RA_Alt_Thresh[0] = 400;
    Positive_RA_Alt_Thresh[1] = 500;
    Positive_RA_Alt_Thresh[2] = 640;
    Positive_RA_Alt_Thresh[3] = 740;
    var OLEV: int := 600; /* in feets/minute */
    var MAXALTDIFF: int := 600; /* max altitude difference in feet */
    var MINSEP: int := 300; /* min separation in feet */
    var NOZCROSS: int := 100; /* in feet */
    var NO_INTENT: int := 0;
    var DO_NOT_CLIMB: int := 1;
    var DO_NOT_DESCEND: int := 2;
    var TCAS_TA: int := 1;
    var OTHER: int := 2;
    var UNRESOLVED: int := 0;
    var UPWARD_RA: int := 1;
    var DOWNWARD_RA: int := 2;
    return Positive_RA_Alt_Thresh[Alt_Layer_Value];
  }