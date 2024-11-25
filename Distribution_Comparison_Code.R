
library(ggplot2)
library(dplyr)
library(reshape)
library(car)

data<- read.csv("/Users/purvanshisharma/Desktop/ICS/babies.csv")
data.df <- as.data.frame(data)
dataNA <- data.df[rowSums(is.na(data.df)) > 0,]

#Remove missing value and unknown smoke
for(i in 1:ncol(data.df)){
  data[i][is.na(data[i])] <- round(mean(data.df[i], na.rm = TRUE))
}

data.df <- data.df[!(data.df$smoke == "9"), ]

str(data.df)

#Question 1(Five number Summary for child's weight)
never_smoke <- data.df[which(data.df$smoke == 0),]
now_smoke <- data.df[which(data.df$smoke == 1),]
until_preg_smoke <- data.df[which(data.df$smoke == 2),]
once_smoke <- data.df[which(data.df$smoke == 3),]

summ_ns=round(summary(never_smoke$wt),2)
summ_now_s=round(summary(now_smoke$wt),2)
summ_up=round(summary(until_preg_smoke$wt),2)
summ_o=round(summary(once_smoke$wt),2)

summ_all= list(summ_ns,summ_now_s,summ_up,summ_o)
df_summ <- data.frame(matrix(unlist(summ_all), nrow=length(summ_all), byrow=TRUE))

variables_ <- c("Child's weight if the mother never smoked", "Child's weight if the mother smokes now",
                "Child's weight if the mother smoked until current pregnancy","Child's weight if the mother has smoked once")
df_summ  <- data.frame(variables_, df_summ)
colnames(df_summ) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                       "3rd Qu","Max")
#added

# comparison reasons: (add the deep purple in the legend)
hist(never_smoke$wt, main = "Child's weight according to mother's smoking habits",
     col = rgb(1, 0, 0, 0.5),
     xlim = c(50, 180),
     ylim = c(0, 150))

hist(now_smoke$wt,
     col = rgb(0, 1, 0, 0.5),
     add = TRUE)
hist(until_preg_smoke$wt,
     col = rgb(0, 0, 1, 0.5),
     add = TRUE)
hist(once_smoke$wt,
     col = rgb(1, 0, 1, 0.5),
     add = TRUE)

legend('topright', c('Never', 'Current', 'Until_pregancy','Once'),
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 1, 0, 0.5),rgb(0,0,1,0.5), rgb(1,0,1,0.5), rgb(146, 90, 204, maxColorValue = 255)))

#Mother smokes or not
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
mother_smokes <- getmode(data.df$smoke)
mother_smokes#what are the smoking habits of nost women.
#Descriptive analyasis of mother's smoking habits
# frequency for categorical variables
frequency_smoke <- data.df %>% count(data.df$smoke)
frequency_smoke
# Description using graphical methods: Histograms
smoke_Factor <- as.factor(data.df$smoke)

smoke_bar <- barplot(table(smoke_Factor), 
                 main="Frequncy of the smoking habits of women", 
                 xlab="Kind of smokers",ylab= 'Count',density = 10, col='red')
##Question 2
####For calculating normality
# never group does not follow normality
shapiro.test(never_smoke$wt)
shapiro.test(now_smoke$wt)
shapiro.test(until_preg_smoke$wt)
shapiro.test(once_smoke$wt)
boxplot(data.df$wt ~ data.df$smoke, xlab = 'Smoking habits of woman',ylab = "Weight of the child correspondinfg to the mother's smoking habits")
# graphical representation
ns <- qqnorm(never_smoke$wt)
qqline(never_smoke$wt, col = 'red', lwd = 2, lty = 2 )

now_s <- qqnorm(now_smoke$wt)
qqline(now_smoke$wt, col = 'red', lwd = 2, lty = 2)

up <- qqnorm(until_preg_smoke$wt)
qqline(until_preg_smoke$wt, col = 'red', lwd = 2, lty = 2)

once <- qqnorm(once_smoke$wt)
qqline(once_smoke$wt, col = 'red', lwd = 2, lty = 2)



# (p < 0.05), so it appears that the type of smoke used has a real impact on the final baby weight
one.way <- aov(wt~as.factor(smoke), data=data.df,projections = TRUE,qr = TRUE,
               contrasts = NULL)
summary(one.way)
# p value 0.104867 which is greater than 0.05  So, we do not reject the null hypothesis. variances are same
leveneTest(data.df$wt, data.df$smoke) 

##Question 3 and Question 4
#pairwise difference if less then 0,05 the significant otherwise not significant



non_adjusted_test <- pairwise.t.test(data.df$wt, data.df$smoke, p.adjust.method = "none")
pairwise_test_adjusted <- pairwise.t.test(data.df$wt,data.df$smoke,pool.sd = TRUE, p.adjust.method ='bonferroni')


#Tukey's HSD test
tukey.test <- TukeyHSD(one.way)

#Tukey's HSD test results
print(tukey.test)
print(non_adjusted_test)
print(pairwise_test_adjusted)
plot(tukey.test)

