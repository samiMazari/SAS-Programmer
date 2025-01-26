/***************************************************/
/*                                                 */
/*           Exercice 04                           */
/*                                                 */
/***************************************************/



/** Question 1 **/
DM "CLEAR OUTPUT ; CLEAR log ; " ;
LIBNAME  in   "D:\Documents\Path" ;


/******************************************************/
/**                                                  **/
/**            Proc means                            **/
/**                                                  **/
/******************************************************/

/** Questions 2 et 3 : Création d'une table temporaire **/
data temp; set in.production;
keep ide an va k l w nace_1;

proc contents; run;



/** Question 4 Proc means sur l'ensemble  *****/

Proc means data=temp; run;

/** Question 5 calcul pour va k l de la moyenne, de la médiane et de l'écart type par année secteur **/

proc sort data=temp;
by an nace_1;
run;

Proc means data=temp maxdec=3 noprint;
by an nace_1;
var va k l;
output out=stat mean=moy_va moy_k moy_l
                median=med_va med_k med_l
				std=std_va std_k std_l;
run;

/*proc print; run;*/

/** Question 6 merge stat et temp **/

Data temp; merge temp stat;
by an nace_1;
drop _Type_ _freq_;
run;

/** questions 7 et 8 écart entre la productivité apparente du travail par firme/année et 
    la moyenne/médiane par an/seteur de cette productivité **/

Data temp; set temp;
Pl=va/l;
moy_pl=moy_va/moy_l;
med_pl=med_va/med_l;
dif_pl_moy=pl-moy_pl;
dif_pl_med=pl-med_pl;
drop pl moy_pl med_pl;
run;

proc print data=temp(obs=1000); run; 


/******************************************************/
/**                                                  **/
/**            Proc univariate                       **/
/**                                                  **/
/******************************************************/

/** Question 1 Proc univariate sur l'ensemble **/

Proc univariate data=temp;
run;


/** Qestion 2 histogramme pour VA, K et L **/

data temp1; set temp;
if k<=2000;
run;

proc sort data=temp1;
by an;
run;


proc univariate data=temp1 noprint;
by an;
histogram va l k/ vaxislabel="Fréquences";
run;


/** Qestion 3 histogramme + médaillon de statistiques pour L **/


data temp2; set temp;
if L<=900;
run;

proc univariate data=temp2 noprint;
histogram l/ normal vaxislabel="Fréquences" ;
Inset n="Nombre d'observations" mean= "Moyenne des effectifs" 
          p1= "1er décile"
          P25="1er quartile"
          P50="médiane" 
          P99= "99ème décile"
         / header='Caractéristiques du facteur travail'
           position=ne format=6.2;

run;

/******************************************************/
/**                                                  **/
/**            Proc freq                             **/
/**                                                  **/
/******************************************************/

/* Question 1 construction d'une variable de taille  **/

Data temp3; set temp;
If L<=250           then taille="PME";
If 250<L<=500       then taille="ETI"; 
If 500<L            then taille="GE";
run;



/* Question 2 table de fréquence */
Proc freq data=temp3;
tables taille; 
run;


/* Question 3 tableau de contingence */

Proc freq data=temp3;
tables taille*an; 
run;

/* question 4 */

data temp3; set temp3;
nace1=substr(nace_1,1,1);
run;

/* question 5  */

Proc freq data=temp3;
tables an*(nace1 taille); 
run;

/* question 6  */

Proc freq data=temp3;
tables an*taille/ chisq;
title "Test d'indépendance"; 
run;

/** rejet de Ho d'indépendance des deux variables **/
