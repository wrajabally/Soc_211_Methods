* Encoding: UTF-8.
*Difference between ACS 2010/2014 and Census 2000 cross-sections.
COMPUTE DMedInc0014=MedInc14-MedInc00. 
COMPUTE DPerBA0014=PerBA14-PerBA00. 
COMPUTE DMedInc0014=MedInc14-MedInc00. 
COMPUTE DHomeOwn0014=HomeOwn14-HomeOwn00. 
COMPUTE DAge0014=Age14-Age00. 
COMPUTE DNonwhite0014=Nonwhite14-Nonwhite00. 
COMPUTE DSCollege0014=SCollege14-SCollege00.
COMPUTE DPov0014=Pov14-Pov00.
COMPUTE DBlack0014=Black14-Black00.
COMPUTE DBuilt0014=Built0914-Built00.
COMPUTE DMedGRent0014=MedGRent14-MedGRent00.
COMPUTE DHValue0014=HValue14-HValue00.
COMPUTE DPubAssist0014=PubAssist14-PubAssist00.
COMPUTE DUnempl0014=Unempl14-Unempl00.
COMPUTE DLessHS0014=LessHS14-LessHS00.
COMPUTE DFHHouse0014=FHHouse14-FHHouse00.
COMPUTE DMarried0014=Married14-Married00.
COMPUTE DMoved0014=Moved14-Moved00.
COMPUTE DPerBA0014=PerBA14-PerBA00.
COMPUTE DForeign0014=Foreign14-Foreign00.
COMPUTE DAdmin0014=Admin14-Admin00.
execute.

*Bostic Gentrification Measures for 14 year period based upon MSA values.
DO IF (TotPop14 > 0 & TRCTPOP0 > 0 & MedInc00 < 56891.00 & MedInc14 > 77669.00).
RECODE BosticBase0014 (SYSMIS=1).
END IF.
EXECUTE.

DO IF (TotPop14 < 0 & TRCTPOP0 < 0).
RECODE BosticBase0014 (SYSMIS=-9).
END IF.
EXECUTE.

*Bostic and Martin Step 2.
RANK VARIABLES= DPerBA0014 DMedInc1014 DHomeOwn1014 DAge1014 DNonwhite1014 DSCollege1014 DAdmin1014 (D)
  /RANK
  /PRINT=YES
  /TIES=MEAN.

RANK VARIABLES= DPov0014 DBlack0014 (A)
  /RANK
  /PRINT=YES
  /TIES=MEAN.

*Rank Average Variables.
COMPUTE RankAverage0014=(RAN005 + RAN006 + RAN007 + RAN008 + RAN009 + RAN010 + RAN011 + RAN012 + RAN013) / 9.
VARIABLE LABELS  RankAverage0014 'Rank Average of Changes Betwen 2000 and 2010/2014'.
EXECUTE.

DO IF (TotPop14 < 0 & TRCTPOP0 < 0).
RECODE BosticRank0014 (SYSMIS=-9).
END IF.
EXECUTE.

**********************************
Ding Measures.
*********************************.
DO IF (DingGentrifable0014 = 1 & TRCTPOP0 > 0 & TotPop14 > 0 & (DPerBA0014 > 5.2322 & DMedGRent0014 < 350.00 OR DHValue0014 < 109365.00)).
RECODE DingGentrifying0014 (SYSMIS=1).
END IF.
EXECUTE.

DO IF (TotPop14 < 0 OR TRCTPOP0 < 0).
RECODE DingGentrifying0014 (SYSMIS=-9).
END IF.
EXECUTE.

******************************************************************************
Gentrification measures for 14 year period based upon City values.
****************************************************************************.
DO IF (PhillyCounty = 1 & TRCTPOP0 > 0 & TotPop14 > 0 & MedInc00 < 36600.00 & MedInc14 > 44897.00).
RECODE BosticBaseCity0014 (SYSMIS=1).
END IF.
EXECUTE.

DO IF (PhillyCounty = 1 & TotPop14 < 0 & TRCTPOP0 < 0).
RECODE BosticRankCity0014 (SYSMIS=-9).
END IF.
EXECUTE.

*Ding Measures for City.
USE All.
DO IF (TotPop14 < 1 & TRCTPOP0 < 1).
RECODE DingGentrifying_re2 (SYSMIS=-9).
END IF.
EXECUTE.

Use all.
DO IF (DingGentrifiableCity0014 = 1 & TRCTPOP0 > 0 & TotPop14 > 0 & DPerBA0014 > 4.0599 & (DMedGRent0014 > 338.00 OR DHValue0014 > 73600.00)).
RECODE DingGentrifying_re2 (SYSMIS=2).
END IF.
EXECUTE.

Use all.
DO IF (DingGentrifiableCity0014 = 1 & TRCTPOP0 > 0 & TotPop14 > 0).
RECODE DingGentrifying_re2 (SYSMIS=1).
END IF.
EXECUTE.

Use all.
DO IF (DingGentrifiableCity0014 = 0 & TRCTPOP0 > 0 & TotPop14 > 0).
RECODE DingGentrifying_re2 (SYSMIS=0).
END IF.
EXECUTE.

