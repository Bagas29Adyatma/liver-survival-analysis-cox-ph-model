library(survival)
library(ggsurvfit)
library(tidycmprsk)
library(KMsurv)
library(flexsurv)
library(tidyverse)
library(dplyr)
library(DMwR2)

df <- read.csv("C:/Users/bagas/OneDrive/Documents/Kuliah/Akademik/Semester 7/Pengantar Ansur/FP Ansur/Liver.csv")
df <- subset(df, select = -c(case.id))
colnames(df)[3]="gender"
colnames(df)
df$weight <- round(df$weight, 2)
df

# Define survival time
y <- Surv(df$futime,df$status==1)

# KM curves
plot(survfit(y ~ 1),
     xlab = "Survival Time (Months)",
     ylab = "Survival Probabilities")
survfit(y ~ 1) %>%
  ggsurvfit() +
  labs(
    x = "Months",
    y = "Overall survival probability") +
  add_confidence_interval()

# KM Curves based on Age
agegrup <- ifelse(df$age >= 52, "Above 52", "Below 52")
plot(survfit(y ~ agegrup), lty = c("solid", "dashed"),
     xlab = "Survival Time (Months)", ylab = "Survival Probabilities")
legend("topright", c("Above 62", "Below 62"), lty = c("solid", "dashed"))
survfit(y ~ agegrup) %>%
  ggsurvfit() +
  labs(
    x = "Months",
    y = "Overall survival probability") +
  add_confidence_interval()

# KM Curves based on bmi
bmigrup <- ifelse(df$bmi >= 30, "Above 30", "Below 30")
plot(survfit(y ~ bmigrup), lty = c("solid", "dashed"),
     xlab = "Survival Time (Months)", ylab = "Survival Probabilities")
legend("topright", c("Above 30", "Below 30"), lty = c("solid", "dashed"))
survfit(y ~ bmigrup) %>%
  ggsurvfit() +
  labs(
    x = "Months",
    y = "Overall survival probability") +
  add_confidence_interval()

# KM Curves based on weight
plot(survfit(y ~ weightgrup), lty = c("solid", "dashed"),
     xlab = "Survival Time (Months)", ylab = "Survival Probabilities")
legend("topright", c("Above 86,1", "Below 86,1"), lty = c("solid", "dashed"))
survfit(y ~ weightgrup) %>%
  ggsurvfit() +
  labs(
    x = "Months",
    y = "Overall survival probability") +
  add_confidence_interval()

# KM Curves based on height
plot(survfit(y ~ heightgrup), lty = c("solid", "dashed"),
     xlab = "Survival Time (Months)", ylab = "Survival Probabilities")
legend("topright", c("Above 169,4", "Below  169,4"), lty = c("solid", "dashed"))
survfit(y ~ heightgrup) %>%
  ggsurvfit() +
  labs(
    x = "Months",
    y = "Overall survival probability") +
  add_confidence_interval()

# Log-Rank Test
survdiff(y ~ agegrup)
survdiff(y ~ bmigrup)
survdiff(y ~ weightgrup)
survdiff(y ~ heightgrup)

# 95% CI
survfit(y ~ agegrup)
survfit(y ~ bmigrup)

#Cox PH
model1 <- coxph(y~age+gender+weight+height, data=df)
model1
# GOF Test for Model 1 (Tanpa Interaksi)
gof1 <- cox.zph(model1)
gof1

# Log-Log Graph and Observed vs Expected based on Age
kmfit1 <-  survfit(y ~ agegrup)
plot(kmfit1,fun="cloglog",xlab="time in month using logarithmic
     scale",ylab="log-log survival", main="log-log curves by Age",lty = c("solid", "dashed"),
     col=c("black","blue"))
legend("topleft", c("Above 52", "Below 52"), lty = c("solid", "dashed"))

plot(kmfit1,
     main = "Observed vs Expected Survival Probability for Age",
     xlab = "Time (day)", ylab = "Survival Probability",
     lty = 1, col = c("black", "blue")
)

log_km_fit1 <- coxph(formula = y ~ agegrup, data = df)
age1 <- data.frame(agegrup = 1:2)
lines(survfit(log_km_fit1, age1), col = c("black", "blue"),lty = 2)
legend("topright", legend = c("Above 52 (Obs)","Above 52 (Eks)","Below 52 (Obs)","Below 52 (Eks)"), 
       col = c("black","black","blue","blue"), lty =c(1,2,1,2), title = "Age")

# Log-Log Graph and Observed vs Expected based on gender
kmfit2 <-  survfit(y ~ df$gender)
plot(kmfit2,fun="cloglog",xlab="time in month using logarithmic
     scale",ylab="log-log survival", main="log-log curves by Gender",lty = c("solid", "dashed"),
     col=c("black","blue"))
legend("topleft", c("Female", "Male"), lty = c("solid", "dashed"))

plot(kmfit2,
     main = "Observed vs Expected Survival Probability for Gender",
     xlab = "Time (day)", ylab = "Survival Probability",
     lty = 1, col = c("black", "blue")
)
log_km_fit2 <- coxph(formula = y ~ df$gender, data = df)
ge1 <- data.frame(gender = 0:1)
lines(survfit(log_km_fit2, ge1), col = c("black", "blue"),lty = 2)
legend("bottomright", legend = c("0 (Obs)","0 (Eks)","1 (Obs)","1 (Eks)"), 
       col = c("black","black","blue","blue"), lty =c(1,2,1,2), title = "Gender")

# Log-Log Graph and Observed vs Expected based on Weight
weightgrup <- ifelse(df$weight >= 86.1,"1", "0")
kmfit3 <-  survfit(y ~ weightgrup)
plot(kmfit3,fun="cloglog",xlab="time in month using logarithmic
     scale",ylab="log-log survival", main="log-log curves by Weight",lty = c("solid", "dashed"),
     col=c("black","blue"))
legend("topleft", c("Below 86", "Above 86"), lty = c("solid", "dashed"))

plot(kmfit3,
     main = "Observed vs Expected Survival Probability for Weight",
     xlab = "Time (day)", ylab = "Survival Probability",
     lty = 1, col = c("black", "blue")
)
log_km_fit3 <- coxph(formula = y ~ weightgrup, data = df)
fg1 <- data.frame(weightgrup = 0:1)
lines(survfit(log_km_fit3, fg1), col = c("black", "blue"),lty = 2)
legend("bottomright", legend = c("0 (Obs)","0 (Eks)","1 (Obs)","1 (Eks)"), 
       col = c("black","black","blue","blue"), lty =c(1,2,1,2), title = "Weight")

# Log-Log Graph and Observed vs Expected based on height
heightgrup <- ifelse(df$height >= 169.4, "1", "0")
kmfit4 <-  survfit(y ~ heightgrup)
plot(kmfit4,fun="cloglog",xlab="time in month using logarithmic
     scale",ylab="log-log survival", main="log-log curves by height",lty = c("solid", "dashed"),
     col=c("black","blue"))
legend("topleft", c("Above 169,4", "Below 169,4"), lty = c("solid", "dashed"))

plot(kmfit4,
     main = "Observed vs Expected Survival Probability for Height",
     xlab = "Time (day)", ylab = "Survival Probability",
     lty = 1, col = c("black", "blue")
)
log_km_fit4 <- coxph(formula = y ~ heightgrup, data = df)
ep1 <- data.frame(heightgrup = 0:1)
lines(survfit(log_km_fit4, ep1), col = c("black", "blue"),lty = 2)
legend("bottomright", legend = c("0 (Obs)","0 (Eks)","1 (Obs)","1 (Eks)"), 
       col = c("black","black","blue","blue"), lty =c(1,2,1,2), title = "epss")

#Cox PH
model1 <- coxph(y~age+gender+weight+height, data=df)

#Model Stratified - No interaction
model_stra1 = coxph(y~age+gender+height+strata(weight), data=df)
model_stra1
summary(model_stra1)


#Model Stratified - interaction
model_stra_interaction1 <- coxph(y ~ age + gender + height + age * strata(weightgrup) + gender * strata(weightgrup) + height * strata(weightgrup), data=df)
model_stra_interaction1

model_stra_interaction2 <- coxph(y ~ age + gender + height + age * strata(weightgrup) + gender * strata(weightgrup), data=df)
model_stra_interaction2
summary(model_stra_interaction2)


LR <- -2*(model_stra1$loglik[2]-model_stra_interaction2$loglik[2])
LR
chisqtab <- qchisq(0.95,2)
chisqtab
pchisq(-2,2)
# KEPUTUSAN
if(LR > chisqtab){
  print("Tolak H0")
  print("Model Dengan Interaksi Lebih Tepat")
}else{
  print("Gagal Tolak H0")
  print("Model Tanpa Interaksi Lebih Tepat")
}

#Model Terbaik
model_stra1 = coxph(y~age+gender+height+strata(weight), data=df)
model_stra1
summary(model_stra1)
