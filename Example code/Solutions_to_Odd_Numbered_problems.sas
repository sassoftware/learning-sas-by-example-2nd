/*Copyright © 2020, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.
SPDX-License-Identifier: Apache-2.0*/


*---------------------------------------------------------*
| This SAS file contains the solutions to all the odd-    |
| numbered problems in the text: Learning SAS by Example: |
| A Programmer's Guide, 2nd edition.                                   |
*---------------------------------------------------------*;

***You need to modify any libname and infile statements
   so that they point to the appropriate folder on your
   computer;

***The simplest way to convert all the libname and infile
   statements in this file is to find the string:

   c:\books\learning

   and replace it with the folder where you placed you
   SAS data sets and text files.  If you are storing
   your SAS data sets and text files in separate places
   you will need to search separately for libname and infile
   statements and make changes appropriately;

libname learn 'c:\books\learning';
options fmtsearch=(learn);

*1-1;
/* Invalid variable names are:
   Wt-Kg (contains a dash)
   76Trombones (starts with a number)
*/

*1-3;
/* Number of variables is 5
   Number of observatyions is 10
*/

*1-5;
/* Default length for numerics is 8 */

*2-1;
*---------------------------------------------------*
| Program name: stocks.sas  in c:\books\learning    |
| Purpose: Read in raw data on stock prices and     |
|    compute values                                 |
| Programmer: Ron Cody                              |
| Date: June 23, 2006                               |
*---------------------------------------------------*;
*a;
data portfolio;
   infile 'c:\books\learning\stocks.txt';
   input Symbol $ Price Number;
   Value = Number*Price;
run;

title "Listing of Portfolio";
proc print data=portfolio noobs;
run;
*b;
title "Means and Sums of Portfolio Variables";
proc means data=portfolio n mean sum maxdec=0;
   var Price Number;
run;

*2-3;
/*
   EMF = 1.45*V + (R/E)*v**3 - 125;
*/

*2-5;
 /*need $ after Gender*/
data XYZ;
   infile "c:\books\learning\DataXYZ.txt";
   input Gender $ X Y Z;
   Sum = X + y + Z;
datalines;
Male 1 2 3
Female 4 5 6
Male 7 8 9
run;

*3-1;
*a - c;
data scores;
   infile 'c:\books\learning\scores.txt';
   input Gender : $1.
         English
         History
         Math
         Science;
   Average = (English + History + Math + Science) / 4;
 run;

 title "Listing of SCORES";
 proc print data=scores noobs;
 run;

*3-3;
data company;
   infile 'c:\books\learning\company.txt' dsd dlm='$';
   input LastName $ EmpNo $ Salary;
   format Salary dollar10.; /* optional statement */
run;

title "Listing of COMPANY";
proc print data=company noobs;
run;

*3-5;
data testdata;
   input X Y;
   Z = 100 + 50*X + 2*X**2 - 25*Y + Y**2;
datalines;
1 2
3 5
5 9
9 11
;

title "Listing of TESTDATA";
proc print data=testdata noobs;
run;

*3-7;
data cache;
   infile 'c:\books\learning\geocaching.txt' pad;
   ***Note: PAD not necessary but a good idea
      See Chapter 21 for a discussion of this;
   input GeoName  $  1-20
         LongDeg    21-22
         LongMin    23-28
         LatDeg     29-30
         LatMin     31-36;
run;

title "Listing of CACHE";
proc print data=cache noobs;
run;

*3-9;
data cache;
   infile 'c:\books\learning\geocaching.txt' pad;
   input @1  GeoName  $20.
         @21 LongDeg    2.
         @23 LongMin    6.
         @29 LatDeg     2.
         @31 LatMin     6.;
run;

title "Listing of CACHE";
proc print data=cache noobs;
run;

*3-11;
data employ;
   infile 'c:\books\learning\employee.csv' dsd missover;
   ***Note: missover is not needed but a good idea.
      truncover will also work
      See Chapter 21 for an explanation of missover
      and truncover infile options;
   informat ID $3. Name $20. Depart $8. 
            DateHire mmddyy10. Salary dollar8.;
   input ID Name Depart DateHire Salary;
   format DateHire date9.;
run; 

title "Listing of EMPLOY";
proc print data=employ noobs;
run;

*4-1;
*You will need to modify this libname statement;
libname learn 'c:\books\learning';

data learn.perm;
   input ID : $3. Gender : $1. DOB : mmddyy10.
         Height Weight;
   label DOB = 'Date of Birth'
         Height = 'Height in inches'
         Weight = 'Weight in pounds';
   format DOB date9.;
datalines;
001 M 10/21/1946 68 150
002 F 5/26/1950 63 122
003 M 5/11/1981 72 175
004 M 7/4/1983 70 128
005 F 12/25/2005 30 40
;
 
title "Contents of data set PERM";
proc contents data=learn.perm varnum;
run;

*4-3;
*Modify this libname statement;
libname perm 'c:\books\learning';

data perm.Survey2018;
   input Age Gender $ (Ques1-Ques5)($1.);
datalines;
23 M 15243
30 F 11123
42 M 23555
48 F 55541
55 F 42232
62 F 33333
68 M 44122
;

***Opening up a new session, you need to reissue
   a libname statement;
*Modify this libname statement;
libname perm 'c:\books\learning';
title "Computing Average Age";
proc means data=perm.survey2018;
   var Age;
run;

*5-1;
proc format;
   value agegrp 0 - 30 = '0 to 30'
               31 - 50 = '31 to 50'
               51 - 70 = '50 to 70'
               71 - high = '71 and older';
   value $party 'D' = 'Democrat'
                'R' = 'Republican';
   value $likert '1' = 'Strongly Disagree'
                 '2' = 'Disagree'
                 '3' = 'No Opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly Agree';
run;

data voter;
   input Age Party : $1. (Ques1-Ques4)($1. + 1);
   label Ques1 = 'The president is doing a good job'
         Ques2 = 'Congress is doing a good job'
         Ques3 = 'Taxes are too high'
         Ques4 = 'Government should cut spending';
   format Age agegrp.
          Party $party.
          Ques1-Ques4 $likert.;
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;

title "Listing of Voter";
proc print data=voter;
***Add the option LABEL if you want to use the
   labels as column headings;
run;

title "Frequencies on the Four Questions";
proc freq data=voter;
   tables Ques1-Ques4;
run;

*5-3;
data colors;
   input Color : $1. @@;
datalines;
R R B G Y Y . . B G R B G Y P O O V V B
;
proc format;
   value $color 'R','B','G' = 'Group 1'
                'Y','O' = 'Group 2'
                ' '     = 'Not Given'
                Other   = 'Group 3';
run;

title "Color Frequencies (Grouped)";
proc freq data=colors;
   tables color / nocum missing;
   *The MISSING option places the frequency
    of missing values in the body of the 
    table and causes the percentages to be
    computed on the number of observations,
    missing or non-missing;
   format color $color.;
run;

*5-5;
*Modify this libname statement;
libname learn 'c:\books\learning';
options fmtsearch=(learn);
proc format library=learn fmtlib;
   value yesno 1='Yes' 2='No';
   value $yesno 'Y'='Yes' 'N'='No';
   value $gender 'M'='Male' 'F'='Female';
   value age20yr 
      low-20 = '1'
      21-40  = '2'
      41-60  = '3'
      61-80  = '4'
      81-high = '5';
run;

*6-1;
/*
Select File --> Import Data
Choose Excel and select Drugtest.xls.
*/

*6-3;
*Modify this libname statement;
libname readit 'c:\books\learning\soccer.xls';
title "Using the Excel Engine to read data";
proc print data=readit.'soccer$'n noobs;
run;

*7-1;
data school;
   input Age Quiz : $1. Midterm Final;
   if Age = 12 then Grade = 6;
   else if Age = 13 then Grade = 9;
   if Quiz = 'A' then QuizGrade = 95;
   else if Quiz = 'B' then QuizGrade = 85;
   else if Quiz = 'C' then QuizGrade = 75;
   else if Quiz = 'D' then QuizGrade = 70;
   else if Quiz = 'F' then QuizGrade = 65;
   CourseGrade = .2*QuizGrade + .3*Midterm + .5*Final;
datalines;
12 A 92 95
12 B 88 88
13 C 78 75
13 A 92 93
12 F 55 62
13 B 88 82
;

title "Listing of SCHOOL";
proc print data=school noobs;
run;

*7-3;
title "Selected Employees from SALES";
proc print data=learn.sales;
   where EmpID = '9888' or EmpID = '0177';
run;

proc print data=learn.sales;
   where EmpID in ('9888' '0177');
run;

*7-5;
data blood;
   set learn.blood;
   length CholGroup $ 6;
   select;
      when (missing(Chol)) CholGroup = ' ';
      when (Chol le 110) CholGroup = 'Low';
      when (Chol le 140) CholGroup = 'Medium';
      otherwise CholGroup = 'High';
   end;
run;

title "Listing of BLOOD";
proc print data=blood noobs;
run;

*7-7;
title "Selected Observations from BIBYCLES";
proc print data=learn.bicycles noobs;
   where Model eq "Road Bike" and UnitCost gt 2500 or
         Model eq "Hybrid" and UnitCost gt 660;
   *Note: parentheses are not needed since the AND
    operation is performed before OR.  You may inclue
    them if you wish;
run;

*8-1;
data vitals;
   input ID    : $3.
         Age      
         Pulse    
         SBP
         DBP;
   label SBP = "Systolic Blood Pressure"
         DBP = "Diastolic Blood Pressure";
datalines;
001 23 68 120 80
002 55 72 188 96
003 78 82 200 100
004 18 58 110 70
005 43 52 120 82
006 37 74 150 98
007  . 82 140 100
;

***Note: this program assumes there are no
   missing values for Pulse or SBP;
data newvitals;
   set vitals;
   if Age lt 50 and not missing(Age) then do;
      if Pulse lt 70 then PulseGroup = 'Low ';
      else PulseGroup = 'High';
      if SBP lt 140 then SBPGroup = 'Low ';
      else SBPGroup = 'High';
   end;
   else if Age ge 50 then do;
      if Pulse lt 74 then PulseGroup = 'Low';
      else PulseGroup = 'High';
      if SBP lt 140 then SBPGroup = 'Low';
      else SBPGroup = 'High';
   end;
run;

title "Listing of NEWVITALS";
proc print data=newvitals noobs;
run;

*8-3;
data test;
   input Score1-Score3;
   Subj + 1;
datalines;
90 88 92
75 76 88
88 82 91
72 68 70
;

title "Listing of TEST";
proc print data=test noobs;
run;

*8-5;
data logs;
   do N = 1 to 20;
      LogN = log(N);
      output;
   end;
run;

title "Listing of LOGS";
proc print data=logs noobs;
run;

*8-7;
data plotit;
   do x = 0 to 10 by .1;
      y = 3*x**2 - 5*x + 10;
      output;
   end;
run;

title "Problem 7";
proc sgplot data=plotit;
   series x=x y=y;
run;

*8-9;
data temperatures;
   do Day = 'Mon','Tues','Wed','Thu','Fri','Sat','Sun';
      input Temp @;
      output;
   end;
datalines;
70 72 74 76 77 78 85
;

title "Listing of TEMPERATURES";
proc print data=temperatures noobs;
run;

*8-11;
data temperature;
   length City $ 7;
   do City = 'Dallas','Houston';
      do Hour = 1 to 24;
         input Temp @;
         output;
      end;
   end;
datalines;
80 81 82 83 84 84 87 88 89 89 
91 93 93 95 96 97 99 95 92 90 88
86 84 80 78 76 77 78
80 81 82 82 86 
88 90 92 92 93 96 94 92 90
88 84 82 78 76 74
;
title "Temperatures in Dallas and Houston";
proc print data=temperature;
run;

*8-13;
data money;
   do Year = 1 to 999 until (Amount ge 30000);
      Amount + 1000;
      do Quarter = 1 to 4;
         Amount + Amount*(.0425/4);
      output;
      end;
   end;
   format Amount dollar10.;
run;

title "Listing of MONEY";
proc print data=money;
run; 

*9-1;
data dates;
   input @1  Subj  $3.
         @4  DOB   mmddyy10.
         @14 Visit date9.;
   Age = yrdif(DOB,Visit,'Actual');
   format DOB Visit date9.;
datalines;
00110/21/195011Nov2006
00201/02/195525May2005
00312/25/200525Dec2006
;
title "Listing of DATES";
proc print data=dates noobs;
run;

*9-3;
options yearcutoff=1910;
data year1910_2006;
   input @1 Date mmddyy8.;
   format Date date9.;
datalines;
01/01/11
02/23/05
03/15/15
05/09/06
;
options yearcutoff=1920;
/* Good idea to set yearcutoff back to
   the default after you change it */
title "Listing of YEAR1910_2006";
proc print data=year1910_2006 noobs;
run;

*9-5;
data freq;
   set learn.hosp(keep=AdmitDate);
   Day = weekday(AdmitDate);
   Month = month(AdmitDate);
   Year = year(AdmitDate);
run;

proc format;
   value days 1='Sun' 2='Mon' 3='Tue'
              4='Wed' 5='Thu' 6='Fri'
              7='Sat';
   value months 1='Jan' 2='Feb' 3='Mar'
                4='Apr' 5='May' 6='Jun'
                7='Jul' 8='Aug' 9='Sep'
                10='Oct' 11='Nov' 12='Dec';
run;

title "Frequencies for Hospital Admissions";
proc freq data=freq;
   tables Day Month Year / nocum nopercent;
   format Day days. Month months.;
run;

*9-7;
title "Admissions before July 15, 2002";
proc print data=learn.hosp;
   where AdmitDate le '15Jul2002'd and 
      AdmitDate is not missing;
run;

*9-9;
data dates;
   input Day Month Year;
   if missing(Day) then Date = mdy(Month,15,Year);
   else Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
datalines;
25 12 2005
.  5  2002
12 8     2006
;

title "Listing of DATES";
proc print data=dates noobs;
run;

*9-11;
data intervals;
   set learn.medical;
   Quarters = intck('qtr','01Jan2006'd,VisitDate);
run;

title "Listing of INTERVALS";
proc print data=intervals noobs;
run;

*9-13;
data return;
   set learn.medical(keep=Patno VisitDate);
   Return = intnx('month',VisitDate,6,'sameday');
   format VisitDate Return worddate.;
run;

title "Return Visits for Medical Patients";
proc print data=return noobs;
run;

*10-1;
data subset_a;
   set learn.blood;
   where Gender eq 'Female' and BloodType='AB';
   Combined = .001*WBC + RBC;
run;

title "Listing of SUBSET_A";
proc print data=subset_a noobs;
run;

data subset_b;
   set learn.blood;
   Combined = .001*WBC + RBC;
   if Gender eq 'Female' and BloodType='AB' and Combined ge 14;
run;

title "Listing of SUBSET_B";
proc print data=subset_b noobs;
run;

*10-3;
data lowmale lowfemale;
   set learn.blood;
   where Chol lt 100 and Chol is not missing;
   /* alternative statement
   where Chol lt 100 and not missing(Chol);
   */
   if Gender = 'Female' then output lowfemale;
   else if Gender = 'Male' then output lowmale;
run;

title "Listing of LOWMALE";
proc print data=lowmale noobs;
run;

title "Listing of LOWFEMALE";
proc print data=lowfemale noobs;
run;

*10-5;
title "Listing of INVENTORY";
proc print data=learn.inventory noobs;
run;

title "Listing of NEWPRODUCTS";
proc print data=learn.newproducts noobs;
run;

data updated;
   set learn.inventory learn.newproducts;
run;

proc sort data=updated;
   by Model;
run;

title "Listing of updated";
proc print data=updated;
run;

*10-7;
proc means data=learn.gym noprint;
   var fee;
   output out=Meanfee(drop=_type_ _freq_)
          Mean= / autoname;
run;

data percent;
   set learn.gym;
   if _n_ = 1 then set Meanfee;
   FeePercent = round(100*fee / Fee_Mean);
   drop Fee_Mean;
run;

title "Listing of PERCENT";
proc print data=PERCENT;
run;

*10-9;
proc sort data=learn.inventory out=inventory;
   by Model;
run;

proc sort data=learn.purchase out=purchase;
   by Model;
run;

data pur_price;
   merge inventory
         purchase(in=InPurchase);
   by Model;
   if InPurchase;
   TotalPrice = Quantity*Price;
   format TotalPrice dollar8.2;
run;

title "Listing of PUR_PRICE";
proc print data=pur_price noobs;
run;

*10-11;
options mergenoby=nowarn;
data try1;
   merge learn.inventory learn.purchase;
run;

title "Listing of TRY1";
proc print data=try1;
run;

options mergenoby=warn;
data try2;
   merge learn.inventory learn.purchase;
run;

title "Listing of TRY2";
proc print data=try2;
run;

options mergenoby=error;
data try3;
   merge learn.inventory learn.purchase;
run;

title "Listing of TRY3";
proc print data=try3;
run;

*10-13;
/* Solution where the numeric identifier is converted
   to a character value */
proc sort data=learn.demographic_ID out=demographic_ID;
   by ID;
run;

data survey2;
   set learn.survey2(rename=(ID = NumID));
   ID = put(NumID,z3.);
   drop NumID;
run;

proc sort data=survey2;
   by ID;
run;

data combine;
   merge demographic_ID
         survey2;
   by ID;
run;

title "Listing of COMBINE";
proc print data=combine noobs;
run;

/* Solution where the character identifier is converted
   to a numeric value */
data demographic_ID;
   set learn.demographic_ID(rename=(ID = CharID));
   ID = input(CharID,3.);
   drop CharID;
run;

proc sort data=demographic_ID;
   by ID;
run;

proc sort data=learn.survey2 out=survey2;
   by ID;
run;

data combine;
   merge demographic_ID
         survey2;
   by ID;
run;

title "Listing of COMBINE";
proc print data=combine noobs;
run;

*11-1;
data health;
   set learn.health;
   BMI = (Weight/2.2) / (Height*.0254)**2;
   BMIRound = round(BMI);
   BMIRound_tenth = round(BMI,.1);
   BMIGroup = round(BMI,5);
   BMITrunc = int(BMI);
run;

title "Listing of HEALTH";
proc print data=health noobs;
run;

*11-3;
data miss_blood;
   set learn.blood;
   if missing(WBC) then call missing(Gender,RBC, Chol);
run;

title "Listing of MISS_BLOOD";
proc print data=miss_blood noobs;
run;

*11-5;
data psychscore;
   set learn.psych;
   if n(of Score1-Score5) ge 3 then
   ScoreAve = mean(largest(1,of Score1-Score5),
                   largest(2,of Score1-Score5),
                   largest(3,of Score1-Score5));
   if n(of Ques1-Ques10) ge 7 then 
      QuesAve = mean(of Ques1-Ques10);
   Composit = ScoreAve + 10*QuesAve;
   keep ID ScoreAve QuesAve Composit;
run;

title "Listing of PSYCHSCORE";
proc print data=psychscore noobs;
run;

*11-7;
data _null_;
   x = 10; y = 20; z = -30;
   AbsZ = abs(z);
   ExpX = round(exp(x),.001);
   Circumference = round(2*constant('pi')*y,.001);
   put _all_;
run;

*11-9;
 data fake;
    do Subj = 1 to 100;
       if rand('uniform') le .4 then Gender = 'Female';
       else Gender = 'Male';
       Age = 9 + ceil(rand('uniform')*51);
       output;
   end;
run;

title "Frequencies";
proc freq data=fake;
   tables Gender / nocum;
run;

title "First 10 Observations of FAKE";
proc print data=fake(obs=10);
run;

*11-11;
data convert;
   set learn.char_num(rename=
     (Age = Char_Age
      Weight = Char_Weight
      Zip = Num_Zip
      SS = Num_ss));
   Age = input(Char_Age,8.);
   Weight = input(Char_Weight,8.);
   SS = put(Num_SS,ssn11.);
   Zip = put(Num_Zip,z5.);
   drop Char_: Num_:;
run;

title "Listing of CONVERT";
proc print data=convert noobs;
run;

*11-13;
data smooth;
   set learn.stocks;
   Price1 = lag(Price);
   Price2 = lag2(Price);
   Average = mean(Price, Price1, Price2);
run;

title "Plot of Price and Moving Average";
proc sgplot data=smooth;
   series x=Date y=Price;
   series x=Date y=Average;
run;

*12-1;
*One way to test the storage lengths is to use
 the LENGTHC function that returns storage lengths
 compared to the LENGTH function that returns the
 length of a character string, not counting
 trailing blanks;
data storage;
   length A $ 4 B $ 4;
   Name = 'Goldstein';
   AandB = A || B;
   Cat = cats(A,B);
   if Name = 'Smith' then Match = 'No';
      else Match = 'Yes';
   Substring = substr(Name,5,2);
   L_A = lengthc(A);
   L_B = lengthc(B);
   L_Name = lengthc(Name);
   L_AandB = lengthc(AandB);
   L_Cat = lengthc(Cat);
   L_Match = lengthc(Match);
   L_Substring = lengthc(Substring);
run;

title "Lengths of Character Variables";
proc print data=storage noobs;
   var L_:;
   *All variables starting with L_;
run;
/*
Variable   Storage Length
A              4  
B              4
Name           9
AandB          8
Cat          200
Match          2
Substring      9
*/

*12-3;
data names_and_more;
   set learn.names_and_more;
   Name = compbl(Name);
   Phone = compress(Phone,,'kd');
run;

title "Listing of NAMES_AND_MORE";
proc print data=names_and_more noobs;
run;

*12-5;
data convert;
   set learn.names_and_more(keep=Mixed);
   Integer = input(scan(Mixed,1,' /'),8.);
   Numerator = input(scan(Mixed,2,' /'),8.);
   Denominator = input(scan(Mixed,3,' /'),8.);
   if missing(Numerator) then Price = Integer;
   else Price = Integer + Numerator / Denominator;
   Price = round(Price,.001);
   drop Numerator Denominator Integer;
run;

title "Listing of CONVERT";
proc print data=convert noobs;
run;

*12-7;
*Using one of the CAT functions;
data concat;
   set learn.study(keep=Group Subgroup);
   length Combined $ 3;
   Combined = catx('-',Group,Subgroup);
run;

title "Listing of CONCAT";
proc print data=concat noobs;
run;

*Without using CAT functions;
data concat;
   set learn.study(keep=Group Subgroup);
   length Combined $ 3;
   Combined = trim(Group) || '-' || put(Subgroup,1.);
run;

title "Listing of CONCAT";
proc print data=concat noobs;
run;

*12-9;
data spirited;
   set learn.sales;
   where find(Customer,'spirit','i');
run;

title "Listing of SPIRITED";
proc print data=spirited noobs;
run;

*12-11;
title "Subjects from ERRORS with Digits in the Name";
proc print data=learn.errors noobs;
   where anydigit(Name);
   var Subj Name;
run;

*12-13;
data exact within25;
   set learn.social;
   if SS1 eq SS2 then output exact;
   else if spedis(SS1,SS2) le 25 and 
      not missing(SS1) and
      not missing(SS2) then output 
      within25;
run;

title "Listing of EXACT";
proc print data=exact noobs;
run;

title "Listing of WITHIN25";
proc print data=within25 noobs;
run;

*12-15;
data numbers;
   set learn.names_and_more(keep=phone);
   length AreaCode $ 3;
   AreaCode = substr(Phone,2,3);
run;

title "Listing of NUMBERS";
proc print data=numbers;
run;

*12-17;
data personal;
   set learn.personal(drop=Food1-Food8);
   substr(SS,1,7) = '******';
   substr(AcctNum,5,1) = '-';
run;

title "Listing of PERSONAL (with masked values)";
proc print data=personal noobs;
run;

*13-1;
data survey1;
   set learn.survey1;
   array Ques{5} $ Q1-Q5;
   do i = 1 to 5;
      Ques{i} = translate(Ques{i},'54321','12345');
   end;
   drop i;
run;

title "List of SURVEY1 (rescaled)";
proc print data=survey1;
run;

*13-3;
data nonines;
   set learn.nines;
   array nums{*} _numeric_;
   do i = 1 to dim(nums);
      if nums{i} = 999 then
      call missing(nums{i});
   end;
   drop i;
run;

title "Listing of NONINES";
proc print data=nonines;
run;

*13-5;
data passing;
   array pass_score{5} _temporary_ 
      (65,70,60,62,68);
   array Score{5};
   input ID : $3. Score1-Score5;
   NumberPassed = 0;
   do Test = 1 to 5;
      NumberPassed + (Score{Test} ge pass_score{Test});
   end;
   drop Test;
datalines;
001   90 88 92 95 90
002   64 64 77 72 71
003   68 69 80 75 70
004   88 77 66 77 67
;
title "Listing of PASSING";
proc print data=passing;
   id ID;
run;

*14-1;
title "First 10 Observations in BLOOD";
proc print data=learn.blood(obs=10) label;
   id Subject;
   var WBC RBC Chol;
   label WBC = 'White Blood Cells'
         RBC = 'Red Blood Cells'
         Chol = 'Cholesterol';
run;

*14-3;
title "Selected Patients from HOSP Data Set";
title2 "Admitted in September of 2004";
title3 "Older than 83 years of age";
title4 "--------------------------------------";
proc print data=learn.hosp 
           n='Number of Patients = '
           label
           double;
   where Year(AdmitDate) eq 2004 and 
         Month(AdmitDate) eq 9 and
         yrdif(DOB,AdmitDate,'Actual') ge 83;
   id Subject;
   var DOB AdmitDate DischrDate;
   label AdmitDate = 'Admission Date'
         DischrDate = 'Discharge Date'
         DOB = 'Date of Birth';
run;

*15-1;
title "First 5 Observations from Blood Data Set";
proc report data=learn.blood(obs=5);
   column Subject WBC RBC;
   define Subject / display "Subject Number" width=7;
   define WBC / "White Blood Cells" width=6 format=comma6.0;
   define RBC / "Red Blood Cells" width=5 format=5.2;
run;
quit;

*15-3;
title "Demonstrating a Compute Block";
proc report data=learn.hosp(obs=5);
   column Subject AdmitDate DOB Age;
   define AdmitDate / display "Admission Date" width=10;
   define DOB / display;
   define Subject / display width=7;
   define Age / computed "Age at Admission" ;
   compute Age;
      Age = round(yrdif(DOB,AdmitDate,'Actual'));
   endcomp;
run;
quit;

*15-5;
title "Patient Age Groups";
proc report data=learn.bloodpressure;
   column Gender Age AgeGroup;
   define Gender / width=6;
   define Age / display width=5;
   define AgeGroup / computed "Age Group";
   compute AgeGroup / character length=5;
      if Age gt 50 then AgeGroup = '> 50';
      else if not missing(Age) then AgeGroup = '<= 50';
   endcomp;
run;
quit;

*15-7;
title "Mean Cholesterol by Gender and Blood Type";
proc report data=learn.blood;
   column Gender BloodType Chol;
   define Gender / group width=6;
   define BloodType / group "Blood Type" width=5;
   define Chol / analysis mean "Mean Cholesterol"
                        width=11 format=5.1;
run;
quit;

*15-9;
title "Report on the Survey Data Set";
proc report data=learn.survey split=' ';
   column ID Age Gender Salary Ques1-ques5 AveResponse;
   define ID / display width=4;
   define Age / display width=18;
   define Gender / display width=6;
   define Salary / display width=10 format=dollar10.;
   define Ques1 / display noprint;
   define Ques2 / display noprint;
   define Ques3 / display noprint;
   define Ques4 / display noprint;
   define Ques5 / display noprint;
   *Note: This solution will case an automatic
    character to numeric conversion;
   compute AveResponse;
      AveResponse = mean(of Ques1-Ques5);
   endcomp;
   /**********************************************
   To avoid the automatic conversion, substitute
   the code below for the compute block:

   compute AveResponse;
      Q1 = input(Ques1,1.);
      Q2 = input(Ques2,1.);
      Q3 = input(Ques3,1.);
      Q4 = input(Ques4,1.);
      Q5 = input(Ques5,1.);
      AveResponse = mean(of Q1-Q5);
   endcomp;
   ************************************************/

   define AveResponse / computed "Average Response" width=8 format=3.1;
run;
quit;

*16-1;
options fmtsearch=(learn);
***This is where the file formats.sas7bcat was
   placed;
title "Statistics on the College Data Set";
proc means data=learn.college
           n 
           nmiss
           mean
           median
           min
           max
           maxdec=2;
   var ClassRank GPA;
run;

*16-3;
proc sort data=learn.college out=college;
   by SchoolSize;
run;

title "Statistics on the College Data Set - Using BY";
title2 "Broken down by School Size";
proc means data=college
           n 
           mean
           median
           min
           max
           maxdec=2;
   by SchoolSize;
   var ClassRank GPA;run;

title "Statistics on the College Data Set - Using CLASS";
title2 "Broken down by School Size";
proc means data=learn.college
           n 
           mean
           median
           min
           max
           maxdec=2;
   class SchoolSize;
   var ClassRank GPA;
run;

*16-5;
proc format;
   value rank 0-50 = 'Bottom Half'
             51-74 = 'Third Quartile'
            75-100 = 'Top Quarter';
run;

title "Statistics on the College Data Set";
title2 "Broken down by School Size";
proc means data=learn.college
           n 
           mean
           maxdec=2;
   class ClassRank;
   var GPA;
   format ClassRank rank.;
run;

*16-7;
proc means data=learn.college noprint chartype;
   class Gender SchoolSize;
   var ClassRank GPA;
   output out=summary
          n= mean= median= min= max= / autoname;
run;

data grand(drop=Gender SchoolSize)
     bygender(drop=SchoolSize) 
     bysize(drop=Gender)
     cell;
   drop _freq_;
   set summary;
   if _type_ = '00' then output grand;
   else if _type_ = '10' then output bygender;
   else if _type_ = '01' then output bysize;
   else if _type_ = '11' then output cell;
run;

title "Listing of GRAND";
proc print data=grand noobs;
run;

title "Listing of BYGENDER";
proc print data=bygender noobs;
run;

title "Listing of BYSIZE";
proc print data=bysize noobs;
run;

title "Listing of CELL";
proc print data=cell noobs;
run;

*17-1;
title "One-way Frequencies from BLOOD Data Set";
proc freq data=learn.blood;
   tables Gender BloodType AgeGroup / nocum nopercent;
run;

*17-3;
proc format;
   value cholgrp low-200  = 'Normal'
                 201-high = 'High'
                 .        = 'Missing';
run;

title "Demonstrating the MISSING Option";
title2 "Without MISSING Option";
proc freq data=learn.blood;
   tables Chol / nocum;
   format Chol cholgrp.;
run;

title "Demonstrating the MISSING Option";
title2 "With MISSING Option";
proc freq data=learn.blood;
   tables Chol / nocum missing;
   format Chol cholgrp.;
run;

*17-5;
proc format;
   value rank low-70  = 'Low to 70'
              71-high = '71 and higher';
run;

title "Scholarship by Class Rank";
proc freq data=learn.college;
   tables Scholarship*ClassRank;
   format ClassRank rank.;
run;

*17-7;
title "Blood Types in Decreasing Frequency Order";
proc freq data=learn.blood order=freq;
   tables BloodType / nocum nopercent;
run;

*18-1;
options fmtsearch=(learn);
title "Demographics from COLLEGE Data Set";
proc tabulate data=learn.college format=6.;
   class Gender Scholarship SchoolSize;
   tables Gender Scholarship all,
          SchoolSize / rts=15;
   keylabel n=' ';
run;

*18-3;
proc format;
   value $gender 'F' = 'Female'
                 'M' = 'Male';
run;
title "Demographics from COLLEGE Data Set";
proc tabulate data=learn.college format=6.;
   class Gender Scholarship SchoolSize;
   tables (Gender all)*(Scholarship all),
          SchoolSize all / rts=25;
   keylabel n=' '
            all = 'Total';
   format Gender $gender.;
run;

*18-5;
title "Descriptive Statistics";
proc tabulate data=learn.college format=6.1;
   class Gender;
   var GPA;
   tables GPA*(n*f=4. 
               mean min max),
          Gender all;
   keylabel n = 'Number'
            all = 'Total'
            mean = 'Average'
            min = 'Minimum'
            max = 'Maximum';
run;

*18-7;
title "More Descriptive Statistics";
proc tabulate data=learn.college format=7.1 noseps;
   class Gender SchoolSize;
   var GPA ClassRank;
   tables SchoolSize all,
          GPA*(median min max) 
          ClassRank*(median*f=7. min*f=7. max*f=7.)/ rts=15;
   keylabel all = 'Total'
            median = 'Median'
            min = 'Minimum'
            max = 'Maximum';
   label ClassRank = 'Class Rank'
         SchoolSize = 'School Size';
run;

*18-9;
title "Demonstrating Column Percents";
proc format;
   value $gender 'F' = 'Female'
                 'M' = 'Male';
run;
proc sort data=learn.college out=college;
   by descending Scholarship;
run;
proc tabulate data=college 
              format=7. 
              order=data
              noseps;
   class Gender Scholarship;
   tables (Gender all),
          (Scholarship all)*colpctn;
   keylabel colpctn = 'Percent'
            all = 'Total';
   format Gender $gender.;
run;

*19-1;
options fmtsearch=(learn);
ods listing close;
ods html path= 'c:\books\learning' file='prob19_1.html';

title "Sending Output to an HTML File";
proc print data=learn.college(obs=8) noobs;
run;

proc means data=learn.college n mean maxdec=2;
   var GPA ClassRank;
run;

ods html close;
ods listing;

*19-3;
ods listing close;
ods html file='prob19_3.html'
         style=journal;

title "Sending Output to an HTML File";
proc print data=learn.college(obs=8) noobs;
run;

proc means data=learn.college n mean maxdec=2;
   var GPA ClassRank;
run;

ods html close;
ods listing;

*19-5;
ods trace on;
proc univariate data=learn.survey;
   var Age Salary;
run;
ods trace off;

ods select quantiles;
proc univariate data=learn.survey;
   var Age Salary;
run;

*20-1;
title "Bar Chart for the Variable Status";
proc sgplot data=SASHelp.Heart;
   vbar Status;
run; 

*20-3;
title "Mean Height by Sex";
proc sgplot data=SASHelp.Heart;
   hbar sex / response=Height stat=mean nofill 
              barwidth=.25;
run;

*20-5;
title "Scatter Plot with Regression Line and Confidence Limits";
proc sgplot data=SASHelp.Heart;
   reg x=Height y=Weight / CLM CLI;
run;
  
*20-7;
title "Demonstrating PBSPLINE Smoothing";
proc sgplot data=SASHelp.Heart(obs=100);
   pbspline x=Height y=Weight;
run;

*20-9;
title "Histogram for Cholesterol";
proc sgplot data=SASHelp.Heart;
   histogram Cholesterol;
run;

*20-11;
title "Horizontal Box Plots";
proc sgplot data=SASHelp.Heart;
   hbox Cholesterol / group=Sex;
run;

*21-1;
data prob21_1;
   infile 'c:\books\learning\test_scores.txt' missover;
   /* or truncover */
   input Score1-Score3;
run;

title "Listing of PROB21_1";
proc print data=prob21_1 noobs;
run;

*21-3;
data prob21_3;
   infile 'c:\books\learning\scores_column.txt' pad;
   input Score1 1-2
         Score2 3-4
         Score3 5-6;
run;

title "Listing of PROB21_3";
proc print data=prob21_3 noobs;
run;

*21-5;
title "Summary Report from BICYCLES Data Set";
data prob21_5;
   set learn.bicycles end=lastrec;
   TotalUnits + units;
   Sum_of_Sales + TotalSales;
   file print;
   if lastrec then
      put "---------------------------------------"/
          "Total Units Sold is " TotalUnits comma10. /
          "Sales Total is " Sum_of_Sales dollar10.0;
run;

*21-7;
data prob21_7;
   infile 'c:\books\learning\file_A.txt' 
          firstobs=2
          end=last_of_a;
   if last_of_a then infile 'c:\books\learning\file_B.txt'
          firstobs=2;
   input x y z;
run;

title "Listing of PROB21_7";
proc print data=prob21_7;
run;

*21-9;
data prob21_9;
   filename xyzfiles ('c:\books\learning\xyz1.txt'
                      'c:\books\learning\xyz2.txt');
   infile xyzfiles;
   input x y z;
run;

title "Listing of PROB21_9";
proc print data=prob21_9;
run;

*21-11;
data prob21_11;
   infile 'c:\books\learning\three_per_line.txt';
   input @1 (HR1-HR3)(3. +6)
         @4 (SBP1-SBP3)(3. +6)
         @7 (DBP1-DBP3)(3. +6);
run;

title "Listing of PROB21_11";
proc print data=prob21_11;
run;

*22-1;
proc format;
   value high_sbp low - <140 = 'Normal'
                  140 - high = 'High SBP';
   value high_dbp low - <90 = 'Normal'
                  90 - high ='High DBP';
run;

title "Frequencies on SBP and DBP";
proc freq data=learn.bloodpressure;
   tables SBP DBP / nocum nopercent;
   format SBP high_sbp.
          DBP high_dbp.;
run;

*22-3;
proc format;
   value high_sbp low - <140 = 'Normal'
                  140 - high = 'High SBP';
   value high_dbp low - <90 = 'Normal'
                  90 - high ='High DBP';
run;
data bloodpressure;
   set learn.bloodpressure;
   SBPGroup = put(SBP,high_sbp.);
   DBPGroup = put(DBP,high_dbp.);
run;

title "Listing of BLOODPRESSURE";
proc print data=bloodpressure noobs;
run;

*22-5;
proc format;
   invalue $convert 
      0   - 65 = 'F'
      66  - 75 = 'C'
      76  - 85 = 'B'
      86  - high = 'A'
      other = ' ';
run;

data lettergrades;
   infile 'c:\books\learning\numgrades.txt';
   input ID $ LetterGrade $convert. @@;
run;

title "Listing of LETTERGRADES";
proc print data=lettergrades noobs;
run;

*22-7;
data control;
   set learn.dxcodes(rename=(Dx = Start
                             Description = Label));
   retain fmtname '$dxcodes' Type 'C';
run;

proc format cntlin=control;
   select $dxcodes;
run;

*22-9;
proc format;
   value muggle
      '01jan1990'd - '31dec2004'd = 'Too Early'
      '01jan2005'd - '31dec2005'd = [mmddyy10.]
      '01jan2007'd - high = 'Too Late';
run;

title "Listing of GYM";
proc print data=learn.gym noobs;
   format Date muggle.;
run;

*23-1;
data long;
   set learn.wide;
   array X_array[5] X1-X5;
   array Y_array[5] Y1-Y5;
   do Time = 1 to 5;
      X = X_array[Time];
      Y = y_array{Time];
      output;
   end;
   keep Subj Time X Y;
run;

title "Listing of LONG";
proc print data=long;
run;

*23-3;
proc transpose data=learn.wide 
               out=long(rename=(col1=X)
                          drop=_name_);
   by Subj;
   var X1-X5;
run;

title "Listing of LONG";
proc print data=long;
run;

*24-1;
proc sort data=learn.dailyprices out=dailyprices;
   by Symbol Date;
run;
data lastprice;
   set dailyprices;
   by Symbol;
   if last.Symbol;
run;

title "Listing of LASTPRICE";
proc print data=lastprice noobs;
run;

*24-3;
proc sort data=learn.dailyprices out=dailyprices;
   by Symbol Date;
run;
data countit;
   set dailyprices;
   by Symbol;
   if first.Symbol then N_Days = 0;
   N_Days + 1;
   if last.Symbol;
   keep Symbol N_Days;
run;

title "Listing of COUNTIT";
proc print data=countit noobs;
run;

*24-5;
proc sort data=learn.dailyprices out=dailyprices;
   by Symbol Date;
run;
data first_last;
   set dailyprices;
   by Symbol;
   retain FirstPrice;
   if first.Symbol and last.Symbol then delete;
   if first.Symbol then FirstPrice = Price;
   if last.Symbol then do;
      Diff = Price - FirstPrice;
      output;
   end;
   keep Symbol Price Diff;
run;

title "Listing of FIRST_LAST";
proc print data=first_last noobs;
run;

*24.7;
proc sort data=learn.dailyprices out=dailyprices;
   by Symbol Date;
run;
data first_last;
   set dailyprices;
   by Symbol;
   if first.Symbol and last.Symbol then delete;
   Diff = dif(Price);
   if not first.Symbol then output;
   keep Symbol Price Diff;
run;

title "Listing of FIRST_LAST";
proc print data=first_last noobs;
run;

*25-1;
title "Listing produced on &sysday, &sysdate9 at &systime";
proc print data=learn.stocks(obs=5) noobs;
run;

*25-3;
%macro print_n(dsn, /* data set name */
               nobs /* number of observations to list */);
   title "Listing of the first &nobs Observations from "
         "Data set &dsn";
   proc print data=&dsn(obs=&nobs) noobs;
   run;
%mend print_n;

%print_n(learn.bicycles, 4)

*25-5;
proc means data=learn.fitness nway noprint;
   var TimeMile RestPulse MaxPulse;
   output out=summary
          mean= / autoname;
run;

data _null_;
   set summary;
   call symput('GrandTime',TimeMile_mean);
   call symput('GrandRest',RestPulse_mean);
   call symput('GrandMax',MaxPulse_mean);
run;

data compute_percents;
   set learn.fitness;
   P_TimeMile = round(100*TimeMile/&GrandTime);
   P_RestPulse = round(100*RestPulse/&GrandRest);
   R_MaxPulse = round(100*MaxPulse/&GrandMax);
run;

title "Fitness Stats as a Percent of Mean";
proc print data=compute_percents noobs;
run;

*26-1;
title "Observations from INVENTORY where Price > 20";
proc sql;
   select *
   from learn.inventory
   where Price gt 20;
quit;

*26-3;
proc sql;
   create table n_sales as
   select Name, TotalSales
   from learn.sales
   where Region eq 'North';
quit;

title "Listing of N_SALES";
proc print data=n_sales noobs;
run;

*26-5;
***Part 1;
proc sql;
   create table both as
   select l.Subj as LeftSubj,
          Height,
          Weight,
          r.Subj as RightSubj,
          Salary
   from learn.left as l inner join 
        learn.right as r
   on left.Subj = right.Subj;
quit;

title "Listing of BOTH";
proc print data=both noobs;
run;

/* alternate code
proc sql;
   create table both as
   select l.Subj as LeftSubj,
          Height,
          Weight,
          r.Subj as RightSubj,
          Salary
   from learn.left as l,
        learn.right as r
   where left.Subj = right.Subj;
quit;

title "Listing of BOTH";
proc print data=both noobs;
run;
*/

***Part 2;
proc sql;
   create table both as
   select l.Subj as LeftSubj,
          Height,
          Weight,
          r.Subj as RightSubj,
          Salary
   from learn.left as l full join
        learn.right as r
   on left.Subj = right.Subj;
quit;

title "Listing of BOTH";
proc print data=both noobs;
run;

***Part 3;
proc sql;
   create table both as
   select l.Subj as LeftSubj,
          Height,
          Weight,
          r.Subj as RightSubj,
          Salary
   from learn.left as l left join
        learn.right as r
   on left.Subj = right.Subj;
quit;

title "Listing of LEFT";
proc print data=both noobs;
run;

*26-7;
proc sql;
   create table third as
   select * 
   from learn.first union all corresponding
   Select *
   from learn.second;
quit;

title "Listing of THIRD";
proc print data=third;
run;

*26-9;
proc sql;
   create table percentages as
   select Subject,
          RBC,
          WBC,
          mean(RBC) as MeanRBC,
          mean(WBC) as MeanWBC,
          100*RBC / calculated MeanRBC as Percent_RBC,
          100*WBC / calculated MeanWBC as Percent_WBC
   from learn.blood(obs=10);
quit;

title "Listing of PERCENTAGES";
proc print data=percentages;
run;
*27-1;
title "List of Non-standard Phone Numbers";
data _null_;
   file print;
   input Plate_No $10.;
   if not prxmatch("/[A-Z]\d\d\d/",Plate_No) then 
      put "Plate number " Plate_No "does not conform to pattern";
datalines;
ABC123
SASMAN
SASJEDI
345XYZ
low987
WWW999
;

*27-3;
title "List of Non-standard Phone Numbers";
data _null_;
   file print;
   retain Return;
   if _n_ = 1 then Return = prxparse("/\d\d\d\.\d\d\d\.\d\d\d\d/");
   input Phone $13.;
   if not prxmatch(Return,Phone) then 
      put "Phone number " Phone "does not conform to pattern";
datalines;
(908)432-1234
800.343.1234
8882324444
(888)456-1324
;






