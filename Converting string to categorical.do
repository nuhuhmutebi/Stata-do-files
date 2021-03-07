clear
set more off

*setting a working directory
cd "C:\Users\Pc\Desktop\DAITS\Module 3"

*loading dataset
use "hsb2_mar.dta", clear

* Describing our dataset
d

* GENERATING INDICATOR VARIABLES
*Generating an indicator variable mathscore with categories below (<50) and above average (<=50) where below 
gen mathscore = (math > 50) // this would work best if math variable had no missing values
tab mathscore
bro math mathscore

gen mathscore1 = (math > 50) if math != . // this addresses the issue of the mising values
tab mathscore1,miss

//generate normally the replace those that origibally had missing values with missing
gen mathscore2 = (math > 50)
replace mathscore2 = . if math == .
tab mathscore2,miss

*Generating variables with recode and generate commands
recode math min/50=0 51/max=1, gen(mathscore3)
bro mathscore1-mathscore3 math
tab mathscore3,miss

// testing if all variables are the same, this implies mathscore1 = mathscore2 = mathscore3
count if mathscore1 != mathscore2 | mathscore1 != mathscore3 | mathscore2 != mathscore3
*alternatively
count if mathscore1 != mathscore2 
count if mathscore1 != mathscore3
count if mathscore2 != mathscore3

*FACTOR VARIABLES WITH MULTIPLE CATEGORIES
*Creating mathcat with five categories of 30-39, 40-49, 50-59, 60-69, 70-79 from math variable
*1. 
recode math 30/39=1 40/49=2 50/59=3 60/69=4 70/79=5, gen(mathcat)
*2. 
gen mathcat1 = recode(math, 39, 49, 59, 69, 79)
tab mathcat1
* to convert the above into codes of 1-5 we create mathcat2 with the command below
egen mathcat2 = group(mathcat1)
tab mathcat2

*Creating categories of multiple intervals
egen mathcat3 = cut(math), group(5)
tab mathcat3

//For more information
help generate
help replace
help recode
