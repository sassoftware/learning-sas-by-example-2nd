/*Copyright © 2020, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.
SPDX-License-Identifier: Apache-2.0*/


*SAS Program to create the SAS data sets used in the book;

/******************************************
Substitute the folder of your choice in the
libname statement that follows
*******************************************/
libname learn 'c:\books\learning';

/********************************************************
You also need to modify any INFILE statements that
point to external text files.  One easy way to do 
this is to search for:

c:\books\learning

and replace it with the folder where you have stored your
text files.
**********************************************************/

options fmtsearch=(learn);

*Data set ADDRESS;
data learn.address;
   infile datalines truncover;
   input #1 Name $40.
         #2 Street $40.
         #3 @1  City $20. 
            @21 State $2. 
            @24 Zip $5.;
datalines;
ron   coDY
1178  HIGHWAY 480
camp   verde        tx 78010
jason Tran
123 lake  view drive
East  Rockaway      ny 11518
;

*Data set CHARS - used in chapter 11;
data learn.chars;
   input Height $ Weight $ Date : $10.;
datalines;
58 155 10/21/1950
63 200 5/6/2005
45 79 11/12/2004
;

/***********************************************************
Another data set CHARS used in the array chapter (13)

data learn.chars;
   input A $ B $ x y Ques $;
datalines;
NA ? 3 4 ABC
AAA BBB 8 . ?
NA NA 9 8 NA
; 
************************************************************/
*Data set CARELESS;
data learn.careless;
   input Score Last_Name : $10. (Ans1-Ans3)($1.);
datalines;
100 COdY Abc
65 sMITH CCd
95 scerbo DeD
;

*Data set CLEANING;
data learn.cleaning;
   Subject + 1;
   input Letters $ Digits $ Both $;
datalines;
Apple 12345 XYZ123
Ice9 123X Abc.123
Help! 999 X1Y2Z3
;

*Data set ONEPER;
data learn.oneper;
   input Subj : $3. Dx1-Dx3;
datalines;
001     450    430    410
002     250    240      .
003     410    250    500
004     240      .      .
;

*Data set MANYPER;
data learn.manyper;
   set learn.oneper;
   array Dx{3};
   do Visit = 1 to 3;
      if missing(Dx{Visit}) then leave;
      Diagnosis = Dx{Visit};
      output;
   end;
   keep Subj Diagnosis Visit;
run;

*Data set SCHOOL;
data learn.school;
   infile 'c:\books\learning\school.txt' firstobs=3;
   input @1  StudID       $5.
         @6  Name        $15.
         @21 Quiz1         3.
         @24 Quiz2         3.
         @27 Quiz3         3.
run;

*Data set MONTH_DAY_YEAR;
data learn.month_day_year;
   input Month Day Year;
datalines;
10 21 1950
3 . 2005
5 7 2000
;

*Data set SALES;
data learn.sales;
   input    EmpID     :       $4. 
            Name      &      $15.
            Region    :       $5.
            Customer  &      $18.
            Date      : mmddyy10.
            Item      :       $8.
            Quantity  :        5.
            UnitCost  :  dollar9.;
   TotalSales = Quantity * UnitCost;
/*   format date mmddyy10. UnitCost TotalSales dollar9.;*/
   drop Date;
datalines;
1843 George Smith  North Barco Corporation  10/10/2006 144L 50 $8.99
1843 George Smith  South Cost Cutter's  10/11/2006 122 100 $5.99
1843 George Smith  North Minimart Inc.  10/11/2006 188S 3 $5,199
1843 George Smith  North Barco Corporation  10/15/2006 908X 1 $5,129
1843 George Smith  South Ely Corp.  10/15/2006 122L 10 $29.95
0177 Glenda Johnson  East Food Unlimited  9/1/2006 188X 100 $6.99
0177 Glenda Johnson  East Shop and Drop  9/2/2006 144L 100 $8.99
1843 George Smith  South Cost Cutter's  10/18/2006 855W 1 $9,109
9888 Sharon Lu  West Cost Cutter's  11/14/2006 122 50 $5.99
9888 Sharon Lu  West Pet's are Us  11/15/2006 100W 1000 $1.99
0017 Jason Nguyen  East Roger's Spirits  11/15/2006 122L 500 $39.99
0017 Jason Nguyen  South Spirited Spirits  12/22/2006 407XX 100 $19.95
0177 Glenda Johnson  North Minimart Inc.  12/21/2006 777 5 $10.500
0177 Glenda Johnson  East Barco Corporation  12/20/2006 733 2 $10,000
1843 George Smith  North Minimart Inc.  11/19/2006 188S 3 $5,199
;

*Data set MEDICAL;
data learn.medical;
   input Patno       : $3.
         Clinic      & $15.
         VisitDate   : mmddyy10.
         Weight      : 3.
         HR          : 3.
         DX          : $3.
         Comment     & $50.;
   format VisitDate mmddyy10.;
   label VisitDate = 'Visit Date'
         HR        = 'Heart Rate';
datalines;
001 Mayo Clinic  10/21/2006 120 78 7 Patient has had a persistent cough for 3 weeks.
003 HMC  9/1/2006 166 58 8 Patient placed on beta-blockers on 7/1/2006
002 Mayo Clinic  10/01/2006 210 68 9 Patient has been on antibiotics for 10 days
004 HMC  11/11/2006 288 88 9 Patient advised to lose some weight
007 Mayo Clinic  5/1/2006 180 54 7 This patient is always under high stress
050 HMC  7/6/2006 199 60 123 Refer this patient to mental health for evaluation
;

*Data set BICYCLES;
data learn.bicycles;
   input Country  & $25.
         Model    & $14.
         Manuf    : $10.
         Units    :   5.
         UnitCost :  comma8.;
   TotalSales = (Units * UnitCost) / 1000;
   format UnitCost TotalSales dollar10.;
   label TotalSales = "Sales in Thousands"
         Manuf = "Manufacturer";
datalines;
USA  Road Bike  Trek 5000 $2,200
USA  Road Bike  Cannondale 2000 $2,100
USA  Mountain Bike  Trek 6000 $1,200
USA  Mountain Bike  Cannondale 4000 $2,700
USA  Hybrid  Trek 4500 $650
France  Road Bike  Trek 3400 $2,500
France  Road Bike  Cannondale 900 $3,700
France  Mountain Bike  Trek 5600 $1,300
France  Mountain Bike  Cannondale  800 $1,899
France  Hybrid  Trek 1100 $540
United Kingdom  Road Bike  Trek 2444 $2,100
United Kingdom  Road Bike  Cannondale  1200 $2,123
United Kingdom  Hybrid  Trek 800 $490
United Kingdom  Hybrid  Cannondale 500 $880
United Kingdom  Mountain Bike  Trek 1211 $1,121
Italy  Hybrid  Trek 700 $690
Italy  Road Bike  Trek 4500  $2,890
Italy  Mountain Bike  Trek 3400  $1,877
;

*Data set ASSIGN;
data temp;
   do Subject = 1 to 36;
      Group = ranuni(1357);
      output;
   end;
run;
proc format;
   value groupfmt 0 = 'A' 1 = 'B' 2 = 'C';
run;
proc rank data=temp groups=3 out=learn.assign;
   var Group;
   format Group groupfmt.;
   label Group = "Group";
run;

*Data set SURVEY;
data learn.survey;
   infile 'c:\books\learning\survey.txt' pad;
   input ID : $3.
         Gender : $1.
         Age
         Salary
         (Ques1-Ques5)(: $1.);
run;

proc format library=learn;
   value $gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $likert '1' = 'Strongly disagree'
                 '2' = 'Disagree'
                 '3' = 'No opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly agree';
run;

*Data set SURVEY;
data learn.survey;
   infile 'c:\books\learning\survey.txt' pad;
   input ID : $3.
         Gender : $1.
         Age
         Salary
         (Ques1-Ques5)(: $1.);
   format Gender      $gender.
          Age         age.
          Ques1-Ques5 $likert.
          Salary      dollar10.0;
   label ID     = 'Subject ID'
         Gender = 'Gender'
         Age    = 'Age as of 1/1/2006'
         Salary = 'Yearly Salary'
         Ques1  = 'The governor doing a good job?'
         Ques2  = 'The property tax should be lowered'
         Ques3  = 'Guns should be banned'
         Ques4  = 'Expand the Green Acre program'
         Ques5  = 'The school needs to be expanded';
run;

*Data set CLINIC;
options fmtsearch=(learn);
proc format library=learn;
   value $dx 1 = 'Routine Visit'
             2 = 'Cold'
             3 = 'Heart Problems'
             4 = 'GI Problems'
             5 = 'Psychiatric'
             6 = 'Injury'
             7 = 'Infection';
run;
data learn.clinic;
   input ID : $5.
         VisitDate : mmddyy10.
         Dx : $3.
         HR SBP DBP;
   format VisitDate mmddyy10.
          Dx $dx.;
datalines;
101 10/21/2005 4 68 120 80
255 9/1/2005 1 76 188 100
255 12/18/2005 1 74 180 95
255 2/1/2006 3 79 210 110
255 4/1/2006 3 72 180 88
101 2/25/2006 2 68 122 84
303 10/10/2006 1 72 138 84
409 9/1/2005 6 88 142 92
409 10/2/2005 1 72 136 90
409 12/15/2006 1 68 130 84
712 4/6/2006 7 58 118 70
712 4/15/2006 7 56 118 72
;
proc sort data=learn.clinic;
   by ID VisitDate;
run;

*Data set HOSP;
data learn.hosp;
   do j = 1 to 1000;
      AdmitDate = int(ranuni(1234)*1200 + 15500);
      quarter = intck('qtr','01jan2002'd,AdmitDate);
      do i = 1 to quarter;
         if ranuni(0) lt .1 and weekday(AdmitDate) eq 1 then
            AdmitDate = AdmitDate + 1;
         if ranuni(0) lt .1 and weekday(AdmitDate) eq 7 then
            AdmitDate = AdmitDate - int(3*ranuni(0) + 1);
         DOB = int(25000*Ranuni(0) + '01jan1920'd);
         DischrDate = AdmitDate + abs(10*rannor(0) + 1);
         Subject + 1;
         output;
      end;
   end;
   drop i j;
   format AdmitDate DOB DischrDate mmddyy10.;
run;

*Data set Hosp_Discharge;
data Learn.Hosp_Discharge;
   set Learn.hosp(keep=Subject DischrDate
                  rename=(Subject=Patient DischrDate = Discharge)
                  where=(Discharge between '01Jan2003'd
                         and '31Dec2003'd)
                  firstobs=208
                  obs=217);
   format Discharge date9.;
run;

*Data set HEALTH;
data learn.health;
   input Subj : $3.
         Height
         Weight;
datalines;
001 68 155
003 74 250
004 63 110
005 60 95
;

*Data set DEMOGRAPHIC;
data learn.demographic;
   input Subj   : $3.
         DOB    : mmddyy10.
         Gender : $1.
         Name   : $20.;
   format DOB mmddyy10.;
datalines;
001 10/15/1960 M Friedman
002 8/1/1955 M Stern
003 12/25/1988 F McGoldrick
005 5/28/1949 F Chien
;

*Data set data NEW_MEMBERS;
data learn.new_members;
   input Subj : $3.
         Gender : $1.
         Name : $20.
         DOB : mmddyy10.;
   format DOB mmddyy10.;
datalines;
010 F Ostermeier 3/5/1977 
013 M Brown 6/7/1999 
;

*Temporary data sets ONE, TWO, and THREE used in chapter 10;
data one;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
7 Adams 210
1 Smith 190
2 Schneider 110
4 Gregory 90
;
data two;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
9 Shea 120
3 O'Brien 180
5 Bessler 207
;
data three;
   length ID $ 3 Gender $ 1. Name $ 12;
   Input ID Gender Name;
datalines;
10 M Horvath
15 F Stevens
20 M Brown
;

*Temporary SAS data sets EMPLOYEE and HOURS used in chapter 10;
data Employee;
   length ID $ 3 Name $ 12;
   input ID Name;
datalines;
7 Adams
1 Smith
2 Schneider
4 Gregory
5 Washington
;

data Hours;
   length ID $ 3 JobClass $ 1;
   input ID 
         JobClass
         Hours;
datalines;
1 A 39
4 B 44
9 B 57
5 A 35
;

*Temporary SAS data sets BERT and ERNIE used in chapter 10;
data Bert;
   input ID $ X;
datalines;
123 90
222 95
333 100
;
data Ernie;
   input EmpNo $ Y;
datalines;
123 200
222 205
333 317
;

*Temporary SAS data sets DIVISION1 and DIVISION2 used in chapter 10;
Data Division1;
   input SS
         DOB : mmddyy10.
         Gender : $1.;
   format DOB mmddyy10.;
datalines;
111223333 11/14/1956 M
123456789 5/17/1946 F
987654321 4/1/1977 F
;

data Division2;
   input SS : $11.
         JobCode : $3.
         Salary : comma8.0;
datalines;
111-22-3333 A10 $45,123
123-45-6789 B5 $35,400
987-65-4321 A20 $87,900
;

*Program to create temporary SAS data set OSCAR used in chapter 10;
data Oscar;
   input ID $ Y;
datalines;
123  200
123  250
222  205
333  317
333  400
333  500
;

*Program to create temporary SAS data sets PRICES and
 NEW15DEC2017 used in chapter 10;
data Prices;
   Length ItemCode $ 3 Description $ 17;
   input ItemCode Description & Price;
datalines;
150 50 foot hose  19.95
175 75 foot hose  29.95
200 greeting card  1.99
204 25 lb. grass seed  18.88
208 40 lb. fertilizer  17.98
;

data New15Dec2017;
   Length ItemCode $ 3;
   input ItemCode Price;
datalines;
204 17.87
175 25.11
208 .
;

*Data set INSURANCE;
data learn.insurance;
   input Name : $20.
         Type : $2.;
datalines;
Fridman F
Goldman P
Chein F
Stern P
;

*Data set NEW_MEMBERS_ORDER;
data learn.new_members_order;
   input Name : $20.
         DOB : mmddyy10.
         Gender : $1.
         Subj : $3.;
   format DOB mmddyy10.;
datalines;
Ostermeier 3/5/1977 F 010 
Brown 6/7/1999 M 013  
;

*Data set INVENTORY;
data learn.inventory;
   input Model $ Price;
   format Price dollar8.2;
datalines;
M567 23.50
S888 12.99
L776 159.98
X999 29.95
M123 4.59
S776 1.99
;

*Data set PURCHASE;
data learn.purchase;
   input CustNumber Model $ Quantity;
datalines;
101 L776 1
102 M123 10
103 X999 2
103 M567 1
;

*Data set NEWPRODUCTS;
data learn.newproducts;
   input Model $ Price;
   format Price dollar8.2;
datalines;
L939 10.99
M135 .75
;

*Data set DEMOGRAPHIC_ID;
data learn.demographic_ID;
   input ID : $3.
         DOB : mmddyy10.
         Gender : $1.;
   format DOB mmddyy10.;
datalines;
001 10/10/37 M
002 7/12/87 F
004 1/5/2000 M
005 6/4/1966 F
;

*Data set SURVEY1;
data learn.survey1;
   input Subj : $3.
         (Q1-Q5)($1.);
datalines;
001 13542
002 55443
003 21211
004 35142
005 33333
;

*Data set SURVEY2;
data learn.survey2;
   input ID 
         (Q1-Q5)(1.);
datalines;
001 13542
002 55443
003 21211
004 35142
005 54545
;

*Data set TEST_SCORES;
data learn.test_scores;
   length ID $ 3;
   input ID $ Score1-Score3;
   label ID = 'Student ID'
         Score1 = 'Math Score'
         Score2 = 'Science Score'
         Score3 = 'English Score';
datalines;
1 90 95 98
2 78 77 75
3 88 91 92
;

*Data set UPPER;
data learn.upper;
   input Name & $20. DOB : mmddyy10.;
   format DOB mmddyy10.;
datalines;
DANIEL FIELDS  01/03/1966
PATRICE HELMS  05/23/1988
THOMAS CHIEN  11/12/2000
;

*Data set PSYCH;
data learn.psych;
   input ID : $3. Ques1-Ques10 Score1-Score5;
datalines;
001 1 3 2 4 5 4 3 4 5 4 90 92 93 90 88
002 3 3 . . 3 4 5 5 1 . 95 . . 86 85
003 . . . . 5 5 4 4 3 3 88 87 86 85 84
004 5 3 4 5 . 5 4 3 3 . 78 78 82 84 .
005 5 4 3 2 1 1 2 3 4 5 92 93 94 95 99
;

*Data set CHAR_NUM;
data learn.char_num;
   input Age $ Weight $ SS Zip;
datalines;
23 155 132423222 08822
56 220 123457777 90210
74 95  012003004 78010
;

*Data set STOCKS;
data learn.stocks;
   Do Date = '01Jan2017'd to '31Jan2017'd;
      input Price @@;
      output;
   end;
   format Date mmddyy10. Price dollar8.;
datalines;
34 35 39 30 35 35 37 38 39 45 47 52
39 40 51 52 45 47 48 50 50 51 52 53
55 42 41 40 46 55 52
;

*Data set NAMES_AND_MORE;
data learn.names_and_more;
   input Name $20.
         Phone & $14.
         Height & $10.
         Mixed & $8.;
datalines;
Roger   Cody        (908)782-1234  5ft. 10in.  50 1/8
Thomas  Jefferson   (315) 848-8484  6ft. 1in.  23 1/2
Marco Polo          (800)123-4567  5Ft. 6in.  40
Brian Watson        (518)355-1766  5ft. 10in  89 3/4
Michael DeMarco     (445)232-2233  6ft.       76 1/3
;

*Data set PHONE;
data learn.phone;
   input Phone $20.;
datalines;
(908)232-4856
210.343.4757
(516)  343 - 9293
9342342345
;

*Data set STUDY;
data learn.study;
   input Subj   : $3.
         Group  : $1.
         Dose   : $4.
         Weight : $8.
         Subgroup;
datalines;
001 A Low 220lbs. 2
002 A High 90Kg.  1
003 B Low 88kg    1
004 B High 165lbs. 2
005 A Low 88kG 1
;

*Data set ERRORS;
data learn.errors;
   input Subj : $3. 
         PartNumber $
         Name & $20.;
datalines;
001 L1232 Nichole Brown
0a2 L887X Fred Beans
003 12321 Alfred 2 Nice
004 abcde Mary Bumpers
X89 8888S Gill Sandford
;

*Data set EXPOSE;
data learn.expose;
   input Worker $ Year JobCode : $1.;
datalines;
 001      1944     B
 002      1948     E
 003      1947     C
 005      1945     A
 006      1948     D
 ;

*Data set MIXED;
data learn.mixed;
   input Name & $20. ID;
datalines;
Daniel Fields  123
Patrice Helms  233
Thomas chien  998
;

*Data set MIXED_UNITS;
data learn.mixed_UNITS;
   input Weight : $10. Height : $10.;
datalines;
100Kgs. 59in
180lbs 60inches
88kg 150cm.
50KGS 160CM
;

*Data set SOCIAL;
data social1;
   input SS1 $11.;
datalines;
123-45-6789
001-34-9876
007-77-6767
102-43-9182
;

*Data set SOCIAL2;
data social2;
   input SS2 $11.;
datalines;
123-45-6789
001-43-9876
007-77-6767
485-46-1182
102-43-9188
;

proc sql;
   create table learn.social as
   select * 
   from social1, social2;
quit;

*Data set SPSS;
data learn.SPSS;
   input Height Weight Age HR Chol Name : $20.;
datalines;
68 178 55 68 210 Smith
999 200 999 999 290 Orlando
72 999 29 79 999 Ramos
;


*Data set PERSONAL;
data learn.personal;
   infile datalines missover;
   input #1
         SS $11.
         Gender : $1.
         AcctNum : $5.
         DOB : mmddyy10.
         #2 (Food1-Food8)(: $10.);
   format DOB mmddyy10.;
   label SS = "Social Security Number"
         AcctNum = "Account Number"
         DOB = "Date of Birth";
datalines;
123-45-6789 M 0192M 11/15/1949 
Eggs Pancakes Sausage Toast Milk Coffee Beef Chicken
013-54-9388 F 9981S 1/2/1981
Pancakes Milk Chicken
112-11-1309 M 1322M 03/29/1988
Beef Toast Eggs Coffee
778-44-4655 F 9899M 7/4/1981
Pancakes Sausauge Coffee Beef
445-45-4455 M 2938S 8/9/1977
Tea Toast
;

*Data set NINES;
data learn.nines;
   infile datalines missover;
   input x y z (Char1-Char3)(:$1.) a1-a5;
datalines;
1 2 3 a b c 99 88 77 66 55
2 999 999 d c e 999 7 999
10 20 999 b b b 999 999 999 33 44
;

*Data set BLOOD;
data learn.blood;
   infile 'c:\books\learning\blood.txt' truncover;
   length Gender $ 6 BloodType $ 2 AgeGroup $ 5;
   input Subject 
         Gender 
         BloodType 
         AgeGroup
         WBC 
         RBC 
         Chol;
   label Gender = "Gender"
         BloodType = "Blood Type"
         AgeGroup = "Age Group"
         Chol = "Cholesterol";
run;

*Data set BLOODPRESSURE;
data learn.bloodpressure;
   input Gender : $1. 
         Age
         SBP
         DBP;
datalines;
M 23 144 90
F 68 110 62
M 55 130 80
F 28 120 70
M 35 142 82
M 45 150 96
F 48 138 88
F 78 132 76
;

*Data set NUMERIC;
data learn.numeric;
   input Date : mmddyy10.
         Age
         Cost;
datalines;
10/15/2000 23 12345
11/12/1923 55 39393
;

*Data set CODES;
data learn.codes;
   input ICD9 : $5. Description & $21.;
datalines;
020 Plague
022 Anthrax
390 Rheumatic fever
410 Myocardial infarction
493 Asthma
540 Appendicitis
;

*Data set COLLEGE;
proc format library=learn;
   value $yesno 'Y','1' = 'Yes'
                'N','0' = 'No'
                ' '     = 'Not Given';
   value $size 'S' = 'Small'
               'M' = 'Medium'
               'L' = 'Large'
                ' ' = 'Missing';
   value $gender 'F' = 'Female'
                 'M' = 'Male'
                 ' ' = 'Not Given';
run;

data learn.college;
   length StudentID $ 5 Gender SchoolSize $ 1;
   do i = 1 to 100;
      StudentID = put(round(ranuni(123456)*10000),z5.);
      if ranuni(0) lt .4 then Gender = 'M';
      else Gender = 'F';
      if ranuni(0) lt .3 then SchoolSize = 'S';
      else if ranuni(0) lt .7 then SchoolSize = 'M';
      else SchoolSize = 'L';
      if ranuni(0) lt .2 then Scholarship = 'Y';
      else Scholarship = 'N';
      GPA = round(rannor(0)*.5 + 3.5,.01);
      if GPA gt 4 then GPA = 4;
      ClassRank = int(ranuni(0)*60 + 41);
      if ranuni(0) lt .1 then call missing(ClassRank);
      if ranuni(0) lt .05 then call missing(SchoolSize);
      if ranuni(0) lt .05 then call missing(GPA);
      output;
   end;
   format Gender $gender1. 
          SchoolSize $size. 
          Scholarship $yesno.;
   drop i;
run;

*Data set FITNESS;
data learn.fitness;
   call streaminit(13579246);
   do Subj = 1 to 100;
      TimeMile = round(rand('normal',8,2),.1);
      if TimeMile lt 4.5 then TimeMile = TimeMile + 4;
      RestPulse = 40 + int(2*TimeMile) + rand('normal',5,5);
      MaxPulse = int(RestPulse + rand('normal',100,5));
      output;
   end;
run;

*Data set GRADES;
data learn.grades;
   infile 'c:\books\learning\numgrades.txt';
   input ID $ Grade @@;
run;

*Data set GYM;
data learn.gym;
   infile 'c:\books\learning\gym.txt' truncover;
   input Subj : $3.
         Date : mmddyy10.
         Fee;
   format Date mmddyy8. Fee Dollar6.;
run;

*Data set DXCODES;
data learn.dxcodes;
   input Dx $ Description & $20.;
datalines;
01 Cold
02 Flu
03 Headache
04 Heart Failure
05 Hypertension
06 Psychiatric Problem
07 Laceration
08 Blood Sugar Problems
09 Cough
10 Difficulty Breathing
;

*Data set WIDE;
data learn.wide;
   input Subj $ X1-X5 Y1-Y5;
datalines;
001 8 5 6 5 4 10 20 30 40 50
002 7 5 6 4 5 11 33 29 34 56
003 2 2 4 5 6 22 38 21 20 34
;

*Data set ENDOFYEAR;
data learn.EndOfYear;
   input #1 ID Pay1-Pay12 
         #2 Extra1-Extra12;
datalines;
001 3000 3000 3400 . 3500 3500 3600 3600 3700 3700 3800 .
500 . . . . 400 . . . . . 100
002 . . . . . . . . . . . .
. . . . . . . . . . . .
003 2300 2300 2300 2300 2300 2400 2400 2400 2400 2400 2400 2400
. . . . . . . . . . . .
;

*Data set NARROW;
data learn.narrow;
   input Subj $ @;
   do Time = 1 to 5;
      input Score @@;
      output;
   end;
datalines;
001 7 6 5 5 4
002 8 7 6 6 6
003 8 7 6 6 5
;

*Data set DAILYPRICES;
data learn.dailyprices;
   infile datalines;
   length Symbol $ 4;
   input Symbol $ @;
   do Date = '01jan2007'd  to '05jan2007'd;
      input Price @;
      if not missing(Price) then output;
   end;
   format Date mmddyy10.;
datalines;
CSCO 19.75 20 20.5 21 .
IBM 76 78 75 79 81
LU 2.55 2.53 . . .
AVID 41.25 . . . .
BAC 51 51 51.2 49.9 52.1
;

*Data set LEFT;
data learn.left;
   input Subj $ Height Weight;
datalines;
001 68 155
002 75 220
003 65 99
005 79 266
006 70 190
009 61 122
;

*Data set RIGHT;
data learn.right;
   input Subj $ Salary;
   format Salary dollar10.;
datalines;
001 46000
003 67900
004 28200
005 98202
006 88000
007 57200
;

*Data set MISSING;
data learn.missing;
   input A $ B $ C $;
datalines;
X Y Z
X Y Y
Z Z Z
X X .
Y Z .
X . .
;

*Data set FIRST;
data learn.first;
   input Subj $ x y z;
datalines;
001 10 20 30
002 11 21 31
004 12 14 15
;

*Data set SECOND;
data learn.second;
   input Subj $ z y x;
datalines;
001 33 44 55
002 60 70 80
003 80 90 100
004 777 888 999
;

*Format used for GROUPING;
proc format;
   value two 
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      .     = 'Missing'
      other = 'Other values';
run;

*Data set GROUPING;
data learn.grouping;
   input X @@;
datalines;
2 4 5 2 4 5 3 4 5 3 . 6
;

data Many_One;
   input ID X;
datalines;
123   90
123   80
222   95
333  100
333  150
333  200
;
data Many_Two;
   input ID Y;
datalines;
123  3
123  4
123  5
222  6
333  7
333  8
;

 data Truncate;
    input Age Weight Cost;
    Age = int(Age);
    WtKg = round(Weight/2.2, .1);
    Weight = round(Weight);
    Next_Dollar = Ceil(Cost);
 datalines;
 18.8 100.7 98.25
 25.12 122.4 5.99
 64.99 188 .0001
 ;
