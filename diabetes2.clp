(import nrc.fuzzy.*)

(import nrc.fuzz.jess.*)

(load-package nrc.fuzzy.jess.FuzzyFunctions)

(deftemplate patient
    (slot name)
    (slot weight (type INTEGER))
    (slot height (type INTEGER))
)

(deftemplate bmi
    "Auto-generated"
	(declare (ordered TRUE)))

(deftemplate sleep
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate bp_sys
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate bp_dias
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate workout
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate stress-level
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate heart-risk
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate sugar-level
    (slot level (type INTEGER))
)

(deftemplate diabeticCondition
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate water_intake
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate cal_intake
    "Auto-generated"
    (declare (ordered TRUE)))

(defglobal ?*bmiVar* = (new FuzzyVariable "bmi" 5 50))

(defglobal ?*sleepVar* = (new FuzzyVariable "sleep" 2 10 "Hours"))

(defglobal ?*bloodPressSVar* = (new FuzzyVariable "bloodPressDias" 0 190))

(defglobal ?*bloodPressDVar* = (new FuzzyVariable "bloodPressSys" 0 190))

(defglobal ?*workoutVar* = (new FuzzyVariable "workoutHours" 0 2))

(defglobal ?*stressVar* = (new FuzzyVariable "stressLevels" 0 10))

(defglobal ?*heartVar* = (new FuzzyVariable "heartRisk" 0 3))

(defglobal ?*diabVar* = (new FuzzyVariable "diabetesLevels" 30 200))

(defglobal ?*waterVar* = (new FuzzyVariable "WaterIntakeLevel" 0 500))

(defglobal ?*calVar* = (new FuzzyVariable "CalorieIntakeLevel" 500 2000))

(call nrc.fuzzy.FuzzyValue setMatchThreshold 0.2)

; Initialize Global Variables
(defrule MAIN::init-FuzzyVariables
    (declare (salience 100))
    (initial-fact)
    =>
    (bind ?xunder (create$ 10 15 20))
    (bind ?yunder (create$ 1 1 0))
    (call ?*bmiVar* addTerm "underweight" ?xunder ?yunder 3)
    
    (bind ?xover (create$ 24 30))
    (bind ?yover (create$ 0 1))
    (call ?*bmiVar* addTerm "overweight" ?xover ?yover 2)
    
    (call ?*bmiVar* addTerm "normal" "not underweight and (not overweight)")
    
    (bind ?Sxlow (create$ 70 85 95))
    (bind ?Sylow (create$ 1 1 0))
    (call ?*bloodPressSVar* addTerm "low" ?Sxlow ?Sylow 3)
    
    (bind ?Dxlow (create$ 40 55 65))
    (bind ?Dylow (create$ 1 1 0))
    (call ?*bloodPressDVar* addTerm "low" ?Dxlow ?Dylow 3)
    
    (bind ?Sxhigh (create$ 115 130))
    (bind ?Syhigh (create$ 1 0))
    (call ?*bloodPressSVar* addTerm "hypertension" ?Sxhigh ?Syhigh 2)
    
    (bind ?Dxhigh (create$ 75 105))
    (bind ?Dyhigh (create$ 1 0))
    (call ?*bloodPressDVar* addTerm "hypertension" ?Dxhigh ?Dyhigh 2)
    
    (call ?*bloodPressSVar* addTerm "ideal" "not low and (not hypertension)")
    (call ?*bloodPressDVar* addTerm "ideal" "not low and (not hypertension)")
    
    (bind ?Pxsleep (create$ 0 4 6))
    (bind ?Pysleep (create$ 1 1 0))
    (call ?*sleepVar* addTerm "poor" ?Pxsleep ?Pysleep 3)
    
    (bind ?Nxsleep (create$ 6 8 10))
    (bind ?Nysleep (create$ 0 1 0))
    (call ?*sleepVar* addTerm "normal" ?Nxsleep ?Nysleep 3)
    
    (bind ?wLowx (create$ 0 1))
    (bind ?wLowy (create$ 1 0))
    (call ?*workoutVar* addTerm "light" ?wLowx ?wLowy 2)
    
    (bind ?wModx (create$ 0.5 1 2))
    (bind ?wMody (create$ 0 1 0))
    (call ?*workoutVar* addTerm "moderate" ?wModx ?wMody 3)
    
    (bind ?wIntx (create$ 0 1))
    (bind ?wInty (create$ 1 0))
    (call ?*workoutVar* addTerm "intense" ?wIntx ?wInty 2)
    
    (bind ?sx (create$ 0 5 10))
    (bind ?sy (create$ 1 1 0))
    (call ?*stressVar* addTerm "high" ?sx ?sy 3)
    
    (bind ?sx (create$ 0 5 10))
    (bind ?sy (create$ 0 0 1))
    (call ?*stressVar* addTerm "normal" ?sx ?sy 3)
    
    (bind ?cxm (create$ 0 1 2))
    (bind ?cym (create$ 0 1 0))
    (call ?*heartVar* addTerm "moderate" ?cxm ?cym 2)
    
    (bind ?cxh (create$ 2 3))
    (bind ?cyh (create$ 0 1))
    (call ?*heartVar* addTerm "high" ?cxm ?cym 2)
    
    (bind ?diabLowx (create$ 30 60 80))
    (bind ?diabLowy (create$ 1 1 0))
    (call ?*diabVar* addTerm "low" ?diabLowx ?diabLowy 3)
    
    (bind ?diabModx (create$ 93 99 105))
    (bind ?diabMody (create$ 0 1 0))
    (call ?*diabVar* addTerm "normal" ?diabModx ?diabMody 3)
    
    (bind ?diabHighx (create$ 105 125))
    (bind ?diabHighy (create$ 0 1))
    (call ?*diabVar* addTerm "high" ?diabHighx ?diabHighy 2)
    
)

; Initialize the patient details ******Change the test cases here********
(defrule init
    (declare (salience 50))
=>
    ; change assert statement here, try forming an interactive prompt
    (assert (patient (name Allen)(height 1.5266)(weight 50))) ; 
    (assert (sleep (new nrc.fuzzy.FuzzyValue ?*sleepVar* "normal")))
    (assert (bp_sys (new nrc.fuzzy.FuzzyValue ?*bloodPressSVar* "ideal")))
    (assert (bp_dias (new nrc.fuzzy.FuzzyValue ?*bloodPressDVar* "hypertension")))
    (assert (sugar-level (level 70)))    
)

; Compute the BMI and fuzzify the outputs
(defrule fuzzify_bmi 
	?p <- (patient (name ?name))
    =>
    (bind ?bm (/ ?p.weight (* ?p.height ?p.height))) 
    (printout t "Your calculated BMI is  " ?bm crlf)
    (assert (bmi (new nrc.fuzzy.FuzzyValue ?*bmiVar* (new SingletonFuzzySet ?bm))))
)

; Recommend workout based on the BMI, moderate for normal people
(defrule mod_workout_required
	(bmi ?p&:(fuzzy-match ?p "normal"))
     =>
    (printout t "Based on your diabetes risk and BMI you need to do a NORMAL WORKOUT as well." crlf)
	(assert (workout (new nrc.fuzzy.FuzzyValue ?*workoutVar* "moderate")))  
)	

; Recommend workout based on the BMI, intense for obese people
(defrule extrm_workout_required
	(bmi ?p&:(fuzzy-match ?p "overweight"))
     =>
    (printout t "Based on your diabetes risk and BMI you need to do an INTENSE WORKOUT as well." crlf)
	(assert (workout (new nrc.fuzzy.FuzzyValue ?*workoutVar* "intense")))  
)

; Compute the stress levels on the basis of poor sleep patterns and hyper tension
(defrule stress_lvls_high
    (sleep ?ps&:(fuzzy-match ?ps "poor"))
    (bp_sys ?pbp1&:(fuzzy-match ?pbp1 "more_or_less hypertension"))
    (bp_dias ?pbp2&:(fuzzy-match ?pbp2 "hypertension"))
    =>
	(assert (stress-level (new nrc.fuzzy.FuzzyValue ?*stressVar* "high")))
    (printout t "With your poor sleeping pattens and hypertension ")
    (printout t "you are diagnosed with VERY HIGH STRESS." crlf) 
    (printout t "Your stress is to the degree of " (fuzzy-rule-similarity) crlf)
)


(defrule heart_risks_high
	(stress-level ?s&:(fuzzy-match ?s "high"))
	(bmi ?p&: (fuzzy-match ?p "extremely overweight"))
    =>
    (assert (heart-risk (new nrc.fuzzy.FuzzyValue ?*heartVar* "extremely high"))) 
    (printout t "With very high stress and obesity there are HIGH CHANCES OF HEART ATTACK due to narrowing of coronary arteries." crlf)   	    	
)

; High risk implies higher chances of heart attack
(defrule heart_risks_mod
	(stress-level ?s&:(fuzzy-match ?s "more_or_less high"))
    (bmi ?p&: (fuzzy-match ?p "not overweight"))
    =>
    (assert (heart-risk (new nrc.fuzzy.FuzzyValue ?*heartVar* "moderate"))) 
    (printout t "With more or less high stress there are MODERATE CHANCES OF HEART ATTACK due to narrowing of coronary arteries." crlf)  	    	
)


; Compute the chances of diabetes based on sugar levels
(defrule diabetes_chck
	?s <- (sugar-level (level ?lvl))  
    =>
    (if (< ?s.level 70) then
        (assert (diabeticCondition (new nrc.fuzzy.FuzzyValue ?*diabVar* "low")))
        (printout t "You have LOW RISK OF DIABETES." crlf)
     else (if (< ?s.level 99) then
            (assert (diabeticCondition (new nrc.fuzzy.FuzzyValue ?*diabVar* "normal")))
            (printout t "You have VERY LOW/NO RISK OF DIABETES." crlf)
            else (if (< ?s.level 125) then
                (assert (diabeticCondition (new nrc.fuzzy.FuzzyValue ?*diabVar* "high")))
                (printout t "You have HIGH RISK OF DIABETES." crlf)
                else 
                (assert (diabeticCondition (new nrc.fuzzy.FuzzyValue ?*diabVar* "extremely high")))
                (printout t "You have EXTREMELY HIGH RISK OF DIABETES." crlf))
            ))
)


; In case of high risk of heart attack and diabetes, call for immediate attention
(defrule disImmediateDiagnosisHeartCondn
    (diabeticCondition ?d&:(fuzzy-match ?d "high"))
	(heart-risk ?c&:(fuzzy-match ?c "extremely high"))
    =>
    (printout t "With such high chances of both diabetes and heart attack" crlf)
    (printout t "I recommend you to CONSULT A DOCTOR IMMEDIATELY in order to get a proper medication if required." crlf crlf)    
)

(printout t "********WELCOME**********" crlf)
(printout t "Welcome to the Diabetes Risk Evaluation Engine!" crlf)
(printout t "Please enter your name and press Enter>:: " crlf)
(bind ?name(read))
(printout t "Let us begin the Diabetes Risk evaluation for " ?name "." crlf)
(reset)
(bind ?numrules (run))
;(printout t crlf)

