/*Copyright © 2020, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.
SPDX-License-Identifier: Apache-2.0*/


*Chapter 1 Problems;

*Replace the line below with your folder name;
libname Learn 'C:\books\learning';
options fmtsearch=(learn);

*1-1;
*SAS Program to read the Veggie.txt data file and to produce
 several reports;
options nonumber nodate;
data Veg;
   infile "C:\books\learning\Veggies.txt";
   input Name $ Code $ Days Number Price;
   CostPerSeed = Price / Number;
run;
title "List of the Raw Data";
proc print data=Veg;
run;
title "Frequency Distribution of Vegetable Names";
proc freq data=Veg;
   tables Name;
 run;
title "Average Cost of Seeds";
proc means data=Veg;
   var Price Days;
run;

*1-2;
data Veg; infile "C:\books\learning\Veggies.txt";  input
Name $ Code $ Days Number 
Price; x = 2**3 + 4 * -5;  CostPerSeed = 
Price / 
Number;
run;

*Chapter 2 Programs;

*2-1;
data Demographic;
  infile "C:\books\learning\Mydata.txt";
  input Gender $ Age Height Weight;
run;
title "Gender Frequencies";
proc freq data=Demographic;
   tables Gender;
run;
title "Summary Statistics";
proc means data=Demographic;
   var Age Height Weight;
run;

*2-2;
*Program name: Demog.sas stored in the C:\books\learning folder.
 Purpose: The program reads in data on height and weight   
 (in inches and pounds, respectively) and computes a body
 mass index (BMI) for each subject.
 Programmer: Ron Cody
 Date Written: October 5, 2017;
data Demographic;
     infile "C:\books\learning\Mydata.txt";
     input Gender $ Age Height Weight;
     *Compute a body mass index (BMI);
     BMI = (Weight / 2.2) / (Height*.0254)**2;
run;

*Chapter 3 Programs;

*3-1;
data Demographics;
  infile 'C:\books\learning\Mydata.txt';
  input Gender $ Age Height Weight;
run;
title "Listing of data set Demographics";
proc print data=Demographics;
run;

*3-2;
data Demographics;
   infile 'C:\books\learning\Mydata.csv' dsd;
   input Gender $ Age Height Weight;
run;

*3-3;
filename Preston 'C:\books\learning\Mydata.csv';
data Demographics;
   infile Preston dsd;
   input Gender $ Age Height Weight;
run;

*3-4;
data demographic;
   input Gender $ Age Height Weight;
datalines;
M 50 68 155
F 23 60 101
M 65 72 220
F 35 65 133
M 15 71 166
;

*3-5;
data Demographics;
   infile datalines dsd;
   input Gender $ Age Height Weight;
datalines;
"M",50,68,155
"F",23,60,101
"M",65,72,220
"F",35,65,133
 "M",15,71,166
;

*3-6;
data Financial;
   infile 'C:\books\learning\Bank.txt';
   input Subj     $   1-3
         DOB      $  4-13
         Gender   $    14
         Balance    15-21;
run;
title "Listing of Financial";
proc print data=Financial;
run;

*3-7;
data Financial;
   infile 'C:\books\learning\Bank.txt';
   input @1  Subj         $3.
         @4  DOB    mmddyy10.
         @14 Gender       $1. 
         @15 Balance       7.;
run;
title "Listing of Financial";
proc print data=Financial;
run;

*3-8;
title "Listing of Financial";
proc print data=Financial;
   format DOB     mmddyy10. 
          Balance dollar11.2;
run;

*3-9;
title "Listing of Financial";
proc print data=Financial;
   format DOB     date9. 
          Balance dollar11.2;
run;

*3-10;
data List_Example;
   infile 'C:\books\learning\List.csv' dsd;
   input Subj   :       $3.
         Name   :      $20.
         DOB    : mmddyy10.
         Salary :  dollar8.;
   format DOB date9. Salary dollar8.;
run;

*3-11;
data List_Example;
   informat Subj        $3.
            Name       $20.
            DOB   mmddyy10.
            Salary dollar8.;
   infile 'C:\books\learning\List.csv' dsd;
   input Subj
         Name
         DOB
         Salary;
   format DOB date9. Salary dollar8.;
run;

*3-12;
data list_example;
   infile 'C:\books\learning\list.txt';
   input Subj   :       $3.
         Name   &      $20.
         DOB    : mmddyy10.
         Salary :  dollar8.;
   format DOB date9. Salary dollar8.;
run;

*Chapter 4 Programs;

*4-1;
libname Mozart 'C:\books\learning';
data Mozart.Test_Scores;
   length ID $ 3 Name $ 15;
   input ID $ Score1-Score3 Name $;
datalines;
1 90 95 98 Jan 
2 78 77 99 Preston
3 88 91 92 Russell
;

*4-2;
title "The Descriptor Portion of Data Set TEST_SCORES";
proc contents data=Mozart.Test_Scores;
run;

*4-3;
title "The Descriptor Portion of Data Set Test_Scores";
proc contents data=Mozart.Test_Scores varnum;
run;

*4-4;
libname Proj99 'C:\books\learning';
title "Descriptor Portion of Data Set Test_Scores";
proc contents data=Proj99.Test_Scores varnum;
run;

*4-5;
title "Listing All the SAS Data Sets in a Library";
proc contents data=Mozart._all_ nods;
run;

*4-6;
title "Listing of Test_Scores";
proc print data=Mozart.Test_Scores;
run;

*4-7;
libname Learn 'C:\books\learning';
data New;
   set Learn.Test_Scores;
   AveScore = mean(of Score1-Score3);
run;
title "Listing of Data Set New";
proc print data=New;
   var ID Score1-Score3 AveScore;
run;

*4-8;
title "Scores Greater Than or Equal to 95";
data _null_;
   set Learn.Test_Scores;
   if Score1 ge 95 or Score2 ge 95 or Score3 ge 95 then
      put ID= Score1= Score2= Score3=;
run;

*Chapter 5 Programs;

*5-1;
libname Learn 'C:\books\learning';
data Learn.Test_Scores;
   length ID $ 3 Name $ 15;
   input ID $ Score1-Score3 Name $;
   label ID = 'Student ID'
         Score1 = 'Math Score'
         Score2 = 'Science Score'
         Score3 = 'English Score';
datalines;
1 90 95 98 Jan 
2 78 77 99 Preston
3 88 91 92 Russell
;
title "Descriptive Statistics for Student Scores";
proc means data=Learn.Test_Scores;
run;

*5-2;
proc format;
   value $Gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value Age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $Likert '1' = 'Str Disagree'
                 '2' = 'Disagree'
                 '3' = 'No Opinion'
                 '4' = 'Agree'
                 '5' = 'Str Agree';
run;

*5-3;
title "Data Set SURVEY with Formatted Values";
proc print data=Learn.Survey;
   id ID;
   var Gender Age Salary Ques1-Ques5;
   format Gender      $Gender.
          Age         Age.
          Ques1-Ques5 $Likert.
          Salary      Dollar11.2;
run;

*5-4;
proc format;
   value $Three 1,2   = 'Disagreement'
                3     = 'No opinion'
                4,5   = 'Agreement';
run;

*5-5;
title "Question Frequencies Using the Three Format";
proc freq data=Learn.Survey;
   tables Ques1-Ques5;
   format Ques1-Ques5 $Three.;
run;

*5-6;
libname Myfmts 'C:\books\learning';
proc format library=Myfmts;
   value $Gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value Age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $Likert '1' = 'Strongly disagree'
                 '2' = 'Disagree'
                 '3' = 'No opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly agree';
run;

*5-7;
libname Learn 'C:\books\learning';
libname Myfmts 'C:\books\learning';
options fmtsearch=(Myfmts);
data Learn.Survey;
   infile 'C:\books\learning\Survey.txt' pad;
   input ID : $3.
         Gender : $1.
         Age
         Salary
         (Ques1-Ques5)(: $1.);
   format Gender      $Gender.
          Age         Age.
          Ques1-Ques5 $Likert.
          Salary      Dollar10.0;
   label ID     = 'Subject ID'
         Gender = 'Gender'
         Age    = 'Age as of 1/1/2006'
         Salary = 'Yearly Salary'
         Ques1  = 'The governor is doing a good job?'
         Ques2  = 'The property tax should be lowered'
         Ques3  = 'Guns should be banned'
         Ques4  = 'Expand the Green Acre program'
         Ques5  = 'The school needs to be expanded';
run;

*5-8;
title "Data set Survey";
proc contents data=learn.Survey varnum;
run;

*5-9;
libname Learn 'C:\books\learning';
libname Myfmts 'C:\books\learning';
options fmtsearch=(Myfmts);
 title "Using User-defined Formats";
proc freq data=Learn.Survey;
   tables Ques1-Ques5;
run;

*5-10;
title "Format Definitions in the Myfmts Library";
proc format library=Myfmts fmtlib;
   select Age $Likert $Gender;
run;

*5-11;
proc format library=Myfmts;
   select Age $Likert;
run;

*Chapter 6 Programs;

*6-1;
*Need to first import the data set from Wages.xls;
/******
title "The First Four Observations of Wages_Permanent";
proc print data=Wages_Permanent(obs=4);
run;
*******/

*6-2;
*The data set Project.Verybig is made up and does not exist;
/*****
title "Observations 100 through 110 in VERYBIG";
proc print data=Project.Verybig(firstobs=100 obs=110);
run;
*****/

*6-3;
title "Statistics from Sales Spreadsheet";
libname Read 'C:\books\learning\Wages.xls';
proc means data=Read.'Permanent$'n mean;
   var Wage Hours_Worked;
run;

*6-4;
libname Learn 'C:\books\learning';
ods csv file='C:\books\learning\ODS_Example.csv';
proc print data=Learn.Survey noobs;
run;
ods csv close;

*Chapter 7 Programs;

*7-1;
data Conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Age lt 20 then AgeGroup = 1;
   if Age ge 20 and Age lt 40 then AgeGroup = 2;
   if Age ge 40 and Age lt 60 then AgeGroup = 3;
   if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of Conditional";
proc print data=Conditional noobs;
run;

*7-2;
  data Conditional;
     length Gender $ 1
            Quiz   $ 2;
     input Age Gender Midterm Quiz FinalExam;
     if Age lt 20 and not missing(age) then AgeGroup = 1;
     else if Age ge 20 and Age lt 40 then AgeGroup = 2;
     else if Age ge 40 and Age lt 60 then AgeGroup = 3;
     else if Age ge 60 then AgeGroup = 4;
  datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of Conditional";
proc print data=Conditional noobs;
run;

*7-3;
data Conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then AgeGroup = .;
      else if Age lt 20 then AgeGroup = 1;
      else if Age lt 40 then AgeGroup = 2;
      else if Age lt 60 then AgeGroup = 3;
      else if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of Conditional";
proc print data=Conditional noobs;
run;

*7-4;
data Females;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Gender eq 'F';
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of Conditional";
proc print data=Conditional noobs;
run;

*7-5;
data Conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   select;
      when (missing(Age)) AgeGroup = .;
      when (Age lt 20) AgeGroup = 1;
      when (Age lt 40) AgeGroup = 2;
      when (Age lt 60) AgeGroup = 3;
      when (Age ge 60) Agegroup = 4;
      otherwise;
   end;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of Conditional";
proc print data=Conditional noobs;
run;

*7-6;
title "Example of Boolan Expressions";
proc print data=Learn.Medical;
   where Clinic eq 'HMC' and 
         (DX in ('7','9') or 
         Weight gt 180);
   id Patno;
   var Patno Clinic DX Weight VisitDate;
run;

*7-7;
data Believe_it_or_Not;
   input X;
   if X = 3 or 4 then Match = 'Yes';
   else Match = 'No';
datalines;
3
7
.
;
title "Listing of Believe_it_or_Not";
proc print data=Believe_it_or_Not noobs;
run;

*7-8;
data Females;
   set Conditional;
   where Gender eq 'F';
run;

*Chapter 8 Programs;

*8-1;
data Grades;
   length Gender $ 1
          Quiz   $ 2
          AgeGroup $ 13;
   infile 'C:\books\learning\Grades.txt' missover;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then delete;
   if Age le 39 then AgeGroup = 'Younger group';
   if Age le 39 then Grade    = .4*Midterm + .6*FinalExam;
   if Age gt 39 then AgeGroup = 'Older group';
   if Age gt 39 then Grade    = (Midterm + FinalExam)/2;
run;
title "Listing of Grades";
proc print data=Grades noobs;
run;

*8-2;
data Grades;
   length Gender $ 1
          Quiz   $ 2
          AgeGroup $ 13;
   infile 'C:\books\learning\Grades.txt' missover;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then delete;
   if Age le 39 then do;
      AgeGroup = 'Younger group';
      Grade = .4*Midterm + .6*FinalExam;
   end;
   else if Age gt 39 then do;
      AgeGroup = 'Older group';
      Grade = (Midterm + FinalExam)/2;
   end;
run;
title "Listing of Grades";
proc print data=Grades noobs;
run;

*8-3;
data Revenue;
   input Day : $3.
         Revenue : dollar6.;
   Total = Total + Revenue; /* Note: this does not work */
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;
title "Listing of Revenue";
proc print data=Revenue noobs;
run;

*8-4;
data Revenue;
   retain Total 0;
   input Day : $3.
         Revenue : dollar6.;
   Total = Total + Revenue; /* Note: this does not work */
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;
title "Listing of Revenue";
proc print data=Revenue noobs;
run;

*8-5;
data Revenue;
   retain Total 0;
   input Day : $3.
         Revenue : dollar6.;
   if not missing(Revenue) then Total = Total + Revenue;
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;
title "Listing of Revenue";
proc print data=Revenue noobs;
run;

*8-6;
data Revenue;
   input Day : $3.
         Revenue : dollar6.;
   Total + Revenue;
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;

*8-7;
data Test;
   input x;
   if missing(x) then MissCounter + 1;
datalines;
2
.
7
.
;

*8-8;
data Compound;
   Interest = .0375;
   Total = 100;

   Year + 1;
   Total + Interest*Total;
   output;

   Year + 1;
   Total + Interest*Total;
   output;

   Year + 1;
   Total + Interest*Total;
   output;

   format Total dollar10.2;
run;
title "Listing of Compound";
proc print data=compound noobs;
run;

*8-9;
data Compound;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 3;
      Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;
title "Listing of Data Set Compound";
proc print data=Compound noobs;
run;

*8-10;
data Table;
   do n = 1 to 10;
      Square = n*n;
      SquareRoot = sqrt(n);
      output;
   end;
run;
title "Table of Squares and Square Roots";
proc print data=table noobs;
run;

*8-11;
data Equation;
   do X = -10 to 10 by .01;
      Y = 2*X**3 - 5*X**2 + 15*X -8;
      output;
   end;
run;
title "Plot of Y = 2*X**3 – 5*X**2 + 15*X -8";
proc sgplot;
   series x=X y=Y;
run;

*8-12;
data Easyway;
   do Group = 'Placebo','Active';
      do Subj = 1 to 5;
         input Score @;
         output;
      end;
   end;
datalines;
250 222 230 210 199
166 183 123 129 234
;
title "Listing of Data Set Easyway";
proc print data=Easyway noobs;
run;

*8-13;
data Double;
   Interest = .0375;
   Total = 100;
   do until (Total ge 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;
title "Listing of Double";
proc print data=Double noobs;
run;

*8-14;
data Double;
   Interest = .0375;
   Total = 300;
   do until (Total gt 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;
proc print data=double noobs;
   title "Listing of Double";
run;

*8-15;
data Double;
   Interest = .0375;
   Total = 100;
   do while (Total le 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;
proc print data=double noobs;
   title "Listing of Double";
run;

*8-16;
data Double;
   Interest = .0375;
   Total = 300;
   do while (Total lt 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*8-17;
data Double;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100 until (Total gt 200);
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*8-18;
data Leave_it;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100;
      Total = Total + Interest*Total;
      output;
      if Total ge 200 then leave;
   end;
   format Total dollar10.2;
run;

*8-19;
data Continue_on;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100 until (Total ge 200);
      Total = Total + Interest*Total;
      if Total le 150 then continue;
      output;
   end;
   format Total dollar10.2;
run;
title "Listing of Data Set Continue_on";
proc print data=Continue_on noobs;
run;

*Chapter 9 Programs;

*9-1;
data Four_Dates;
   infile 'C:\books\learning\Dates.txt' truncover;
   input @1  Subject   $3.
         @5 DOB       mmddyy10.
         @16 VisitDate mmddyy8.
         @26 TwoDigit  mmddyy8.
         @34 LastDate  date9.;
run;

*9-2;
data Four_Dates;
   infile 'C:\books\learning\Dates.txt' truncover;
   input @1  Subject   $3.
         @5 DOB       mmddyy10.
         @16 VisitDate mmddyy8.
         @26 TwoDigit  mmddyy8.
         @34 LastDate  date9.;
   format DOB VisitDate date9.
          TwoDigit LastDate mmddyy10.;
run;

*9-3;
data Ages;
   set Four_dates;
   Age = yrdif(DOB,VisitDate);
run;
title "Listing of Ages";
proc print data=Ages noobs;
run;

*9-4;
data Ages;
   set Four_Dates;
   Age = yrdif(DOB,'01Jan2017'd);
run;
title "Listing of Ages";
proc print data=Ages;
   format Age 5.1;
run;

*9-5;
data Ages;
   set Four_Dates;
   Age = yrdif(DOB,today());
run;

*9-6;
data Extract;
   set Four_Dates;
   Day = weekday(DOB);
   DayOfMonth = day(DOB);
   Month = Month(DOB);
   Year = year(DOB);
run;
title "Listing of Extract";
proc print data=Extract noobs;
   var DOB Day -- Year;
run;

*9-7;
data MDY_Example;
   set Learn.Month_Day_Year;
   Date = mdy(Month, Day, Year);
   format Date mmddyy10.;
run;

*9-8;
data Substitute;
   set Learn.Month_Day_Year;
   if missing(Day) then Date = mdy(Month,15,Year);
   else Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
run;

*9-9;
data Frequency;
   set Learn.Hosp(keep=AdmitDate 
                  where=(AdmitDate between '01Jan2003'd and
                        '30Jun2006'd));
   Quarter = intck('qtr','31Dec2002'd,AdmitDate);
run;
title "Admissions from January 1, 2003 to June 30, 2006";
proc sgplot data=Frequency;
   vbar Quarter;
run;

*9-10;
data Followup;
   set Learn.Hosp_Discharge;
   FollowDate = intnx('month',Discharge,6);
   format FollowDate date9.;
run;

*9-11;
data Followup;
   set Learn.Hosp_Discharge;
   FollowDate = intnx('month',Discharge,6,'sameday');
   format FollowDate date9.;
run;

title "Listing of Data Set Follow-Up";
proc print data=Followup noobs;
run;

*Chapter 10 Programs;

*Programs to create data sets One, Two, and Three;
data One;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
7 Adams 210
1 Smith 190
2 Schneider 110
4 Gregory 90
;
data Two;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
9 Shea 120
3 O'Brien 180
5 Bessler 207
;
data Three;
   length ID $ 3 Gender $ 1. Name $ 12;
   Input ID Gender Name;
datalines;
10 M Horvath
15 F Stevens
20 M Brown
;

*Temporary SAS data sets EMPLOYEE and HOURS;
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

*10-1;
data Females;
   set Learn.Survey;
   where Gender = 'F';
run;

*10-2;
data Females;
   set Learn.Survey(keep=ID Gender Age Ques1-Ques5);
   where Gender = 'F';
run;

*10-3;
data Males Females;
   set Learn.Survey;
   if Gender = 'F' then output Females;
   else if Gender = 'M' then output Males;
run;

*10-4;
data One_Two;
   set One Two;
run;

*10-5;
data One_Three;
   set One Three;
run;

*10-6;
proc sort data=One;
   by ID;
run;
proc sort data=Two;
   by ID;
run;
data Interleave;
   set One Two;
   by ID;
run;

*10-7;
proc means data=Learn.Blood noprint;
   var Chol;
   output out = Means(keep=Chol_Mean)
          mean = / autoname;
run;
data Percent;
   set Learn.Blood(keep=Subject Chol);
   if _n_ = 1 then set Means;
   PercentChol = Chol / Chol_Mean;
   format PercentChol percent8.;
run;

*10-8;
proc sort data=Employee;
   by ID;
run;
proc sort data=Hours;
   by ID;
run;
data Combine;
   merge Employee Hours;
   by ID;
run;

*10-9;
data New;
   merge Employee(in=In_Employee)
         Hours   (in=In_Hours);
   by ID;  
   file print;
   put ID= In_Employee= In_Hours= Name= JobClass= Hours=;
run;

*10-10;
data Combine;
   merge Employee(in=In_Employee)
         Hours(in=In_Hours);
   by ID;
   if In_Employee and In_Hours;
run;

*10-11;
data In_Both 
   Missing_Name(drop = Name);
   merge Employee(in=In_Employee)
         Hours(in=In_Hours);
    by ID;
    if In_Employee and In_Hours then output In_Both;
    else if In_Hours and not In_Employee then 
       output Missing_Name;
run;

*10-12;
data Short;
   input x;
datalines;
1
2
;
data Long;
   input x;
datalines;
3
4
5
6
;
data New;
   set Short;
   output;
   set Long;
   output;
run;

*10-13;
data Sesame;
   merge Bert
         Ernie(rename=(EmpNo = ID));
   by ID;
run;

*10-14;
data Division1C;
   set Division1(rename=(SS = NumSS));
   SS = put(NumSS,ssn11.);
   drop NumSS;
run;
data Both_Divisions;
   ***Note: Both data sets already in order
      of BY variable;
   merge Division1C Division2;
   by SS;
run;

*10-15;
data Division2N;
   set Division2(rename=(SS = CharSS));
   SS = input(compress(CharSS,,'kd'),9.);
   ***Alternative:
   SS = input(CharSS,comma11.);
   drop CharSS;
run;

*10-16;
proc sort data=Prices;
   by ItemCode;
run;
proc sort data=New15Dec2017;
   by ItemCode;
run;
data Prices_15dec2017;
   update Prices New15Dec2017;
   by ItemCode;
run;

*Chapter 11 Programs;

*11-1;
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

*11-2;
data Test_Miss;
   set Learn.Blood;
   if Gender = ' ' then MissGender + 1;
   if WBC = . then MissWBC + 1;
   if RBC = . then MissWBC + 1;
   if Chol lt 200 and Chol ne . then Level = 'Low ';
   else if Chol ge 200 then Level = 'High';
run;

*11-3;
data Test_Miss;
   set Learn.Blood;
   if missing(Gender) then MissGender + 1;
   if missing(WBC) then MissWBC + 1;
   if missing(RBC) then MissWBC + 1;
   if Chol lt 200 and not missing(Chol) then 
      Level = 'Low ';
   else if Chol ge 200 then Level = 'High';
run;

*11-4;
data Psych;
   input ID $ Q1-Q10;
   if n(of Q1-Q10) ge 7 then Score = mean(of Q1-Q10);
   MaxScore = max(of Q1-Q10);
   MinScore = min(of Q1-Q10);
datalines;
001 4 1 3 9 1 2 3 5 . 3
002 3 5 4 2 . . . 2 4 .
003 9 8 7 6 5 4 3 2 1 5
;

*11-5;
data Three_Large;
   set Psych(keep=ID Q1-Q10);
   SumThree = sum(largest(1,of Q1-Q10),
                  largest(2,of Q1-Q10),
                  largest(3,of Q1-Q10));
run;

*11-6;
data Sum;
   set Learn.EndofYear;
   Total = sum(0, of Pay1-Pay12, of Extra1-Extra12);
run;

*11-7;
data Math;
   input x @@;
   Absolute = abs(x);
   Square = sqrt(x);
   Exponent = exp(x);
   Natural = log(x);
datalines;
2 -2 10 100
;

*11-8;
data Constants;
   Pi = constant('pi');
   e = constant('e');
   Integer3 = constant('exactint',3);
   Integer4 = constant('exactint',4);
   Integer5 = constant('exactint',5);
   Integer6 = constant('exactint',6);
   Integer7 = constant('exactint',7);
   Integer8 = constant('exactint',8);
run;

*11-9;
data Uniform;   
   do i = 1 to 10;
      X = rand('uniform');
      output;
   end;
run;  

*11-10;
data Uniform; 
   call streaminit(1234567);  
   do i = 1 to 10;
      X = rand('uniform');
      output;
   end;
run;  

*11-11;
data Subset;
   set Learn.Blood;
   if rand('uniform') le .1;
run;

*11-12;
proc surveyselect data=Learn.Blood 
                  out=Subset 
                  method=srs
                  sampsize=100;
run;

*11-13;
data Nums;
   set Learn.Chars (rename=
                   (Height = Char_Height
                    Weight = Char_Weight
                    Date   = Char_Date));
   Height = input(Char_Height,8.);
   Weight = input(Char_Weight,8.);
   Date   = input(Char_Date,mmddyy10.);
   drop Char_Height Char_Weight Char_Date;
run;

*11-14;
proc format;
   value Agefmt low-<20 = 'Group One'
                20-<40  = 'Group Two'
                40-high = 'Group Three';
run;
data Convert;
   set Learn.Numeric;
   Char_Date = put(Date,date9.);
   AgeGroup = put(Age,Agefmt.);
   Char_Cost = put(Cost,dollar10.);
   drop Date Cost;
run;

*11-15;
data Look_Back;
   input Time Temperature;
   Prev_Temp = lag(Temperature);
   Two_Back = lag2(Temperature);
datalines;
1 60
2 62
3 65
4 70
;

*11-16;
data Laggard;
   input X @@;
   if X ge 5 then Last_X = lag(X);
datalines;
9 8 7 1 2 12
;

*11-17;
data Diff;
   input Time Temperature;
   Diff_Temp = Temperature - lag(Temperature);
datalines;
1 60
2 62
3 65
4 70  
;

*11-18;
data Diff;
   input Time Temperature;
   Diff_Temp = dif(Temperature);
datalines;
1 60
2 62
3 65
4 70
;

*11-19;
data Quizzes;
   input ID $ Quiz1 - Quiz8;
   if n(of Quiz1-Quiz8) ge 7 then Quiz_Score = mean(
      largest(1, of Quiz1-Quiz8), largest(2, of Quiz1-Quiz8),
      largest(3, of Quiz1-Quiz8), largest(4, of Quiz1-Quiz8),
      largest(5, of Quiz1-Quiz8), largest(6, of Quiz1-Quiz8));
datalines;
001 80 70 90 100 88 90 90 51
002 80 70 90 100 88 90 . .
003 60 60 70 70 70 70 80 .
;

*11-20;
data Quizzes;
   input ID $ Quiz1 - Quiz8;
   call sortn(of Quiz1 - Quiz8); 
   /***Scores are now in ascending order***/
   if n(of Quiz1-Quiz8) ge 7 then Quiz_Score = mean(of Quiz3-Quiz8);
datalines;
001 80 70 90 100 88 90 90 51
002 80 70 90 100 88 90 . .
003 60 60 70 70 70 70 80 .
;

*Chapter 12 Programs;

*12-1;
data Long_Names;
   set Learn.Sales;
   if lengthn(Name) gt 12;
run;

*12-2;
data Mixed;
   set Learn.Mixed;
   Name = upcase(Name);
run;
data Both;
   merge Mixed Learn.Upper;
   by Name;
run;

*12-3;
data Standard;
   set Learn.Address;
   Name = compbl(propcase(Name));
   Street = compbl(propcase(Street));
   City = compbl(propcase(City));
   State = upcase(State);
run;

*12-4;
  title "Demonstrating the Concatenation Functions";
data _null_;
   Length Join Name1 - Name4 $ 15;
   First = 'Ron  ';
   Last = 'Cody  ';
   Join = ':' || First || ':';
   Name1 = First || Last;
   Name2 = cat(First,Last);
   Name3 = cats(First,Last);
   Name4 = catx(' ',First,Last);
   file print;
   put Join= /
       Name1= /
       Name2= /
       Name3= /
       Name4= /;
run;

*12-5;
data Blanks;
   String = '  ABC ';
   ***There are 3 leading and 2 trailing blanks in String;
   JoinLeft = ':' || left(String) || ':';
   JoinTrim = ':' || trimn(String) || ':';
   JoinStrip = ':' || strip(String) || ':';
run;

*12-6;
data Phone;
   length PhoneNumber $ 10;
   set Learn.Phone;
   PhoneNumber = compress(Phone,' ()-.');
run;

*12-7;
data Phone;
   length PhoneNumber $ 10;
   set Learn.Phone;
   PhoneNumber = compress(Phone,,'kd');
   *Keep only digits;
run;

*12-8;
data Metric;
   set Learn.Mixed_Units;
   Wt_Kg = input(compress(Weight,,'kd'),12.);
   if find(Weight,'lb','i') then Wt_Kg = Wt_Kg/2.2;
   Ht_Cm = input(compress(Height,,'kd'),12.);
   if find(Height,'in','i') then Ht_Cm = Ht_Cm*2.54;
run;

*12-9;
data Look_for_Roger;
   input String $40.;
   if findw(String,'Roger',' ','i') then Match = 'Yes';
   else Match = 'No';
datalines;
Will Rogers
Roger Cody
Was roger here?
Was Roger here?
;

*12-10;
data Any_Digit;
   infile 'c:\books\learning\ID.txt';
   input ID : $10.;
   Position = anydigit(ID);
   if Position then output;
run;

*12-11;
title "Data Cleaning Application";
data _null_;
   file print;
   set Learn.Cleaning;
   if notalpha(trimn(Letters)) then put Subject= Letters=;
   if notdigit(trimn(Digits))  then put Subject= Digits=;
   if notalnum(trimn(Both))    then put Subject= Both=;
run;

*12-12;
data Extract;
   input ID : $10. @@;
   length State $ 2 Gender $ 1 Last $ 5;
   State = ID;
   Number = input(substr(ID,3,2),3.);
   Gender = substr(ID,5,1);
   Last = substr(ID,6);
datalines;
NJ12M99 NY76F4512 TX91M5
;

*12-13;
data Original;
   input Name $ 30.;
datalines;
Jeffrey Smith
Ron Cody
Alan Wilson
Alfred E. Newman
;
data First_Last;
   set Original;
   length First Last $ 15;
   First = scan(Name,1,' ');
   Last = scan(Name,2,' ');
run;

*12-14;
data Last;
   set Original;
   length Last_Name $ 15;
   Last_Name = scan(Name,-1,' ');
run;
proc sort data=Last;
   by Last_Name;
run;
title "Alphabetical List of Names";
proc print data=Last noobs;
   var Name Last_Name;
run;  

*12-15;
data Fuzzy;
   input Name $20.;
   Value = spedis(Name,'Friedman');
datalines;
Friedman
Freedman
Xriedman
Freidman
Friedmann
Alfred
FRIEDMAN
;

*12-16;
data Trans;
   input Answer : $5.;
      Answer = translate(Answer,'ABCDE','12345');
datalines;
14325
AB123
51492
;

*12-17;
data Address;
   infile datalines dlm=' ,';
   *Blanks or commas are delimiters;
   input #1 Name $30.
         #2 Line1 $40.
         #3 City & $20. State : $2. Zip : $5.;
   Name = tranwrd(Name,'Mr.',' ');
   Name = tranwrd(Name,'Mrs.',' ');
   Name = tranwrd(Name,'Dr.',' ');
   Name = tranwrd(Name,'Ms.',' ');
   Name = left(Name);
   Line1 = tranwrd(Line1,'Street','St.');
   Line1 = tranwrd(Line1,'Road','Rd.');
   Line1 = tranwrd(Line1,'Avenue','Ave.');
datalines;
Dr. Peter Benchley
123 River Road
Oceanside, NY 11518
Mr. Robert Merrill
878 Ocean Avenue
Long Beach, CA 90818
Mrs. Laura Smith
80 Lazy Brook Road
Flemington, NJ 08822
;

*Chapter 13 Programs;

*13-1;
data New;
   set Learn.SPSS;
   if Height = 999 then Height = .;
   if Weight = 999 then Weight = .;
   if Age    = 999 then Age    = .;
run;

*13-2;
data New;
   set Learn.SPSS;
   array Myvars{3} Height Weight Age;
   do i = 1 to 3;
      if Myvars{i} = 999 then Myvars{i} = .;
   end;
   drop i;
run;

*13-3;
data Missing;
   set Learn.Chars;
   array Char_Vars{*} $ _character_;
   do Loop = 1 to dim(Char_Vars);
      if Char_Vars{Loop} in ('NA','?') then
      Char_Vars{Loop} = ' ';
   end;
   drop Loop;
run;

*13-4;
data Proper;
   set Learn.Careless;
   array All_Chars{*} _character_;
   do i = 1 to dim(All_Chars);
      All_Chars{i} = propcase(All_Chars{i});
   end;
   drop i;
run;

*13-5;
data Temp;
   input Fahren1-Fahren24 @@;
   array Fahren[24];
   array Celsius[24] Celsius1-Celsius24;
   do Hour = 1 to 24;
      Celsius{Hour} = (Fahren{Hour} - 32)/1.8;
   end;
   drop Hour;
datalines;
35 37 40 42 44 48 55 59 62 62 64 66 68 70 72 75 75
72 66 55 53 52 50 45
;

*13-6;
data Account;
   input ID Income2010-Income2017;
   array Income{2010:2017} Income2010-Income2017;
   array Taxes{2010:2017} Taxes2010-Taxes2017;
   do Year = 2010 to 2017;
      Taxes{Year} = .25*Income{Year};
   end;
   format Income2010-Income2017 
          Taxes2010-Taxes2017 dollar10.;
datalines;
001 45000 47000 47500 48000 48000 52000 53000 55000
002 67130 68000 72000 70000 65000 52000 49000 40100
;

*13-7;
data Score;
   array Ans{10} $ 1;
   array Key{10} $ 1 _temporary_ 
      ('A','B','C','D','E','E','D','C','B','A');
   input ID (Ans1-Ans10)($1.);
   RawScore = 0;
   do Ques = 1 to 10;
      RawScore + (key{Ques} eq Ans{Ques});
   end;
   Percent = 100*RawScore/10;
   keep ID RawScore Percent;
datalines;
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;

*13-8;
data Score;
   array Ans{10} $ 1;
   array Key{10} $ 1 _temporary_;
   /* Load the temporary array elements */
   if _n_ = 1 then do Ques = 1 to 10;
      input key{Ques} $1. @;
   end;
   input ID (Ans1-Ans10)($1.);
   RawScore = 0;
   /* Score the test */
   do Ques = 1 to 10;
      RawScore + (key{Ques} eq Ans{Ques});
   end;
   Percent = 100*RawScore/10;
   keep ID RawScore Percent;
datalines;
ABCDEEDCBA
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;

*13-9;
  data Look_Up;
   /******************************************************
      Create the array, the first index is the year and
      it ranges from 1944 to 1949. The second index is
      the job code (we're using 1-5 to represent job codes
      A through E).
   *******************************************************/
   array Level{1944:1949,5} _temporary_;
   /* Populate the array */
   if _n_ = 1 then do Year = 1944 to 1949;
      do Job = 1 to 5;
         input level{Year,Job} @; 
      end;
   end;
   set Learn.Expose;
   /* Compute the job code index from the JobCode value */
   Job = input(translate(Jobcode,'12345','ABCDE'),1.);
   Benzene = level{Year,Job};
   drop Job;
datalines;
220 180 210 110 90
202 170 208 100 85
150 110 150 60 50
105 56 88 40 30
60 30 40 20 10
45 22 22 10 8
;

*Chapter 14 Programs;

*14-1;
title "Listing of Sales";
proc print data=Learn.Sales;
run;

*14-2;
title "Listing of Sales";
proc print data=Learn.Sales;
   var EmpID Customer TotalSales;
run;

*14-3;
title "Listing of Sales";
proc print data=Learn.Sales;
   id EmpID;
   var Customer TotalSales;
run;

*14-4;
title "Listing of Sales";
proc print data=Learn.Sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-5;
title "Listing of Sales with Quantities Greater than 400";
proc print data=Learn.Sales;
   where Quantity gt 400;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run; 

*14-6;
title "Listing of Sales from Employees 1843 and 0177";
proc print data=Learn.Sales;
   where EmpID in ('1843','0177');
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-7;
title1 "The XYZ Company";
title3 "Sales Figures for Fiscal 2017";
title4 "Prepared by Roger Rabbit";
title5 "-----------------------------";
footnote "All sales Figures are Confidential";
proc print data=Learn.Sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-8;
proc sort data=Learn.Sales;
   by TotalSales;
run;
title "Listing of Sales – Sorted by Total Sales";
proc print data=Learn.Sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-9;
proc sort data=Learn.Sales;
   by descending TotalSales;
run;

*14-10;
proc sort data=Learn.Sales out=Sales;
   by descending TotalSales;
run;

*14-11;
proc sort data=Learn.Sales out=Sales;
   by EmpID descending TotalSales;
run;
title "Sorting by More than One Variable";
proc print data=sales;
   id EmpID;
   var TotalSales Quantity;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-12;
title "Using Labels as Column Headings";
proc print data=Sales label;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-13;
proc sort data=Learn.Sales out=Sales;
   by Region;
run;
title "Demonstrating the BY Statement in PROC PRINT";
proc print data=sales label;
   by Region;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-14;
proc sort data=Learn.Sales out=Sales;
   by Region;
run;
title "Adding Totals and Subtotals to Your Listing";
proc print data=Sales label;
   by Region;
   id EmpID;
   var TotalSales Quantity;
   sum Quantity TotalSales;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;
*14-15;
proc sort data=Learn.Sales out=Sales;
   by EmpID;
run;
title "Using the Same Variable in an ID and BY Statement";
proc print data=sales label;
   by EmpID;
   id EmpID;
   var Customer TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-16;
title "Demonstrating the N= option of PROC PRINT";
proc print data=Sales n="Total number of Observations:";
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*14-17;
title "First Five Observations from Sales";
proc print data=Learn.Sales(obs=5);
run;

*Chapter 15 Programs;

*15-1;
title "Listing of Data Set Medical from PROC PRINT";
proc print data=Learn.Medical;
   id Patno;
run;

*15-2;
title "Using the REPORT Procedure";
proc report data=Learn.Medical;
run;

*15-3;
title "Adding a COLUMN Statement";
proc report data=Learn.Medical;
   column Patno DX HR Weight;
run;

*15-4;
title "Report with Only Numeric Variables";
proc report data=Learn.Medical;
   column HR Weight;
run;

*15-5;
title "Display Usage for Numeric Variables";
proc report data=Learn.Medical;
   column HR Weight;
   define HR / display "Heart Rate" width=5; 
   define Weight / display width=6;
run;

*15-6;
title "Demonstrating a GROUP Usage";
proc report data=learn.medical;
   column Clinic HR Weight;
   define Clinic / group width=11;
   define HR / analysis mean "Average Heart Rate" width=12 
               format=5.; 
   define Weight / analysis mean "Average Weight" width=12 
                   format=6.;
run;

*15-7;
title "Demonstrating the FLOW Option";
proc report data=Learn.Medical headline 
            split=' ' ls=74;
   column Patno VisitDate DX HR Weight Comment;
   define Patno     / "Patient Number" width=7;
   define VisitDate / "Visit Date" width=9 format=date9.;
   define DX        / "DX Code" width=4 right;
   define HR        / "Heart Rate" width=6;
   define Weight    / width=6;
   define Comment   / width=30 flow;
run;

*15-8;
title "Demonstrating the FLOW Option";
proc report data=Learn.Medical headline 
            split=' ' ls=74;
   column Patno VisitDate DX HR Weight Comment;
   define Patno     / display "Patient Number" width=7;
   define VisitDate / display "Visit Date" width=9
                      format=date9.;
   define DX        / display "DX Code" width=4 right;
   define HR        / display "Heart Rate" width=6;
   define Weight    / display width=6;
   define Comment   / display width=30 flow;
run;

*15-9;
title "Multiple GROUP Usages";
proc report data=Learn.Bicycles headline ls=80;
   column Country Model Units TotalSales;
   define Country / group width=14;
   define Model   / group width=13;
   define Units   / sum "Number of Units" width=8 
                    format=comma8.;
   define TotalSales / sum "Total Sales (in thousands)" 
                       width=15 format=dollar10.;
run;

*15-10;
title "Multiple GROUP Usages";
proc report data=Learn.Bicycles headline ls=80;
   column Model Country Manuf Units TotalSales;
   define Country / group width=14;
   define Model   / group width=13;
   define Manuf   / width=12;
   define Units   / sum "Number of Units" width=8 
                    format=comma8.;
   define TotalSales / sum "Total Sales (in thousands)" 
                       width=15 format=dollar10.;
run;

*15-11;
title "Listing from SALES in EmpID Order";
proc report data=Learn.Sales headline;
   column EmpID Quantity TotalSales;
   define EmpID / order "Employee ID" width=11;
   define Quantity / width=8 format=comma8.;
   define TotalSales / "Total Sales" width=9 
                        format=dollar9.;
run;

*15-12;
title "Applying the ORDER Usage for Two Variables";
proc report data=Learn.Sales headline;
   column EmpID Quantity TotalSales;
   define EmpID / order "Employee ID" width=11;
   define TotalSales / descending order "Total Sales" 
                       width=9 format=dollar9.;
   define Quantity / width=8 format=comma8.;
run;

*15-13;
proc format;
   value groupfmt 0 = 'A' 1 = 'B' 2 = 'C';
run;
title "Random Assignment - Three Groups";
proc report data=Learn.Assign panels=99 
            headline ps=16;
   columns Subject Group;
   define Subject / display width=7;
   define Group / width=5;
run;

*15-14;
title "Producing Report Breaks";
proc report data=Learn.Sales;
   column Region Quantity TotalSales;
   define Region / order width=6;
   define Quantity / sum width=8 format=comma8.;
   define TotalSales / sum "Total Sales" width=9 
                       format=dollar9.;
   rbreak after / summarize;
run;

*15-15;
title "Producing Report Breaks";
proc report data=Learn.Sales;
   column Region Quantity TotalSales;
   define Region / order width=6;
   define Quantity / sum width=8 format=comma8.;
   define TotalSales / sum "Total Sales" width=9 
                      format=dollar9.;
   break after region / summarize; 
run;

*15-16;
data Temp;
   set Learn.Sales;
   length LastName $ 10;
   LastName = scan(Name,-1,' ');
run;
title "Listing Ordered by Last Name";
proc report data=Temp;
   column LastName Name EmpID TotalSales;
   define LastName / group noprint;
   define Name / group width=15;
   define EmpID / "Employee ID" group width=11;
   define TotalSales / sum "Total Sales" width=9 
                       format=dollar9.;
run;

*15-17;
title "Computing a New Variable";
proc report data=Learn.Medical;
   column Patno Weight WtKg;
   define Patno / display "Patient Number" width=7;
   define Weight / display noprint width=6;
   define WtKg / computed "Weight in Kg" 
                 width=6 format=6.1;
   compute WtKg;
      WtKg = Weight / 2.2;
   endcomp;
run;

*15-18;
title "Creating a Character Variable in a COMPUTE Block";
proc report data=Learn.Medical;
   column Patno HR Weight Rate;
   define Patno / display "Patient Number" width=7;
   define HR / display "Heart Rate" width=5; 
   define Weight / display width=6;
   define Rate / computed width=6;
   compute Rate / character length=6;
     if HR gt 75 then Rate = 'Fast';
     else if HR gt 55 then Rate = 'Normal';
     else if not missing(HR) then Rate='Slow';
   endcomp;
run;

*15-19;
***Demonstrating an Across Usage;
title "Demonstrating an ACROSS Usage";
proc report data=Learn.Bicycles;
   column Model,Units Country;
   define Country  / group width=14;
   define Model    / across "Model";
   define Units    / sum "# of Units" width=14
                     format=comma8.;
run;

*15-20;
title "Average Blood Counts by Age Group";
proc report data=Learn.Blood;
   column Gender BloodType AgeGroup,WBC AgeGroup,RBC;
   define Gender    / group width=8;
   define BloodType / group width=8 "Blood Group";
   define AgeGroup  / across "Age Group";
   define WBC       / analysis mean format=comma8.;
   define RBC       / analysis mean format=8.2;
run;

*Chapter 16 Programs;

*16-1;
title "PROC MEANS With All the Defaults";
proc means data=Learn.Blood;
run;

*16-2;
title "Selected Statistics Using PROC MEANS";
proc means data=Learn.Blood n nmiss mean median 
                            min max maxdec=1;
   var RBC WBC;
run;

*16-3;
proc sort data=Learn.Blood out=Blood;
   by Gender;
run;
title "Adding a BY Statement to PROC MEANS";
proc means data=Blood n nmiss mean median 
                      min max maxdec=1;
   by Gender;
   var RBC WBC;
run;

*16-4;
title "Using a CLASS Statement with PROC MEANS";
proc means data=Learn.Blood n nmiss mean median 
                            min max maxdec=1;
   class Gender;
   var RBC WBC;
run;

*16-5;
proc format;
   value Chol_Group
    low -< 200 = 'Low'
    200 - high = 'High';
run;
title "Using a CLASS Statement with PROC MEANS";
proc means data=Learn.Blood n nmiss mean median maxdec=1;
   class Chol;
   format Chol Chol_Group.;
   var RBC WBC;
run;

*16-6;
proc means data=Learn.Blood noprint;
   var RBC WBC;
   output out = My_Summary 
          mean = MeanRBC MeanWBC;
run;
title "Listing of My_Summary";
proc print data=My_Summary noobs;
run;

*16-7;
proc means data=Learn.Blood noprint;
   var RBC WBC;
   output out     = Many_Stats 
          mean    = M_RBC M_WBC
          n       = N_RBC N_WBC
          nmiss   = Miss_RBC Miss_WBC
          median  = Med_RBC Med_WBC;
run;

*16-8;
proc means data=Learn.Blood noprint;
   var RBC WBC;
   output out = Many_Stats 
                mean    =
                n       =
                nmiss   =
                median  = / autoname;
run;

*16-9;
proc sort data=Learn.Blood out=Blood;
   by Gender;
run;
proc means data=Blood noprint;
   by Gender;
   var RBC WBC;
   output out  = By_Gender 
          mean = 
          n    =  / autoname;
run;

*16-10;
proc means data=Learn.Blood noprint;
  class Gender;
  var RBC WBC;
  output out  = With_Class 
         mean = 
         n    =  / autoname;
run;

*16-11;
proc means data=Learn.Blood noprint nway;
   class Gender;
   var RBC WBC;
   output out  = With_Class 
          mean = 
          n    =  / autoname;
run;

*16-12;
proc means data=Learn.Blood noprint;
   class Gender AgeGroup;
   var RBC WBC;
   output out  = Summary 
          mean =
          n    = / autoname;
run;

*16-13;
proc means data=Learn.Blood noprint chartype;
   class Gender AgeGroup;
   var RBC WBC;
   output out  = Summary 
          mean =
          n    = / autoname;
run;

*16-14;
title "Statistics Broken Down by Gender";
proc print data=Summary(drop = _freq_) noobs;
   where _TYPE_ = '10';
run;

*16-15;
data Grand(drop = Gender AgeGroup) 
     By_gender(drop = AgeGroup)
     By_Age(drop = Gender)
     Cellmeans;
  set Summary;
  drop _type_;
  rename _freq_ = Number;
  if _type_ = '00' then output Grand;
  else if _type_ = '01' then output By_Age;
  else if _type_ = '10' then output By_Gender;
  else if _type_ = '11' then output Cellmeans;
run;

*16-16;
proc means data=Learn.Blood noprint nway;
   class Gender AgeGroup;
   output out = Summary(drop = _:) 
          mean(RBC WBC)   = 
          n(RBC WBC Chol) = 
          median(Chol)    = / autoname;
run;

*16-17;
title "Demonstrating the PRINTALLTYPES Option";
proc means data=Learn.Blood printalltypes;
   class Gender AgeGroup;
   var RBC WBC;
run;

*Chapter 17 Programs;

*17-1;
title "PROC FREQ with all the Defaults";
proc freq data=Learn.Survey;
run;

*17-2;
title "Adding a TABLES Statement and the NOCUM Tables Option";
proc freq data=learn.survey;
   tables Gender Ques1-Ques3 / nocum;
run;

*17-3;
proc format;
   value $Gender 
      'F' = 'Female'
      'M' = 'Male';
   value $Likert 
      '1' = 'Strongly disagree'
      '2' = 'Disagree'
      '3' = 'No opinion'
      '4' = 'Agree'
      '5' = 'Strongly agree';
run;
title "Adding Formats";
proc freq data=Learn.Survey;
   tables Gender Ques1-Ques3 / nocum;
   format Gender $Gender.
          Ques1-Ques3 $Likert.;
run;

*17-4;
proc format;
   value AgeGroup
      low-<30  = 'Less than 30'
      30-<60   = '30 to 59'
      60-high  = '60 and higher';
   value $Agree_Disagree
      '1','2' = 'Generally disagree'
      '3'     = 'No opinion'
      '4','5' = 'Generally agree';
run;
title "Using Formats to Create Groups";
proc freq data=Learn.Survey;
   tables Age Ques5 / nocum nopercent;
   format Age AgeGroup.
          Ques5 $Agree_Disagree.;
run;

*17-5;
proc format;
   value Two 
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      other = 'Other values';
run;
title "Grouping Values (First Try)";
proc freq data=Learn.Grouping;
   tables X / nocum nopercent;
   format X Two.;
run;

*17-6;
proc format;
   value Two 
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      .     = 'Missing'
      other = 'Other values';
run;

*17-7;
title "PROC FREQ Without the MISSING Option";
proc freq data=Learn.Grouping;
   format X two.;
   tables X;
run;
title "PROC FREQ With the MISSING Option";
proc freq data=Learn.Grouping;
   tables X / missing;
   format X Two.;
run;

*17-8;
proc format;
   value Colors 
      1 = 'Yellow'
      2 = 'Blue'
      3 = 'Red'
      4 = 'Green'
      . = 'Missing';
run;
data Test;
   input Color @@;
datalines;
3 4 1 2 3 3 3 1 2 2
;
title "Default Order (Internal)";
proc freq data=Test; 
   tables Color / nocum nopercent missing;
   format Color Colors.;
run;

*17-9;
title "ORDER = Formatted";
proc freq data=Test order=formatted;
   tables Color / nocum nopercent;
   format Color Colors.;
run;
title "ORDER = Data";
proc freq data=Test order=data;
   tables Color / nocum nopercent;
   format Color Colors.;
run;
title "ORDER = Freq";
proc freq data=test order=freq;
   tables Color / nocum nopercent;
   format Color Colors.;
run;

*17-10;
title "A Two-way Table of Gender by Blood Type";
proc freq data=Learn.Blood;
   tables Gender * BloodType;
run;

*17-11;
title "Example of a Three-way Table";
proc freq data=learn.blood;
   tables Gender * AgeGroup * BloodType / 
          nocol norow nopercent;
run;

*Chapter 18 Programs;

*18-1;
title "All Defaults with One CLASS Variable";
proc tabulate data=Learn.Blood;
   class Gender;
   table Gender;
run;

*18-2;
title "Demonstrating Concatenation";
proc tabulate data=Learn.Blood format=6.;
   class Gender BloodType;
   table Gender BloodType;
run;

*18-3;
title "Demonstrating Table Dimensions";
proc tabulate data=Learn.Blood format=6.;
   class Gender BloodType;
   table Gender,
         BloodType;
run;

*18-4;
title "Demonstrating Nesting";
proc tabulate data=Learn.Blood format=6.;
   class Gender BloodType;
   table Gender * BloodType;
run;

*18-5;
title "Adding the Keyword ALL to the TABLE Request";
proc tabulate data=Learn.Blood format=6.;
   class Gender BloodType;
   table Gender ALL,
         BloodType ALL;
run;

*18-6;
title "Demonstrating Analysis Variables";
proc tabulate data=Learn.Blood;
   var RBC WBC;
   table RBC WBC;
run;

*18-7;
title "Specifying Statistics";
proc tabulate data=Learn.Blood;
   var RBC WBC;
   table RBC*mean WBC*mean;
run;

*18-8;
title "Specifying More than One Statistic";
proc tabulate data=Learn.Blood format=comma9.2;
   var RBC WBC;
   table (RBC WBC)*(mean min max);
run;

*18-9;
title "Combining CLASS and Analysis Variables";
proc tabulate data=Learn.Blood format=comma11.2;
   class Gender AgeGroup;
   var RBC WBC Chol;
   table (Gender ALL)*(AgeGroup All),
          (RBC WBC Chol)*mean;
run;

*18-10;
title "Specifying Formats";
proc tabulate data=Learn.Blood;
   var RBC WBC;
   table RBC*mean*f=7.2 WBC*mean*f=comma7.;
run;

*18-11;
title "Specifying Formats and Renaming Keywords";
proc tabulate data=Learn.Blood;
   class Gender;
   var RBC WBC;
   table Gender ALL,
         RBC*(mean*f=9.1 std*f=9.2)
         WBC*(mean*f=comma9. std*f=comma9.1);
   keylabel ALL  = 'Total'
            mean = 'Average'
            std  = 'Standard Deviation';
run;

*18-12;
title "Eliminating the 'N' Row from the Table";
proc tabulate data=Learn.Blood format=6.;
   class Gender;
   table Gender*n=' ';
run;

*18-13;
title "Combining CLASS and Analysis Variables";
proc tabulate data=Learn.Blood format=comma9.2;
   class Gender AgeGroup;
   var RBC WBC Chol;
   table (Gender=' ' ALL)*(AgeGroup=' ' All),
          RBC*(n*f=3. mean*f=5.1)
          WBC*(n*f=3. mean*f=comma7.)
          Chol*(n*f=4. mean*f=7.1);
   keylabel ALL = 'Total';
run;

*18-14;
title "Counts and Percentages";
proc tabulate data=Learn.Blood format=6.;
   class BloodType;
   table BloodType*(n pctn);
run;

*18-15;
proc format;
   picture Pctfmt low-high='009.9%';
run;
title "Counts and Percentages";
proc tabulate data=Learn.Blood;
   class BloodType;
   table (BloodType ALL)*(n*f=5. pctn*f=Pctfmt7.1);
   keylabel n    = 'Count'
            pctn = 'Percent';
run;

*18-16;
proc format;
   picture Pctfmt low-high='009.9%';
run;
title "Counts and Percentages in a Two-way Table";
proc tabulate data=Learn.Blood;
   class Gender BloodType;
   table (BloodType ALL='All Blood Types'),
         (Gender ALL)*(n*f=5. pctn*f=Pctfmt7.1) /RTS=25;
   keylabel ALL  = 'Both Genders'
            n    = 'Count'
            pctn = 'Percent';
run;

*18-17;
title "Percents on the Column Dimension";
proc tabulate data=Learn.Blood;
   class Gender BloodType;
   table (BloodType ALL='All Blood Types'),
         (Gender ALL)*(n*f=5. colpctn*f=Pctfmt7.1) /RTS=25;
   keylabel All     = 'Both Genders'
            n       = 'Count'
            colpctn = 'Percent';
run;

*18-18;
title "Computing Percentages on a Numerical Value";
proc tabulate data=Learn.Sales;
   class Region;
   var TotalSales;
   table (Region ALL),
          TotalSales*(n*f=6. sum*f=dollar8. 
                      pctsum*f=pctfmt7.);
            keylabel ALL  = 'All Regions'
            n       = 'Number of Sales'
            sum     = 'Sum'
            pctsum  = 'Percent';
   label TotalSales = 'Total Sales';
run;

*18-19;
title "The Effect of Missing Values on CLASS variables";
proc tabulate data=Learn.Missing format=4.;
   class A B;
   table A ALL,B ALL;
run;

*18-20;
title "The Effect of Missing Values on CLASS variables";
proc tabulate data=Learn.Missing format=4.;
   class A B C;
   table A ALL,B ALL;
run;

*18-21;
title "The Effect of Missing Values on CLASS variables";
proc tabulate data=Learn.Missing format=4. missing;
   class A B;
   table A ALL,B ALL;
run;

*18-22;
title "Demonstrating the MISSTEXT TABLES Option";
proc tabulate data=Learn.Missing format=7. missing;
   class A B;
   table A ALL,B ALL / misstext='No Data';
run;

*Chapter 19 Programs;

*19-1;
ods html path='C:\books\learning'
       file='Sample.html';
title "Listing of Test_Scores";
proc print data=Learn.Test_Scores;
   title2 "Sample of HTML Output - all defaults";
   id ID;
   var Score1-Score3;
run;
title "Descriptive Statistics";
proc means data=Learn.Test_Scores n nmiss mean min max maxdec=2;
   var Score1-Score3;
run;
ods html close;

*19-2;
ods html body = 'Body_Sample.html' 
         contents = 'Contents_Sample.html'
         frame = 'Frame_Sample.html'
         path = 'c:\books\learning';
title "Using ODS to Create a Table of Contents";
proc print data=Learn.Test_Scores;
   id ID;
   var Name Score1-Score3;
run;
title "Descriptive Statistics";
proc means data=Learn.Test_Scores n mean min max;
   var Score1-Score3;
run;
ods html close;

*19-3;
ods html path = 'c:\books\learning'
         file = 'Journal_Example.html' 
                style=Journal;
title "Listing of Test_Scores";
proc print data=Learn.Test_Scores;
   id ID;
   var Name Score1-Score3;
run;
ods html close; 

*19-4;
ods select extremeobs;
title "Extreme Values of RBC";
proc Univariate data=Learn.Blood;
   id Subject;
   var RBC;
run;

*19-5;
ods trace on;
title "Extreme Values of RBC";
proc Univariate data=Learn.Blood;
   id Subject;
   var RBC;
run;
ods trace off;

*19-6;
ods listing close;
ods output ttests=T_Test_Data;
proc ttest data=Learn.Blood;
   class Gender;
   var RBC WBC Chol;
run;
ods listing;
title "Listing of T_Test_Data";
proc print data=T_Test_Data;
run;

*19-7;
title "T-Test Results – Using Equal Variance Method";
proc report data=T_Test_Data;
   where Variances = "Equal";
   columns Variable tValue ProbT;
   define Variable / width=8;
   define tValue / display "T-Value" width=7 format=7.2;
   define ProbT / display "P-Value" width=7 format=7.5;
run;

*Chapter 20 Programs;

*20-1;
title "Vertical Bar Chart Example";
proc sgplot data=Learn.Blood;
   vbar BloodType;
run;

*20-2;
title "Horizontal Bar Chart Example";
proc sgplot data=Learn.Blood;
   hbar BloodType / nofill barwidth=.25;
run;

*20-3;
title "Vertical Bar Chart Example (two variables)";
proc sgplot data=Learn.Blood;
   vbar Gender / group=BloodType;
run;

*20-4;
title "Vertical Bar Chart Displayig a Response Variable";
proc sgplot data=Learn.Blood;
   vbar BloodType / response=Chol stat=mean barwidth=.5 nofill;
run;

*20-5;
title "Simple Scatter Plot";
proc sgplot data=SASHelp.Iris;
   scatter x=PetalWidth y=PetalLength;
run;

*20-6;
title "Scatter Plot with a Regression Line and Confidence Intervals";
proc sgplot data=SASHelp.Iris;
   reg x=PetalWidth y=PetalLength / CLM CLI;
run;

*20-7;
data Moving_Average;
   set Learn.Stocks;
   Previous = lag(Price);
   Two_Back = lag2(Price);
   if _n_ ge 3 then Moving=mean(Price, Previous, Two_Back);
run;
title "Series Plot";
proc sgplot data=Moving_Average;
   series x=Date y=Price;
   series x=Date y=Moving;
run;

*20-8;
title "Smooth Curve - Splines";
proc sgplot data=SASHelp.Iris;
   pbspline x=PetalWidth y=PetalLength;
run;

*20-9;
title "Smooth Curve - LOESS Method";
proc sgplot data=SASHelp.Iris;
   loess x=PetalWidth y=PetalLength;
run;

*20-10;
title "Histogram with a Normal Curve Overlaid";
proc sgplot data=Learn.Blood;
   histogram RBC;
   density RBC;
run;

*20-11;
title "Simple Box Plot";
proc sgplot data=Learn.Blood;
   hbox RBC;
run;

*20-12;
title "Box Plot with a Grouping Variable";
proc sgplot data=Learn.Blood;
   hbox RBC / group=BloodType;
run;

*20-13;
title "Demonstrating Overlays and Transparency";
proc sgplot data=SASHelp.Iris;
   vbar Species / Response=PetalWidth stat=mean barwidth=.8;
   vbar Species / Response=PetalLength barwidth=.3 
                    transparency=.2 stat=mean;
run;

*Chapter 21 Programs;

*21-1;
data Missing;
   infile 'C:\books\Learning\Missing.txt';
   input x y z;
run;

*21-2;
data Missing;
   infile 'C:\books\Learning\Missing.txt' missover;
   input x y z;
run;

*21-3;
data Short;
   infile 'C:\books\Learning\Short.txt';
   input Subject  $ 1-3
         Name     $ 4-19
         Quiz1      20-22
         Quiz2      23-25
         Quiz3      26-28;
run;

*21-4;
data Short;
   infile 'C:\books\Learning\Short.txt' pad;
   input Subject  $ 1-3
         Name     $ 4-19
         Quiz1      20-22
         Quiz2      23-25
         Quiz3      26-28;
run;

*21-5;
title "Demonstrating the INFILE Option END=";
data _null_;
   file print;
   infile 'C:\books\Learning\Month.txt' end=Last;
   input @1 Month $3.
         @5 MonthTotal 4.;
   YearTotal + MonthTotal;
   if last then 
      put "Total for the year is" YearTotal dollar8.;
run;

*21-6;
data ReadThree;
   infile 'C:\books\Learning\Month.txt' obs=3;
   input @1 Month $3.
         @5 MonthTotal 4.;
run;

*21-7;
data Read_5_to_7;
   infile 'C:\books\Learning\Month.txt' firstobs=5 obs=7;
   input @1 Month $3.
         @5 MonthTotal 4.;
run;

*21-8;
/*** Demonstration Program 
data Combined;
   if Finished = 0 then infile 'Alpha.txt' end=Finished;
   else infile 'Beta.txt';
   input . . .;
   . . .
run;
***/

*21-9;
/*** Demonstration Program 

  filename Bilbo ('Alpha.txt' 'Beta.txt');

  data Combined;
     infile Bilbo;
     input . . .;
     . . .
  run;
***/

*21-10;
/*** Demonstration Program
data ReadMany;
   infile 'C:\books\Learning\Filenames.txt';
   input ExternalNames $ 40.;
   infile dummy filevar=ExternalNames end=Last;
   do until (Last);
      input . . .;
      output;
   end;
run;
***/

*21-11;
/*** Demonstration Program
data ReadMany;
   input ExternalNames $ 40.;
   infile dummy filevar=ExternalNames end=Last;
   do until (Last);
      input . . .;
      output;
   end;
datalines;
C:\books\learning\Data1.txt
C:\books\learning\MoreData.txt
C:\books\learning\Fred.txt
;
***/

*21-12;
data Health;
   infile 'C:\books\Learning\Health.txt' pad;
   input #1 @1  Subj      $3.
            @4  DOB mmddyy10.
            @14 Weight     3.
         #2 @4  HR         3.
            @7  SBP        3.
            @10 DBP        3.;
   format DOB mmddyy10.;
run;

*21-13;
data health;
   infile 'C:\books\Learning\Health.txt' pad;
   input  @1  Subj      $3.
          @4  DOB mmddyy10.
          @14 Weight     3. /
          @4  HR         3.
          @7  SBP        3.
          @10 DBP        3.;
   format DOB mmddyy10.;
run;

*21-14;
/*** Demonstration Program
data Survey;
   infile 'C:\books\Learning\Survey56.txt' pad;
   input @9 year $4.;
   if year = '2005' then
      input @1 Number
            @4 Q1
            @5 Q2
            @6 Q3
            @7 Q4;
   else if year = '2006' then
      input @1 Number
            @4 Q1
            @5 Q2
            @6 Q2B
            @7 Q3
            @8 Q4;
run;
***/

*21-15;
data Survey;
   infile 'C:\books\Learning\Survey56.txt' pad;
   input @9 Year $4. @;  
   if Year = '2005' then
      input @1 Number $3.
            @4 Q1 $1.
            @5 Q2 $1.
            @6 Q3 $1.
            @7 Q4 $1.;
   else if Year = '2006' then
      input @1 Number $3.
            @4 Q1 $1.
            @5 Q2 $1.
            @6 Q2B $1.
            @7 Q3 $1.
            @8 Q4 $1.;
run;

*21-16;
data Females;
   infile 'C:\books\Learning\Bank.txt' pad;
   input @14 Gender $1. @;
   if Gender ne 'F' then delete;
   input @1  Subj         $3.
         @4  DOB    mmddyy10.
         @15 Balance       7.;
run;

*21-17;
data Pairs;
   input X Y;
datalines;
1 2
3 4
5 7
8 9
11 14
13 18
21 27
30 40
;

*21-18;
data Pairs;
   input X Y @@;
datalines;
1 2  3 4  5 7  8 9  11 14  13 18  21 27
30 40
;

*Chapter 22 Programs;

*22-1;
proc format;
   value Agefmt  0 - <20  = '< 20'
                20 - <40  = '20 to 39'
                40 - <60  = '40 to 59'
                60 - high = '60+';
run;
title "Using a Format to Recode a Variable";
proc freq data=Learn.Survey;
   tables Age / nocum nopercent;
   format Age agefmt.;
run;

*22-2;
proc format;
   value Agefmt  0 - <20  = '< 20'
                20 - <40  = '20 to 39'
                40 - <60  = '40 to 59'
                60 - high = '60+';
run;
data Survey;
   set Learn.Survey;
   AgeGroup = put(Age,Agefmt.);
run;
title "Using a Format to Create a Character Variable";
proc print data=Survey;
   id ID;
   var Age AgeGroup;
run;

*22-3;
proc format;
   invalue Convert 'A+' = 100
                    'A'  = 96     
                    'A-' = 92
                    'B+' = 88
                    'B'  = 84
                    'B-' = 80
                    'C+' = 76
                    'C'  = 72
                    'F'  = 65;
run;
data Grades;
   input @1 ID $3.
         @4 Grade Convert2.;
datalines;
001A-
002B+
003F
004C+
005A
;

*22-4;
proc format;
   invalue Convert(upcase just)
           'A+' = 100
           'A'  = 96     
           'A-' = 92
           'B+' = 88
           'B'  = 84
           'B-' = 80
           'C+' = 76
           'C'  = 72
           'F'  = 65
         other  =  .;
run;
data Grades;
   input @1 ID $3.
         @4 Grade convert2.;
datalines;
001A-
002b+
003F
004c+
005 A
006X
;
title "Listing of Grades";
proc print data=Grades noobs;
run;

*22-5;
data Temperatures;
   input Dummy $ @@;
   if upcase(Dummy) = 'N' then Temp = 98.6;
   else Temp = input(Dummy,8.);
   drop Dummy;
datalines;
101 N 97.3 n N 104.5
;

*22-6;
proc format;
   invalue Readtemp(upcase)
                96 - 106 = _same_
                'N'      = 98.6
                other    = .;
run;
data Temperatures;
   input Temp : Readtemp5. @@;
datalines;
101 N 97.3 n N 67 104.5
;

*22-7;
proc format;
   invalue ReadGrade(upcase)
      'A' = 95
      'B' = 85
      'C' = 75
      'F' = 65
      other = _same_;
run;
data School;
   input Grade : ReadGrade3. @@;
datalines;
97 99 A C 72 f b
;

*22-08;
proc format;
   value NameLookup
     122 = 'Salt'
     188 = 'Sugar'
     101 = 'Cereal'
     755 = 'Eggs'
   other = ' ';
   invalue PriceLookup
     'Salt'   = 3.76
     'Sugar'  = 4.99
     'Cereal' = 5.97
     'Eggs'   = 2.65
      other   = .;
run;
data Grocery;
   input ItemNumber @@;
   Name = put(ItemNumber,NameLookup.);
   Price = input(Name,PriceLookup.);
datalines;
101 755 122 188 999 755
;

*22-9;
data Learn.Codes;
   input ICD10 : $5. Description & $21.;
datalines;
020 Plague
022 Anthrax
390 Rheumatic fever
410 Myocardial infarction
493 Asthma
540 Appendicitis
;

*22-10;
data Control;
   set Learn.Codes(rename=
                   (ICD10 = Start
                    Description = Label));
   retain Fmtname '$ICDFMT'
          Type 'C';
run;
title "Demonstrating an Input Control Data Set";
proc format cntlin=Control fmtlib;
run;

*22-11;
data Disease;
   input ICD10 : $5. @@;
datalines;
020 410 500 493
;
title "Listing of Disease";
proc print data=Disease noobs;
   format ICD10 $ICDFMT.;
run;

*22-12;
data Control;
   set Learn.Codes(rename=
                   (ICD10 = Start
                   Description = Label))
                   End = Last;
   retain Fmtname '$ICDFMT'
          Type 'C';
   output;
   if last then do;
      Start = ' ';
      Hlo = 'o';
      Label = 'Not Found';
      output;
   end;
run;

*22-13;
proc format cntlout=Control_Out;
   select $ICDFMT;
run;
data New_Control;
   length Label $ 21;
   set Control_Out end=Last;
   output;
   if Last then do;
      Hlo = ' ';
      Start = '427.5';
      End = Start;
      Label = 'Cardiac Arrest';
      output;
      Start = '466';
      End = Start;
      Label = 'Bronchitis';
      output;
   end;
run;
proc format cntlin=New_Control;
   select $ICDFMT;
run;

*22-14;
proc format;
   value Registration low - <'01Jan2018'd  = 'Not Open'
              '01Jan2018'd - '31Dec2018'd = [mmddyy10.]
              '01Jan2019'd - high          = 'Too Late';
run;

*22-15;
data Conference;
   input @1  Name $10.
         @11 Date mmddyy10.;
   format Date Registration.;
datalines;
Smith     10/21/2018
Jones     11/13/2017
Harris    01/03/2018
Arnold    02/12/2019
;

*22-16;
proc format;
   invalue YearExp 1946 = 250
                   1947 = 244
                   1948 = 240
                   1949 = 200
                   1950 = 188
                   1951 = 150
                   1952 = 100;
   invalue Exp Low - <1946  = [7.1]
               1946 - 1952  = [Yearexp.]
               1952< - high = [7.1];
run;
data Benzene;
   infile 'C:\books\Learning\Benzene.txt';
   input ID Exposure : Exp4.;
run;

*22-17;
proc format;
   value AgeGroup (multilabel)
    0 - <20   = '0 to <20'
    20 - <40  = '20 to <40'
    40 - <60  = '40 to <60'
    60 - <80  = '60 to <80'
    80 - high = '80 +'
    0 - <50   = 'Less than 50'
    50 - high = '> or = to 50';
run;

*22-18;
title "Demonstrating a Multilabel Format";
title2 "PROC MEANS Example";
proc means data=Learn.Survey;
   class Age / MLF;
   var Salary;
   format Age AgeGroup.;
run;

*22-19;
title "Demonstrating a Multilabel Format";
title2 "PROC TABULATE Example";
proc tabulate data=Learn.Survey;
   class Age Gender / MLF;
   table Age , 
         Gender;
   format Age AgeGroup.;
run;

*22-20;
title "Demonstrating a Multilabel Format";
title2 "PROC TABULATE Example";
proc tabulate data=Learn.Survey;
   class Age Gender / MLF preloadfmt;
   table Age, 
         Gender / printmiss  misstext=' ';
   format Age AgeGroup.;
run;

*22-21;
/*** Demonstration Program
proc format;
   invalue Exp1944fmt (upcase)
     'A' = 220
     'B' = 180
     'C' = 210
     'D' = 110
     'E' = 90
   other = .;
   invalue Exp1945fmt (upcase)
     'A' = 202
     'B' = 170
     'C' = 208
     'D' = 100
     'E' = 85
   other = .;
   invalue Exp1946fmt (upcase)
     'A' = 150
      . . .
run;
***/

*22-22;
data Exposure;
   retain Type 'I' Hlo 'U';
   length Fmtname $ 10;
   do Year = 1944 to 1949;
      Fmtname = cats('Exp',Year,'fmt');
      do Start = 'A','B','C','D','E';
         End = Start;
         input Label : $3. @;
         output;
      end;
   end;
   drop Year;
datalines;
220   180   210   110   90
202   170   208   100   85
150   110   150    60   50
105    56    88    40   30
 60    30    40    20   10
 45    22    22    10    8
;
title "Creating the Exposure Format";
proc format cntlin=Exposure fmtlib;
run;

*22-23;
proc format;
   select @Exp1944fmt @Exp1945fmt;
run;

*22-24;
data Read_Exp;
   input Worker $ Year JobCode $;
   Exposure = inputn(JobCode,cats('Exp',Year,'fmt8.'));
datalines;
001 1944 B
002 1948 E
003 1947 C
005 1945 A
006 1948 d
;

*Chapter 23 Programs;

*23-1;
data Learn.ManyPer;
   set Learn.OnePer;
   array Dx{3};
   do Visit = 1 to 3;
      if missing(Dx{Visit}) then delete;
      Diagnosis = Dx{Visit};
      output;
   end;
   keep Subj Diagnosis Visit;
run;

*23-2;
proc sort data=Learn.ManyPer out=ManyPer;
   by Subj Visit;
run;
data OnePer;
   set ManyPer;
   by Subj Visit;
   array Dx{3};
   retain Dx1-Dx3;
   if first.Subj then call missing(of Dx1-Dx3);
   Dx{Visit} = Diagnosis;
   if last.Subj then output;
   keep Subj Dx1-Dx3;
run;

*23-3;
***Note: data set already in Subject order;
proc transpose data=Learn.OnePer 
               out=ManyPer;
   by Subj;
   var Dx1-Dx3;
run;

*23-4;
proc transpose data=Learn.OnePer 
               out=t_ManyPer(rename=(col1=Diagnosis)
                          drop=_Name_
                          where=(Diagnosis is not null));
   by Subj;
   var Dx1-Dx3;
run;

*23-5;
proc transpose data=Learn.ManyPer prefix=Dx
               out=OnePer(drop=_NAME_);
   by Subj;
   id Visit;
   var Diagnosis;
run;

*Chapter 24 Programs;

*24-1;
proc sort data=Learn.Clinic out=Clinic;
   by ID VisitDate;
run;
data Last;
   set clinic;
   by ID;
   put ID= VisitDate= First.ID= Last.ID=;
   if last.ID;
run;

*24-2;
data Count;
   set Clinic;
   by ID;
   *Initialize counter at first visit;
   if first.ID then N_visits = 0;
   *Increment the visit counter;
   N_visits + 1;
   *Output an observation at the last visit;
   if last.ID then output;
run;

*24-3;
proc freq data=Learn.Clinic noprint;
   tables ID / out=Counts;
run;

*24-4;
proc freq data=Clinic noprint;
   tables ID / out=Counts (rename=(count = N_Visits)
                           drop=percent);
run;
data Clinic;
   merge Learn.Clinic Counts;
   by ID;
run;

*24-5;
data Difference;
   set Clinic;
   by ID;
   *Delete patients with only one visit;
   if first.ID and last.ID then delete;
   Diff_HR = HR - lag(HR);
   Diff_SBP = SBP - lag(SBP);
   Diff_DBP = DBP - lag(DBP);
   if not first.ID then output;
run;

*24-6;
data First_Last;
   set Clinic;
   by ID;
   *Delete patients with only one visit;
   if first.ID and last.ID then delete;
   if first.ID or last.ID then do;
      Diff_HR = HR - lag(HR);
      Diff_SBP = SBP - lag(SBP);
      Diff_DBP = DBP - lag(DBP);
   end;
   if last.ID then output;
run;

*24-7;
data First_Last;
   set Clinic;
   by ID;
   *Delete patients with only one visit;
   if first.ID and last.ID then delete;
   retain First_HR First_SBP First_DBP;
   if first.ID then do;
      First_HR = HR;
      First_SBP = SBP;
      First_DBP = DBP;
   end;   
   if last.ID then do;
      Diff_HR = HR - First_HR;
      Diff_SBP = SBP - First_SBP;
      Diff_DBP = DBP - First_DBP;
      output;
   end;
   drop First_: ;
run;

*24-8;
data Hypertension;
   set Learn.Clinic;
   by ID;
   retain HighBP;
   if first.ID then HighBP = 'No ';
   if SBP gt 140 then HighBP = 'Yes';
   if last.ID then output;
run;

*Chapter 25 Programs;

*25-1;
title "The Date is &Sysdate9 - the Time is &Systime";
proc print data=Learn.Test_Scores noobs;
run;

*25-2;
%let Var_List = RBC WBC Chol;
title "Using a Macro Variable List";
proc means data=Learn.Blood n mean min max maxdec=1;
   var &Var_List;
run;

*25-3;
%let n = 3;
data Generate;
   do Subj = 1 to &n;
      x = ceil(100*rand('uniform'));
      output;
   end;
run;
title "Data Set with &n Random Numbers";
proc print data=Generate noobs;
run;

*25-4;
%macro Gen(n,Start,End);
   data Generate;
      do Subj = 1 to &n;
         x = int(rand('uniform') * (&End - &Start + 1) + &start);
         output;
      end;
   run;
   proc print data=generate noobs;
      title "Randomly Generated Data Set with &n Obs";
      title2 "Values are Integers from &Start to &End";
   run;
%mend Gen;

*25-5;
%macro Gen(n=,      /* number of random numbers */
           Start=,  /* Starting value           */
           End=     /* Ending value             */);
   /********************************************
   Example: To generate 4 random numbers from
   1 to 100 use:
   %Gen(n=4, Start=1, End=100)
   *********************************************/
   data Generate;
      do Subj = 1 to &n;
         x = int(rand('uniform') * (&End - &Start + 1) + &start);
         output;
      end;
   run;
   proc print data=Generate noobs;
      title "Randomly Generated Data Set with &n Obs";
      title2 "Values are Integers from &Start to &End";
   run;
%mend Gen;

*25-6;
%macro Print(Dsn=, /* Name of the data set to print */
             n=10  /* The number of obs to print, defaults is 10 */);
title "Listing of Data Set &Dsn";
title2 "First &n Observations";
proc print data=&Dsn(Obs=&n) noobs;
run;
%mend Print;

*25-7;
/*** Demonstration Program
%let Prefix = abc;
data &Prefix123;
   x = 3;
run;
***/

*25-8;
%let Prefix = abc;
data &prefix.123;
   x = 3;
run;

*25-9;
/*** Demonstration Program
%let libref = Learn;
proc print data=&libref.Survey;
   title "Listing of Survey";
run;
***/

*25-10;
%let libref = learn;
proc print data=&libref..survey;
   title "Listing of SURVEY";
run;

*25-11;
  proc means data=learn.Blood noprint;
     var RBC WBC;
     output out=Means mean= / autoname;
  run;
  data _null_;
     set Means;
     call symputx('AveRBC',RBC_Mean);
     call symputx('AveWBC',WBC_Mean);
  run;
  data New;
     set learn.Blood(obs=5 keep=Subject RBC WBC);
     Per_RBC = RBC / &AveRBC;
     Per_WBC = WBC / &AveWBC;
     format Per_RBC Per_WBC percent8.;
  run;

*Chapter 26 Programs;

*26-1;
title "Subjects from Health with Height > 65";
proc sql;
   select Subj,
          Height,
          Weight
   from Learn.Health
   where Height gt 65;
quit;

*26-2;
proc sql;
   select *
   from Learn.Health
   where Height gt 65;
quit;

*26-3;
proc sql;
   create table Height65 as
   select *
   from Learn.Health
   where Height gt 65;
quit;

*26-4;
title "Demonstrating a Cartesian Product";
proc sql;
   select Health.Subj,
          Demographic.Subj,
          Height,
          Weight,
          Name,
          Gender
   from Learn.Health,
        Learn.Demographic;
quit;

*26-5;
title "Renaming the Two Subj Variables";
proc sql;
   select Health.Subj as Health_Subj,
          Demographic.Subj as Demog_Subj,
          Height,
          Weight,
          Name,
          Gender
   from Learn.Health,
        Learn.Demographic;
quit;

*26-6;
title "Matching Subj Numbers from Both Tables";
proc sql;
   select H.Subj as Subj_Health,
          D.Subj as Subj_Demog,
          Height,
          Weight,
          Name,
          Gender
   from Learn.Health as H,
        Learn.Demographic as D
   where H.Subj eq D.Subj;
quit;

*26-7;
proc sort data=Learn.Health out=Health;
   by Subj;
run;
proc sort data=Learn.Demographic out=Demographic;
   by Subj;
run;
data Inner;
   merge Health(in=in_Health)
         Demographic(in=in_Demographic);
   by Subj;
   if in_Health and in_Demographic;
run;
title "Performing an Inner Join Using a DATA Step";
proc print data=Inner;
   id Subj;
run;

*26-8;
title "Demonstrating an Inner Join (Merge)";
proc sql;
   select H.Subj as Subj_Health,
          D.Subj as Subj_Demog,
          Height,
          Weight,
          Name,
          Gender
   from Learn.Health as H inner join
        Learn.Demographic as D
   on H.Subj eq D.Subj;
quit;

*26-9;
proc sql;
   title "Left Join";
   select H.Subj as Subj_Health,
          D.Subj as Subj_Demog,
          Height,
          Gender
   from Learn.Health as H left join
        Learn.demographic as D
   on H.Subj eq D.Subj;
   title "Right Join";
   select H.Subj as Subj_Health,
          D.Subj as Subj_Demog,
          Height,
          Gender
   from Learn.Health as H right join
        Learn.demographic as D
   on H.Subj eq D.Subj;
   title "Full Join";
   select H.Subj as Subj_Health,
          D.Subj as Subj_Demog,
          Height,
          Gender
   from Learn.health as H full join
        Learn.demographic as D
   on H.Subj eq D.Subj;
quit;

*26-10;
/*** Demonstration Program
proc sql;
   create table Complete_List as
   select *
   from Learn.Demographic union all corresponding
   select *
   from Learn.New_Members
quit;
***/

*26-11;
proc sql;
   select Subj,
          Height,
          Weight,
          mean(Height) as Ave_Height,
          100*Height/calculated Ave_Height as
             Percent_Height
   from Learn.Health
quit;

*26-12;
title "Listing in Height Order";
proc sql;
   select Subj,
          Height,
          Weight
   from Learn.Health
   order by Height;
quit;

*26-13;
title "Example of a Fuzzy Match";
proc sql;
   select Subj, 
          Demographic.Name,
          Insurance.Name
   from Learn.Demographic,
        Learn.Insurance
   where spedis(Demographic.Name,Insurance.Name) le 25;
quit;

*Chapter 27 Programs;

*27-1;
title "Checking Social Security Numbers Using a Regular Expression";
data _null_;
   file print;
   input SS $11.;
   if not prxmatch("/\d\d\d-\d\d-\d\d\d\d/",SS) then
      put "Error for SS Number " SS;
datalines;
123-45-6789
123456789
123-ab-9876
999-888-7777
;

*27-2;
title "Testing the Regular Expression for US ZIP Codes";
data _null_;
   file print;
   input Zip $10.;
  if not prxmatch("/\d{5}(-\d{4})?/",Zip) then 
      put "Invalid ZIP Code " Zip;
datalines;
12345
78010-5049
12Z44
ABCDE
08822
;

*27-3;
title "Checking that Phone Numbers are in Standard Form";
data _null_;
   file print;
   input Phone $13.;
  if not prxmatch("/\(\d\d\d\)\d\d\d-\d\d\d\d/",Phone) then 
      put "Invalid Phone Number " Phone;
datalines;
(908)432-1234
800.343.1234
8882324444
(888)456-1324
;

*27-4;
data Standard;
   length Standard $ 13; 
   input Phone $13.;
   Digits = compress(Phone,,'kd');
   Standard = cats('(',substr(Digits,1,3),')',substr(Digits,4,3),
                   '-',substr(Digits,7,4));
   drop Digits;
datalines;
(908)432-1234
800.343.1234
8882324444
(888)456-1324
;

*27-5;
title "Checking Social Security Numbers Using a Regular Expression";
title2 "Using a Combination of PRXPARSE and PRXMATCH Functions";
data _null_;
   file print;
   input SS $11.;
   Return_Code = prxparse("/\d\d\d-\d\d-\d\d\d\d/");
   if not prxmatch(Return_Code,SS) then
      put "Error for SS Number " SS;
datalines;
123-45-6789
123456789
123-ab-9876
999-888-7777
;

*27-6;
title "Checking Social Security Numbers Using a Regular Expression";
title2 "Using a Combination of PRXPARSE and PRXMATCH Functions";
data _null_;
   file print;
   input SS $11.;
   retain Return_Code;
   if _n_ = 1 then
      Return_Code = prxparse("/\d\d\d-\d\d-\d\d\d\d/");
   if not prxmatch(Return_Code,SS) then
      put "Error for SS Number " SS;
datalines;
123-45-6789
123456789
123-ab-9876
999-888-7777
;








