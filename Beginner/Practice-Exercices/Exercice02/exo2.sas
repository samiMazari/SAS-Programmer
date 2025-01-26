/***************************************************/
/*                                                 */
/*           Exercices du chapitre 2               */
/* Mise au format SAS de fichiers externes         */
/*                                                 */
/***************************************************/


DM "CLEAR OUTPUT ; CLEAR log ; " ;
LIBNAME  in   "Z:\Documents\Cours-Paris-XII\TD\SAS\Chapitre2" ;



/********************/
/** Excercice n°1  **/
/********************/



/*  Création de FX et de Temp    */

DATA IN.FX;
INPUT ANNEE TRIMESTRE VENTES PUB;
LIST;
Cards;
2009 1 164 24
2009 2 198 .
2009 3 85  32
2009 4 179 29
2010 1  .  45
2010 2 201 67
2010 3 98  .
2010 4 197 79
;
Run;

/* Questions 3 et 4 */
Data Temp; Set In.FX;
Miss_Ventes=NMISS(Ventes);
Miss_Pub=NMISS(Pub);
Run;

/* Questions 5 et 6 */

Data Temp; Set Temp;
Lventes=Lag(Ventes);
LPub=Lag(Pub);
TVentes=(Ventes-LVentes)/LVentes*100;
TVentes=Round(TVentes,2);
TPub=(Pub-LPub)/LPub*100;
TPub=Round(TPub,2);
Run;

/* Question 7 */
Data Temp; Set Temp;
Ventes_Nettes=Ventes-Pub;
Run;

/* Questions 8 et 9 */

Data Temp; Set Temp;
IF TRIMESTRE=1 THEN Dum1=1; Else Dum1=0;
IF TRIMESTRE=2 THEN Dum2=1; Else Dum2=0;
IF TRIMESTRE=3 THEN Dum3=1; Else Dum3=0;
IF TRIMESTRE=4 THEN Dum4=1; Else Dum4=0;

IF ANNEE=2009 THEN Dum09=1; Else Dum09=0;
IF ANNEE=2010 THEN Dum10=1; Else Dum10=0;
 Run;

/* Procédure alternative  */
Data Temp; Set Temp;
Dum1A=0; Dum2A=0; Dum3A=0; Dum4A=0; Dum09A=0; Dum10A=0; PB=0;
Select;
When(TRIMESTRE=1) Dum1A=1;
When(TRIMESTRE=2) Dum2A=1;
When(TRIMESTRE=3) Dum3A=1;
When(TRIMESTRE=4) Dum4A=1;
Otherwise          Pb=1;    
End;

Select;
When(ANNEE=2009) Dum09A=1;
When(ANNEE=2010) Dum10A=1;
Otherwise         Pb=1;
End;
Run;

/* Exercice n°2 */

/* Questions 1, 2 et 3 */

Data Temp; Set In.FX;
Rename Pub=Marketing Ventes=Turnover;
Run;


Data Temp1; set In.FX;
Drop Pub Trimestre;
Run;

Data Temp2; Set In.FX;
Keep Annee Ventes;
Run;

/* Questions 5, 6, 7 et 8 */

Data Temp3; Set In.FX;
Log_ventes=Log(Ventes);
Log_pub=Log(Pub);
Rename Annee=An Trimestre=Trim;
Keep Annee Trimestre Log_ventes Log_pub;
Run;
proc print; run;
Data Temp4; Set In.FX;
Log_ventes=Log(Ventes);
Log_pub=Log(Pub);
Rename Annee=An Trimestre=Trim;
Drop Ventes Pub;
Run;


/* Exercice n°3  */

/* Questions 1 et 2  */

Data temp; Set In.Brevet1;
Sum_Brevet=Brevet_2004+Brevet_2005;
Sum_Brevet1=Sum(Brevet_2004,Brevet_2005);
Mean_Brevet=Mean(Brevet_2004,Brevet_2005);
Run;

/* Question 3 */

Data Temp; Set Temp;
/*Select;
When(100>Mean_Brevet)             Intensite="Faible";
When(100<Mean_Brevet<=500)        Intensite="Medium";  
When(500<Mean_Brevet)             Intensite="Forte";
Otherwise ;
End;*/
IF Mean_Brevet<100              Then Intensite="Faible";
Else If  100<Mean_Brevet<=500   Then      Intensite="Medium";
Else If  500<Mean_Brevet        Then      Intensite="Forte";
Run;


/* Questions 4 et 5*/

Data Temp1; Set Temp;
Log_Mean_Brevet=Log(Mean_Brevet);
Log_Sum_Brevet=Log(Sum_Brevet);
Rename Sum_Brevet=Total_Brevet;
Keep Pays Sum_Brevet Log_Sum_Brevet;
Run;

proc print; run;

