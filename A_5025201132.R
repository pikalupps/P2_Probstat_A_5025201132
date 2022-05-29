install.packages("BSDA")
library(BSDA)

#Nomor 1
orang.ke = c(seq(1:9))
kso.sebelum = c(78,75,67,77,70,72,78,74,77)
kso.sesudah = c(100,95,70,90,90,90,89,90,100)
data = data.frame(orang.ke, kso.sebelum, kso.sesudah)

#1.a
sd = sd(data$kso.sesudah-data$kso.sebelum)
sd

#1.b
t.test(data$kso.sesudah, data$kso.sebelum, paired = TRUE)

#1.c
t.test(data$kso.sesudah, data$kso.sebelum, paired = TRUE, 
       alternative = "two.sided", conf.level = 0.95)


#Nomor 2
zsum.test(mean.x=23500, sigma.x = 3900, n.x = 100,  
          alternative = "greater", mu = 20000)

#Nomor 3
#3.b
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y =2.79 , s.y = 1.32,
          n.y = 27, alternative = "two.sided", 
          mu = 0, var.equal = TRUE,
          conf.level = 0.95)

#3.c
install.packages("mosaic")
library(mosaic)

plotDist(dist = 't', df = 2)

#3.d
qchisq(p = 0.05, df = 2, lower.tail = FALSE)

#Nomor 4
my_data <- read.table("data_no4.txt", h = T)
attach(my_data)
names(my_data)

my_data$Group = as.factor(my_data$Group)
my_data$Group = factor(my_data$Group,labels = c("kucing oren", "kucing hitam", "kucing putih"))

class(my_data$Group)

Group1 = subset(my_data, Group == "kucing oren")
Group2 = subset(my_data, Group == "kucing hitam")
Group3 = subset(my_data, Group == "kucing putih")

#4.a
qqnorm(Group1$Length)
qqline(Group1$Length)

qqnorm(Group2$Length)
qqline(Group2$Length)

qqnorm(Group3$Length)
qqline(Group3$Length)

#4.b
bartlett.test(Length ~ Group, data = my_data)

#4.c
model1 = lm(Length ~ Group, data = my_data)

#4.d
anova(model1)

#4.e
TukeyHSD(aov(model1))

#4.f
install.packages("ggplot2")
library("ggplot2")

ggplot(my_data, aes(x = Group, y = Length)) +
  geom_boxplot(fill = "lightblue", colour = "black") +
  scale_x_discrete() + xlab("spesies") +
  ylab("panjang")

#Nomor 5
#5.a
install.packages("multcompView")
library(readr)
library(ggplot2)
library(multcompView)
library(dplyr)

my.data <- read_csv("data_no5.csv")

qplot(x = Temp, y = Light, geom = "point", data = my.data) + facet_grid(.~Glass, labeller = label_both)

#5.b
my.data$Glass <- as.factor(my.data$Glass)
my.data$Temp_Factor <- as.factor(my.data$Temp)

anova <- aov(Light ~ Glass*Temp_Factor, data = my.data)
summary(anova)

#5.c
data.sum <- group_by(my.data, Glass, Temp) %>%
  summarise(mean = mean(Light), sd = sd(Light)) %>%
  arrange(desc(mean))

print(data.sum)

#5.d
TukeyHSD(anova)

#5.e
tukey.cld <- multcompLetters4(anova, tukey)
print(tukey.cld)

cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
data.sum$Tukey <- cld$Letters
print(data.sum)

write.csv("GTL_sum.csv")
