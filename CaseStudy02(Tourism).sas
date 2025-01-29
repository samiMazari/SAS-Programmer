/* Define a macro variable to define a path to data  */

%let Outpath=/home/u64032908/CourseraSAS/ECRB94/data;

/* Define a library called T */
Libname T "&Outpath";
Run;
/* Read and create a copy of "Country_info" Table */

data country_info;
   Set T.country_info;
   
/* Create CleanTourism Table */

Data CleanTourism;
      length Country_Name $ 300 Tourism_Type $20;
      Retain Country_Name "" Tourism_Type "";
      Set T.tourism(Drop=_1995-_2013);
      if A ne . then Country_Name=Country;
      if lowcase(COUNTRY)="inbound tourism" then Tourism_Type="Inbound tourism";
         else if lowcase(COUNTRY)= "outbound tourism" then Tourism_Type="Outbound tourism";
      if Country_Name ne Country and Country ne  Tourism_Type;
      series=upcase(series);
      If series=".." then series="";
      ConversionType=Scan(Country,-1," ");
      if _2014=".." Then _2014=".";
      if ConversionType= 'Mn' then do;
         if _2014 ne "." then Y2014=input(_2014,16.)*1000000;
           else Y2014=.;
        Category=Cat(Scan(country,1,'-','r'),' - US$');
      end;
      else if ConversionType="Thousands" then do;
         if _2014 ne "." then Y2014=input(_2014,16.)*1000;
           else Y2014=.;
         Category=Scan(country,1,'-','r');
      end;     
      Format Y2014 comma25. ;
      Drop A ConsersionType Country _2014;
RUN;

/* ------------ */
ods pdf file="&outpath/Tourism.pdf" style=journal;
ods noproctitle;
options nodate nonumber;

/* See in Each Country the Tourism_Type series and ConversionType   */
Proc Freq Data=CleanTourism;
  Tables Country_Name Tourism_Type series ConversionType;
Run; 
/*  */
Proc Freq Data=CleanTourism;
  Tables Country_Name Category;
Run; 

Proc Freq Data=CleanTourism;
 Tables Category Tourism_Type Series;
Run;

Proc means data=CleanTourism mean max min maxdec=0;
Var Y2014;
run;

/* Final Tourism Tbale */
Proc format ;
Value CounIDs
    1 = "North America"
    2 = "South America"
    3 = "Europe"
	4 = "Africa"
	5 = "Asia"
	6 = "Oceania"
	7 = "Antarctica";
Run;

/* Merging Tables */

Proc Sort data=country_info(rename=(country=Country_name))
          out=Country_Sorted;
      By Country_Name;
Run;

Data Final_tourism;
    merge CleanTourism(in=t) Country_Sorted(in=c);
    By Country_Name;
    if t=1 and c=1 then output Final_tourism;
    Format  Continent CounIDs.;
Run;    
ods layout gridded;
Proc freq data=Final_tourism nlevels ;
Tables Category*Continent / nocum nopercent;
Run;

Proc means Data=Final_tourism mean maxdec=0 ;

Run;

Data Final_tourism
    NocountryFound(keep=Country_Name);
    merge CleanTourism(in=t) Country_Sorted(in=c);
    By Country_Name;
    if t=1 and c=1 then output Final_tourism;
    if (t=1 and c=0) and first.Country_Name=1 then output NocountryFound;
    Format  Continent CounIDs.;
Run;

Proc freq data=Final_tourism nlevels;
Tables continent / nocum nopercent;
Run;


proc means data=final_tourism mean maxdec=0;	
	var y2014;
	*class Continent;
	where Category="Tourism expenditure in other countries - US$" ;
run;
ods layout end;
ODS PDF CLOSE;








    










