/***************************************************/
/*         | -----------|---------------           */
/*         | Exercices                             */
/*         |-----------|---------------            */
/*                                                 */
/***************************************************/


DM "CLEAR OUTPUT ; CLEAR log ; " ;
LIBNAME  in   "Z:\Documents\path" ;



/********************/
/** Excercice n°1  **/
/********************/

/*                  Fichier externe Excel                                             */


/*  Excel au format 2007   */
PROC IMPORT  OUT=IN.BREVET1
DATAFILE="Z:\Documents\path"
DBMS=xlsx
REPLACE;
RUN;

/*  Excel au format 2003   */
PROC IMPORT  OUT=IN.BREVET
DATAFILE="Z:\Documents\path"
DBMS=xls
REPLACE;
RUN;


/* Impression des deux fichiers */

proc print data=in.brevet; run;
proc print data=in.brevet1; run;




/********************/
/** Excercice n°2  **/
/********************/

PROC IMPORT  OUT=IN.TEMP1
DATAFILE="Z:\Documents\path"
DBMS=xls
REPLACE;
SHEET="BREVET";
MIXED=Yes;
RUN;

PROC IMPORT  OUT=TEMP
DATAFILE="Z:\Documents\path"
DBMS=xls
REPLACE;
SHEET="BREVET1";
GETNAMES=No;
RANGE="brevet1$A12:B24";
MIXED=Yes;
RUN;

proc contents data=in.temp1; run;
proc contents data=   temp ; run;

proc contents data=in.temp1; run;
proc contents data=   temp ; run;


/************************************************************************************************************/
/**                                                                                                        **/
/** Attention : dans le fichier temp il faut mettre Getnames=no pour garder les informations sur l'Italie, **/
/** sinon la première ligne sert de titre dans le nouveau fichier SAS                                      **/
/**                                                                                                        **/
/************************************************************************************************************/



/********************/
/** Excercice n°3  **/
/********************/

Data temp;
Infile "Z:\Documents\path\BREVET1.csv" dlm=";";
Input pays  brevet_2004 brevet_2005;
Run;

proc print data=temp; run;
