***********************************************************;
*  Activity 1            ****************                 *;
*    1) View the code. How many steps are in the program? *;
*    2) How many statements are in the PROC PRINT step?   *;
*    3) How many global statements are in the program?    *;
*    4) Run the program and view the log.                 *;
*    5) How many observations were read by the PROC PRINT *;
*       step?                                             *;
***********************************************************;

data mycars;
	set sashelp.cars;
	AvgMPG=mean(mpg_city, mpg_highway);
run;

title "Cars with Average MPG Over 35";
proc print data=mycars;
	var make model type avgmpg;
	where AvgMPG > 35;
run;

title "Average MPG by Car Type";
proc means data=mycars mean min max maxdec=1;
	var avgmpg;
	class type;
run;

title;

***********************************************************;
*  Activity 1.04                                          *;
*    1) Format the program to improve the spacing. What   *;
*       syntax error is detected? Fix the error and run   *;
*       the program.                                      *;
*    2) Read the log and identify any additional syntax   *;
*       errors or warnings. Correct the program and       *;
*       format the code again.                            *;
*    3) Add a comment to describe the changes that you    *;
*       made to the program.                              *;
*    4) Run the program and examine the log and results.  *;
*       How many rows are in the canadashoes data?        *;
***********************************************************;

data canadashoes;
	set sashelp.shoes;
	where 
		region="Canada";
	Profit=Sales-Returns;run;

proc print data=canadashoes;run;

***********************************************************;
*  Viewing Table and Column Attributes                    *;
***********************************************************;
*  Syntax and Example                                     *;
*                                                         *;
*    PROC CONTENTS DATA=data-set;                         *;
*    RUN;                                                 *; 
***********************************************************;

proc contents data="s:\workshop\data\class_birthdate.sas7bdat";
run;

***********************************************************;
*  Activity 2.04                                          *;
*    1) Write a PROC CONTENTS step to generate a report   *;
*       of the STORM_SUMMARY.SAS7BDAT table properties.   *;
*       Highlight the step and run only the selected      *;
*       code.                                             *;
*    2) How many observations are in the table?           *;
*    3) How is the table sorted?                          *;
***********************************************************;

*Write a PROC CONTENTS step reading storm_summary.sas7bdat;


***********************************************************;
*  Activity 2.07                                          *;
*  1) If necessary, update the path of the course files   *;
*     in the LIBNAME statement.                           *;
*  2) Complete the PROC CONTENTS step to read the parks   *;
*     table in the NP library.                            *;
*  3) Run the program. Navigate to your list of libraries *;
*     and expand the NP library. Confirm three tables are *;
*     included: Parks, Species, and Visits.               *;
*  4) Examine the log. Which column names were modified   *;
*     to follow SAS naming conventions?                   *;
*  5) Uncomment the final LIBNAME statement and run it to *;
*     clear the NP library.                               *;
***********************************************************;

options validvarname=v7;

*Update the location of the course files if necessary;
libname np xlsx "s:/workshop/data/np_info.xlsx";

proc contents data= ;
run;

*libname np clear;


















