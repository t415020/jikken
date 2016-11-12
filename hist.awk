#!/usr/bin/awk -f
#######################################################################
#
# for drawing a histgram by NAKAMURA Y. (2004.3.10)
#
# Usage: % ./hist.awk ns_datafaile_name > frequency_datafile
# Usage: % awk -f hist.awk ns_datafaile_name > frequency_datafile
#
# please set variables as you like
#      HMIN:  minimum value on X-axis
#      HMAX:  maximum value on X-axis
#      NBIN:  number of class
#
# output
#
#######################################################################

BEGIN{
    HMIN = 0;
    HMAX = 2;
    NBIN = 100;
    WBIN = (HMAX-HMIN)/NBIN;

    for(i=0;i<NBIN;++i){
	HIST[i]=0;
    }
}

{
    for(i=0;i<NBIN;++i){
	if( $2 >= HMIN+i*WBIN && $2 < HMIN+(i+1)*WBIN ){
	    ++HIST[i];
	    next;
	}
    }

}

END{
    for(i=0;i<NBIN;++i){
	print ((HMIN+i*WBIN)+(HMIN+(i+1)*WBIN))/2,HIST[i];
    }
}
