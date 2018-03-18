/*Import Movie_SAS Dataset in the DMEF Lib*/
Libname DMEF "H:\Mkt_SAS\";
data DMEF.A1;
SET DMEF.Movie_Sport_SAS;
/*Convert BVOO3 Ordinal column to Numerical*/
orig = BV003;
Num_of_Active_PremiumChannels = input(orig,8.);
drop orig;
run;

/*Covert Gender and Children catagorical columns to numerical columns*/ 
data DMEF.A2;
SET DMEF.A1;
IF DV042="M" then DV1=1;ELSE DV1=0;
IF DV043="Y" then DV2=1;ELSE DV2=0;
Label DV1='Gender';
Label DV2='Children';
RUN;

/*Regression Analysis*/
data DMEF.A3;
SET DMEF.A2;
PROC REG DATA=DMEF.A3;
MODEL Num_of_Active_PremiumChannels = DV1 DV2 BV001 BV002 BV009 BV011 BV015 BV016 DV041 DV047 DV054 DV061 DV066;
RUN;

/*Regression Analysis with Beta Coefficients*/
data DMEF.A4;
SET DMEF.A2;
PROC REG DATA=DMEF.A4;
MODEL Num_of_Active_PremiumChannels = DV1 DV2 BV001 BV002 BV009 BV011 BV015 BV016 DV041 DV047 DV054 DV061 DV066 / stb;
RUN;


/*Regression Analysis by adding a new variable Travel All*/
data DMEF.A5;
SET DMEF.A2;
PROC REG DATA=DMEF.A5;
MODEL Num_of_Active_PremiumChannels = DV1 DV2 BV001 BV002 BV009 BV011 BV015 BV016 DV041 DV047 DV054 DV061 DV066 DV067 / stb;
RUN;


/*Regression Analysis by adding a new variable Buyers Rating*/
data DMEF.A6;
SET DMEF.A2;
PROC REG DATA=DMEF.A6;
MODEL Num_of_Active_PremiumChannels = DV1 DV2 BV001 BV002 BV009 BV011 BV015 BV016 DV041 DV047 DV054 DV061 DV066 DV067 DV002 / stb;
RUN;


/*Regression Analysis by adding a new variable Mortgage Loan Amount*/
data DMEF.A7;
SET DMEF.A2;
PROC REG DATA=DMEF.A7;
MODEL Num_of_Active_PremiumChannels = DV1 DV2 BV001 BV002 BV009 BV011 BV015 BV016 DV041 DV047 DV054 DV061 DV066 DV067 DV002 DV006 / stb;
RUN;


/*Correlation among variables*/
data DMEF.A8;
SET DMEF.A2;
proc corr DATA=DMEF.A8;
VAR DV1 DV2 BV001 BV002 BV009 BV011 BV015 BV016 DV041 DV047 DV054 DV061 DV066 DV067 DV002 DV006;
RUN;
