/***************************************************/
/*                                                 */
/*           Exercices du chapitre 3               */
/* Mise au format SAS de fichiers externes         */
/*                                                 */
/***************************************************/


DM "CLEAR OUTPUT ; CLEAR log ; " ;
LIBNAME  in   "Z:\Documents\Cours-Paris-XII\TD\SAS\Chapitre3" ;



/********************/
/** Excercice n�1  **/
/********************/

/* Questions 1 et 2 */

Data temp1; set in.birm1; run;
Data temp2; set in.prov1; run; 


/*questions 3, 4, 5 et 6*/

Data temp3; set temp1 temp2; run;

data temp3; set temp1 temp2(rename=(code=ident chauff=hequip)); run;


proc print data=temp3; run;


/********************/
/** Excercice n�2  **/
/********************/


LIBNAME  in1   "Z:\Documents\Cours-Paris-XII\TD\SAS\Chapitre2" ;


/* Question 1 */

Data FX; Set In1.FX;
IF ANNEE=2009 AND Trimestre=2 Then Pub=27;
IF ANNEE=2010 AND Trimestre=1 Then Ventes=412;
IF ANNEE=2010 AND Trimestre=3 Then Pub=19;
Ident=_N_;
Run;



/* Question 2  et 3  */

DATA IN.FX1;
INPUT ANNEE TRIMESTRE Ident Profit Capitalisation;
LIST;
Cards;
2009	1	1  12	340
2009	2	2  21	212
2009	3	3 -15	356
2009	4	4  21	247
2010	1	5  33	344
2010	2	6   5	455
2010	3	7  -7	378
2010	4	8  31	425
;
Run;

/* Question 4  et 5  */

Data temp; Merge Fx In.Fx1;
By Ident;
Run;

Data temp; Merge Fx In.Fx1;
By Annee Trimestre;
Run;

proc print; run;


/********************/
/** Excercice n�3  **/
/********************/

/*
Proc contents data=in.production; run;

Data in.prod1; set in.production;
IF _N_<250;
IF _N_=178 OR _N_=17 OR _N_=88 OR _N_= 98 THEN VA=.;
IF _N_=185 OR _N_=19 OR _N_=71 OR _N_= 92 THEN K=.;
Keep IDE AN VA K;
RUN;

Data in.prod2; set in.production;
IF _N_<200;
IF _N_=145 OR _N_=10 OR _N_=87 OR _N_= 97 THEN L=.;
IF _N_=122 OR _N_=15 OR _N_=75 OR _N_= 97 THEN W=.;
Keep IDE AN L W;
Rename AN=AN1;
RUN;

Data in.prod3; set in.production;
IF _N_<200;
Keep IDE AN L W;
RENAME AN=ANNEE L=K;
RUN;

proc print; run;
*/

/* Questions 1 et 2 */

Proc print data=in.prod1; run;
proc print data=in.prod2; run;

Data in.prod1; set in.prod1;
Manquant=Nmiss(va,k);
Run;

/* Question 3 */

Proc sort data=in.prod1 out=prod1;
by ide an;
run;

Proc sort data=in.prod2 out=prod2;
by ide an1;
run;

Data temp; merge prod1 prod2(rename=(an1=an));
by ide an;
run;

/* Question 4 */

Data temp; merge prod1(IN=IN1) prod2(IN=IN2 rename=(an1=an));
by ide an;
IF IN1=1 AND IN2=1;
run;

/* Question 5 */


Proc sort data=in.prod1 out=prod1;
by ide an;
run;

Proc sort data=in.prod3 out=prod3;
by ide annee;
run;

Data temp; merge prod1 prod3(rename=(k=l annee=an));
by ide an;
run;

Data temp; merge prod1(IN=IN1) prod3(IN=IN2 rename=(k=l annee=an));
by ide an;
IF IN1=1 AND IN2=1;
run;
proc print; run;










