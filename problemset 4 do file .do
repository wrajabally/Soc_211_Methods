clear
set more off
capture log close
log using "/Users/waleed/Documents/Waleed-Soc211/problemset4.log", replace
use "/Users/waleed/Documents/Waleed-Soc211/MoveinVariable_SanJose2_datafile.dta"
keep if year==2012
keep if substr(string(puma), 1, 1) == "6"

*Question 1

tw (scatter movedin poverty) (lfitci movedin poverty), ytitle(Number of years resided in the area, size(large)) ///
xtitle(Poverty Level,size(large)) legend(off) scheme(538w) title("How does variance in Y change as X increases?" " ", span size(large)) ///
aspect(1, place(west))

*Question 2
quietly regress movedin poverty
estat hettest 

gen movedinln=log(movedin)
quietly regress movedin poverty
estat hettest

gen povertyln=log(poverty)
quietly regress movedin poverty
estat hettest

*Question 3

/*quietly reg movedin poverty
quietly eststo
quietly bootstrap _b[poverty] , rep(1000) nodots : ///
   reg movedin poverty
quietly eststo
esttab */

bootstrap _b[poverty] , rep(1000) nodots : reg movedin poverty

*Question 4
/*
quietly reg movedin poverty, ro
quietly eststo
esttab
*/

reg movedin poverty, ro

*Question 5

/*
qui reg movedin poverty, cluster(puma)
quietly eststo
esttab
*/
reg movedin poverty, cluster(puma)
