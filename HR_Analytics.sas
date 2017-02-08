/* Code to upload the data file*/

PROC IMPORT OUT= WORK.HR 
            DATAFILE= "\\vmware-host\Shared Folders\Downloads\HR_training_new.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES; 
RUN;




/* Created two variables for categoring the salary as Low, Medium and High*/
data HR_ds;
set HR;
if salary= "medium" then Sal1=1;
	else Sal1=0; 

if salary= "high" then Sal2=1;
else  Sal2=0;
run;

/* Ran Univariate for finding the descriptive statistics of each independent variable*/ 
proc univariate data= HR_ds;
VAR last_evaluation satisfaction_level  number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years;
							
RUN;


/* frequency of left variable by department */
proc freq data = Hr_ds;
tables sales*left/ NOROW NOCOL;
run;



/*box plot for numerical variables */
proc sgplot data = Hr_ds;
vbox satisfaction_level;
run;

proc sgplot data = Hr_ds;
vbox last_evaluation;
run;

proc sgplot data = Hr_ds;
vbox number_project;
run;

proc sgplot data = Hr_ds;
vbox average_montly_hours;
run;

proc sgplot data = Hr_ds;
vbox time_spend_company;
run;

/* histogram for time_spend_company */
proc sgplot data = Hr_ds;
histogram time_spend_company;
density time_spend_company;
run;

/* Ran Logistic Regression on all the variables*/

proc logistic data=HR_ds plots=ALL descending;

model left= satisfaction_level  last_evaluation  number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Code block to find correlation matrix*/
proc corr data=Hr_ds;

VAR  left satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2 ;
							
run;

/* Code block for running logistic regression after removing two variables last_evaluation,number_project*/
proc logistic data=HR_ds plots=ALL descending; 

model left= satisfaction_level  average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Code block for Dividing the dataset by departments*/

data HR_Sales;
set Hr_ds;
if sales = "sales" then output;

RUN;



data HR_HumanResources;
set Hr_ds;
if sales = "hr" then output;

RUN;

data HR_Accounts;
set Hr_ds;
if sales = "accounting" then output;

RUN;
data HR_Support;
set Hr_ds;
if sales = "support" then output;

RUN;
data HR_Technical;
set Hr_ds;
if sales = "technical" then output;

RUN;
data HR_Management;
set Hr_ds;
if sales = "management" then output;

RUN;
data HR_IT;
set Hr_ds;
if sales = "IT" then output;

RUN;
data HR_Production;
set Hr_ds;
if sales = "product_mng" then output;

RUN;
data HR_Marketing;
set Hr_ds;
if sales = "marketing" then output;

RUN;
data HR_RnD;
set Hr_ds;
if sales = "RandD" then output;

RUN;

/* Logistic regression for Sales Department*/
proc logistic data=HR_Sales descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for HR Department*/
proc logistic data=HR_HumanResources descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for Accounts Department*/
proc logistic data=HR_Accounts descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;
/* Logistic regression for Support Department*/
proc logistic data=HR_Support descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for Technical Department*/
proc logistic data=HR_Technical descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for Management Department*/
proc logistic data=HR_Management descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for Production Department*/
proc logistic data=HR_Production descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for Marketing Department*/
proc logistic data=HR_Marketing descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;

/* Logistic regression for RnD Department*/
proc logistic data=HR_RnD descending;
model left= satisfaction_level last_evaluation number_project average_montly_hours time_spend_company
 							work_accident  promotion_last_5years Sal1 Sal2;
run;


