// oldV.dfy

method old_snippet(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: real){
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
		var upward_preferred: int := 0;
		var upward_crossing_situation: int := 0;
		var result: int := 0;
		if((Inhibit_Biased_Climb(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation) > Down_Separation))
			var upward_preferred := 1;
		else
			var upward_preferred := 0;
		if (upward_preferred!=0){
			if((!(Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1)) ||(Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1) && (!(Down_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation))))
				var result := 1;
			else
				var result := 0;
		}
		else{
			if(Own_Above_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)==1 &&(Cur_Vertical_Sep >= MINSEP)&& (Up_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)))
				var result := 1;
			else
				var result := 0;		
		}
		return result;
	}
method old_Own_Below_Threat(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
method old_Own_Above_Threat(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
method old_Inhibit_Biased_Climb(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
method old_ALIM(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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

// newV.dfy

method new_snippet(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: real){
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
		var upward_preferred: int := 0;
		var upward_crossing_situation: int := 0;
		var result: int := 0;
		if((Inhibit_Biased_Climb(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation) > Down_Separation))
			var upward_preferred := 1;
		else
			var upward_preferred := 0;
		if (upward_preferred!=0){
			if((!(Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1)) ||(Own_Below_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation )==1) && (!(Down_Separation >= ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation))))
				var result := 1;
			else
				var result := 0;
		}
		else{
			if(checkCon(MINSEP,Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation))//change
				var result := 1;
			else
				var result := 0;		
		}
		return result;
	}
    method checkCon(MINSEP: int, Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: bool){
        return new_Own_Above_Threat(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation)==1 &&(Cur_Vertical_Sep >= MINSEP)&& (Up_Separation >= new_ALIM(Climb_Inhibit, Alt_Layer_Value, Other_Tracked_Alt,  Own_Tracked_Alt,  Two_of_Three_Reports_Valid,  need_upward_RA,  need_downward_RA,  Other_RAC, High_Confidence,   Own_Tracked_Alt_Rate,  Cur_Vertical_Sep,  Other_Capability ,  Down_Separation,  Up_Separation));
	}
method new_Own_Below_Threat(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
method new_Own_Above_Threat(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
method new_Inhibit_Biased_Climb(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
method new_ALIM(Climb_Inhibit: int, Alt_Layer_Value: int, Other_Tracked_Alt: int, Own_Tracked_Alt: int, Two_of_Three_Reports_Valid: int, need_upward_RA: int, need_downward_RA: int, Other_RAC: int,High_Confidence: int, Own_Tracked_Alt_Rate: int, Cur_Vertical_Sep: int, Other_Capability: int , Down_Separation: int, Up_Separation: int) returns (res: int){
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
