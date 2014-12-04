qdata <- read.csv("D:/test/data.csv")
#####
# remove NA Cols
# remove useless questionnaires
# questionnaire coding
#####
# remove useless questionnaires
nrow(qdata)
qdata <- qdata[which(!is.na(qdata$C2.34)),]
qdata <- qdata[which(!is.na(qdata$C2.35)),]
qdata <- qdata[which(!is.na(qdata$C2.36)),]
qdata <- qdata[which(!is.na(qdata$C2.37)),]
qdata <- qdata[which(!is.na(qdata$C2.38)),]
qdata <- qdata[which(!is.na(qdata$C2.39)),]
qdata <- qdata[which(!is.na(qdata$C2.40)),]
nrow(qdata)
# questionnaire coding
data <- data.frame(C2.34=qdata$C2.34,
                   C2.35_1=0,C2.35_2=0,C2.35_3=0,C2.35_88=0,
                   C2.36_1=0,C2.36_2=0,C2.36_3=0,C2.36_4=0,
                   C2.37=qdata$C2.37,
                   C2.38=qdata$C2.38,
                   C2.39=qdata$C2.39,
                   C2.40_1=0,C2.40_2=0,C2.40_3=0,C2.40_88=0)
for(i in 1:nrow(qdata)){
  # C2.35
  C2.35_N <- strsplit(as.character(qdata$C2.35[i]),',')[[1]]
  if("1"%in%C2.35_N){data$C2.35_1[i] = 1}
  if("2"%in%C2.35_N){data$C2.35_2[i] = 1}
  if("3"%in%C2.35_N){data$C2.35_3[i] = 1}
  if("88"%in%C2.35_N){data$C2.35_88[i] = 1}
  # C2.36
  C2.36_N <- strsplit(as.character(qdata$C2.36[i]),',')[[1]]
  if("1"%in%C2.36_N){data$C2.36_1[i] = 1}
  if("2"%in%C2.36_N){data$C2.36_2[i] = 1}
  if("3"%in%C2.36_N){data$C2.36_3[i] = 1}
  if("4"%in%C2.36_N){data$C2.36_4[i] = 1}
  # C2.40
  C2.40_N <- strsplit(as.character(qdata$C2.40[i]),',')[[1]]
  if("1"%in%C2.40_N){data$C2.40_1[i] = 1}
  if("2"%in%C2.40_N){data$C2.40_2[i] = 1}
  if("3"%in%C2.40_N){data$C2.40_3[i] = 1}
  if("88"%in%C2.40_N){data$C2.40_88[i] = 1}
}
remove(i)
remove(C2.35_N)
remove(C2.36_N)
remove(C2.40_N)

fdata <- data.frame(C2.34=factor(data$C2.34),
                    C2.35_1=factor(data$C2.35_1),
                    C2.35_2=factor(data$C2.35_2),
                    C2.35_3=factor(data$C2.35_3),
                    C2.35_88=factor(data$C2.35_88),
                    C2.36_1=factor(data$C2.36_1),
                    C2.36_2=factor(data$C2.36_2),
                    C2.36_3=factor(data$C2.36_3),
                    C2.36_4=factor(data$C2.36_4),
                    C2.37=factor(data$C2.37,c(1,2,3,4,5)),
                    C2.38=factor(data$C2.38,c(1,2,3,4,5)),
                    C2.39=factor(data$C2.39,c(1,2,3,4,5)),
                    C2.40_1=factor(data$C2.40_1),
                    C2.40_2=factor(data$C2.40_2),
                    C2.40_3=factor(data$C2.40_3),
                    C2.40_88=factor(data$C2.40_88))
#####
# descriptive statistic
# for a single question analysis
# frequency distribution
#####
#####
# C2.34
#####
cases <- c(length(which(data$C2.34==1)),
            length(which(data$C2.34==2)),
            length(which(data$C2.34==3)),
            length(which(data$C2.34==4)))
names(cases) <- c("06:12","11:40","21:00","20:15")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
        )
par(mar = c(0, 0, 0, 0))
pie(cases,col=rainbow(4),radius = 1)
summary(fdata$C2.34)
#####
# C2.35
#####
cases <- c(length(which(data$C2.35_1==1)),
           length(which(data$C2.35_2==1)),
           length(which(data$C2.35_3==1)),
           length(which(data$C2.35_88==1)))
names(cases) <- c("1","2","3","88")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
)
chisq.test(cases[1:2])
binom.test(cases[3],550,p=0.5,alternative="less")
#check if C2.35_88==1 but C2.35_1_2_3!=1
which(data[which(data$C2.35_88==1),2:4]!=c(0,0,0))
#check if all zero
which(rowSums(data[,2:5])==0)
#how many chagnes discovered of each?
cases <- c(length(which(rowSums(data[,2:4])==1)),
           length(which(rowSums(data[,2:4])==2)),
           length(which(rowSums(data[,2:4])==3)),
           length(which(rowSums(data[,2:4])==0)))
names(cases) <- c("����1���仯","����2���仯","����3���仯","û����仯")
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
)
# venn
library(VennDiagram)
choose_1 <- which(data$C2.35_1==1)
choose_2 <- which(data$C2.35_2==1)
choose_3 <- which(data$C2.35_3==1)
choose_88 <- which(data$C2.35_88==1)
venn.plot <- venn.diagram(
  x = list("�仯1"=choose_1,
           "�仯2"=choose_2,
           "�仯3"=choose_3),
  fill=c("red","blue","green"),
  filename = "C2.35_Venn.tiff",
  scaled = TRUE,
  ext.text = TRUE,
  ext.line.lwd = 2,
  ext.dist = -0.15,
  ext.length = 0.9,
  ext.pos = -4,
  inverted = TRUE,
  cex = 2.5,
  cat.cex = 2.5,
  rotation.degree = 45,
  main = "C2.35 Venn Diagram",
  sub = "any changes in channel",
  main.cex = 2,
  sub.cex = 1
)
venn.plot
#####
# C2.36
#####
cases <- c(length(which(data$C2.36_1==1)),
           length(which(data$C2.36_2==1)),
           length(which(data$C2.36_3==1)),
           length(which(data$C2.36_4==1)))
names(cases) <- c("1","2","3","4")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
)
#check if all zero
which(rowSums(data[,6:9])==0)
#how many chagnes discovered of each?
cases <- c(length(which(rowSums(data[,6:9])==1)),
           length(which(rowSums(data[,6:9])==2)),
           length(which(rowSums(data[,6:9])==3)),
           length(which(rowSums(data[,6:9])==4)))
names(cases) <- c("ϲ��1��(403)","ϲ��2��(139)","ϲ��3��(10)","ϲ��4��(1)")
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
)
# venn
library(VennDiagram)
choose_1 <- which(data$C2.36_1==1)
choose_2 <- which(data$C2.36_2==1)
choose_3 <- which(data$C2.36_3==1)
choose_4 <- which(data$C2.36_4==1)
venn.plot <- venn.diagram(
  x = list("����1"=choose_1,
           "����2"=choose_2,
           "����3"=choose_3,
           "����4"=choose_4),
  fill=c("red","blue","green","grey"),
  filename = "C2.36_Venn.tiff",
  scaled = TRUE,
  ext.text = TRUE,
  ext.line.lwd = 2,
  ext.dist = -0.15,
  ext.length = 0.9,
  ext.pos = -4,
  inverted = TRUE,
  cex = 2.5,
  cat.cex = 2.5,
  rotation.degree = 45,
  main = "C2.36 Venn Diagram",
  sub = "any favorites in channel",
  main.cex = 2,
  sub.cex = 1
)
venn.plot
#####
# C2.37
#####
cases <- c(length(which(data$C2.37==1)),
           length(which(data$C2.37==2)),
           length(which(data$C2.37==3)),
           length(which(data$C2.37==4)),
           length(which(data$C2.37==5)))
names(cases) <- c("1","2","3","4","5")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red","grey"),
        density = c(7.5,12.5,17.5,19.5,22.5),
        angle = c(45,60,120,135,150)
)
#####
# C2.38
#####
cases <- c(length(which(data$C2.38==1)),
           length(which(data$C2.38==2)),
           length(which(data$C2.38==3)),
           length(which(data$C2.38==4)),
           length(which(data$C2.38==5)))
names(cases) <- c("1","2","3","4","5")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red","grey"),
        density = c(7.5,12.5,17.5,19.5,22.5),
        angle = c(45,60,120,135,150)
)
#####
# C2.39
#####
cases <- c(length(which(data$C2.39==1)),
           length(which(data$C2.39==2)),
           length(which(data$C2.39==3)),
           length(which(data$C2.39==4)),
           length(which(data$C2.39==5)))
names(cases) <- c("1","2","3","4","5")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red","grey"),
        density = c(7.5,12.5,17.5,19.5,22.5),
        angle = c(45,60,120,135,150)
)
#####
# C2.37_38_39
#####
cases37 <- c(length(which(data$C2.37==1)),
           length(which(data$C2.37==2)),
           length(which(data$C2.37==3)),
           length(which(data$C2.37==4)),
           length(which(data$C2.37==5)))

cases38 <- c(length(which(data$C2.38==1)),
           length(which(data$C2.38==2)),
           length(which(data$C2.38==3)),
           length(which(data$C2.38==4)),
           length(which(data$C2.38==5)))

cases39 <- c(length(which(data$C2.39==1)),
           length(which(data$C2.39==2)),
           length(which(data$C2.39==3)),
           length(which(data$C2.39==4)),
           length(which(data$C2.39==5)))
cases<-rbind(cases37,cases38,cases39);
colnames(cases)=c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
rownames(cases)=c("̸Ц","�߰���","����")
cases
# plot grouped bar by using barplot
barplot(cases,
        beside=T,
        cex.names=0.8,
        #las=2,
        legend.text = T,
        border="black",
        col=c("green3","blue","red"),
        density = c(7.5,12.5,17.5),
        angle = c(60,120,150)
)
#####
# C2.40
#####
cases <- c(length(which(data$C2.40_1==1)),
           length(which(data$C2.40_2==1)),
           length(which(data$C2.40_3==1)),
           length(which(data$C2.40_88==1)))
names(cases) <- c("����","�ط�̨","��������Ƶ��","������")
#barplot(cases)
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
)
#check if C2.35_88==1 but C2.35_1_2_3!=1
which(data[which(data$C2.40_88==1),13:15]!=c(0,0,0))
#check if all zero
which(rowSums(data[,13:16])==0)
#how many other channels are considered?
cases <- c(length(which(rowSums(data[,13:15])==1)),
           length(which(rowSums(data[,13:15])==2)),
           length(which(rowSums(data[,13:15])==3)),
           length(which(rowSums(data[,13:15])==0)))
names(cases) <- c("����1̨","����2̨","����3̨","����")
par(mar = c(3, 3, 3, 3))
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
)
# venn
library(VennDiagram)
watch_1 <- which(data$C2.40_1==1)
watch_2 <- which(data$C2.40_2==1)
watch_3 <- which(data$C2.40_3==1)
watch_88 <- which(data$C2.40_88==1)
venn.plot <- venn.diagram(
  x = list("����"=watch_1,
           "�ط�̨"=watch_2,
           "��������Ƶ��"=watch_3),
  fill=c("red","blue","green"),
  filename = "C2.40_Venn.tiff",
  scaled = TRUE,
  ext.text = TRUE,
  ext.line.lwd = 2,
  ext.dist = -0.15,
  ext.length = 0.9,
  ext.pos = -4,
  inverted = TRUE,
  cex = 2.5,
  cat.cex = 2.5,
  rotation.degree = 45,
  main = "C2.40 Venn Diagram",
  sub = "other channels",
  main.cex = 2,
  sub.cex = 1
)
venn.plot
#####
# Inferential statistic
#####
#####
# test for independence
# Correspondence analysis
# C2.34��C2.35_1_2_3_88
#####
x<-table(fdata$C2.34,factor(rowSums(data[,2:4])))
summary(x)
x
colnames(x)<-c("û����仯","����1��","����2��","����3��")
row.names(x)<-c("06:12","11:40","21:00","20:15")
x
#chisq.test(table(fdata$C2.34,factor(rowSums(data[,2:4]))))
#fisher.test(table(fdata$C2.34,factor(rowSums(data[,2:4]))))
#mcnemar.test(table(fdata$C2.34,factor(rowSums(data[,2:4]))),correct=FALSE)
#Correspondence analysis
library(ca)
ca(x)
plot(ca(x), dim = c(1,2), map = "symbiplot", what = c("all", "all"), 
     mass = c(FALSE, FALSE), contrib = c("none", "none"), 
     col = c("blue", "red"), pch = c(16, 21, 17, 24), 
     labels = c(2, 2), arrows = c(FALSE, FALSE),
     lines = c(FALSE, FALSE), xlab = "_auto_", ylab = "_auto_",
     col.lab = c("blue", "red")) 
#####
# test for independence
# Correspondence analysis
# C2.36_1_2_3_4��C2.35_1_2_3_88
#####
#Correspondence analysis
library(ca)
#analysis on the types of likes
x1<-table(fdata$C2.36_1,factor(rowSums(data[,2:4])))
x1
summary(x1)
x2<-table(fdata$C2.36_2,factor(rowSums(data[,2:4])))
x2
summary(x2)
x3<-table(fdata$C2.36_3,factor(rowSums(data[,2:4])))
x3
summary(x3)
x4<-table(fdata$C2.36_4,factor(rowSums(data[,2:4])))
x4
summary(x4)
x<-matrix(1,4,4)
x[1,]<-x1[2,]/(x1[1,]+x1[2,])
x[2,]<-x2[2,]/(x2[1,]+x2[2,])
x[3,]<-x3[2,]/(x3[1,]+x3[2,])
x[4,]<-x4[2,]/(x4[1,]+x4[2,])
x<-as.table(x)
colnames(x)<-c("û����仯","����1��","����2��","����3��")
row.names(x)<-c("(1)���ֻ�","(2)������������С��ʶ",
                "(3)��������ָ������","(4)��Ŀ����")
summary(x)
x
plot(ca(x))
#####
# test for independence
# Correspondence analysis
# C2.40_1_2_3_88��C2.35_1_2_3_88
#####
#Correspondence analysis
library(ca)
#analysis on the types of likes
x1<-table(fdata$C2.40_1,factor(rowSums(data[,2:4])))
x1
summary(x1)
x2<-table(fdata$C2.40_2,factor(rowSums(data[,2:4])))
x2
summary(x2)
x3<-table(fdata$C2.40_3,factor(rowSums(data[,2:4])))
x3
summary(x3)
x4<-table(fdata$C2.40_88,factor(rowSums(data[,2:4])))
x4
summary(x4)
x<-matrix(1,4,4)
x[1,]<-x1[2,]/(x1[1,]+x1[2,])
x[2,]<-x2[2,]/(x2[1,]+x2[2,])
x[3,]<-x3[2,]/(x3[1,]+x3[2,])
x[4,]<-x4[2,]/(x4[1,]+x4[2,])
x<-as.table(x)
colnames(x)<-c("û����仯","����1��","����2��","����3��")
row.names(x)<-c("����","�ط�̨",
                "��������Ƶ��","ֻ��¢������̨")
summary(x)
x
plot(ca(x))
#####
# test for independence
# Correspondence analysis
# C2.37-38-39��C2.35_1_2_3_88
#####
#Correspondence analysis
library(ca)
#analysis on the types of likes
x1<-table(fdata$C2.37,factor(rowSums(data[,2:4])))
x1
summary(x1)
colnames(x1)<-c("û����仯","����1��","����2��","����3��")
row.names(x1)<-c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
summary(x1)
x1
plot(ca(x1[3:5,]))

x2<-table(fdata$C2.38,factor(rowSums(data[,2:4])))
x2
summary(x2)
colnames(x2)<-c("û����仯","����1��","����2��","����3��")
row.names(x2)<-c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
summary(x2)
x2
plot(ca(x2[3:5,]))

x3<-table(fdata$C2.39,factor(rowSums(data[,2:4])))
x3
summary(x3)
colnames(x3)<-c("û����仯","����1��","����2��","����3��")
row.names(x3)<-c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
summary(x3)
x3
plot(ca(x3[3:5,]))
#each holder
ex<-matrix(1,5,4)
ex[,1]<-x1[,1]/sum(x1[,1])
ex[,2]<-x1[,2]/sum(x1[,2])
ex[,3]<-x1[,3]/sum(x1[,3])
ex[,4]<-x1[,4]/sum(x1[,4])
ex1<-colSums(ex*c(1,2,3,4,5))

ex<-matrix(1,5,4)
ex[,1]<-x2[,1]/sum(x2[,1])
ex[,2]<-x2[,2]/sum(x2[,2])
ex[,3]<-x2[,3]/sum(x2[,3])
ex[,4]<-x2[,4]/sum(x2[,4])
ex2<-colSums(ex*c(1,2,3,4,5))

ex<-matrix(1,5,4)
ex[,1]<-x3[,1]/sum(x3[,1])
ex[,2]<-x3[,2]/sum(x3[,2])
ex[,3]<-x3[,3]/sum(x3[,3])
ex[,4]<-x3[,4]/sum(x3[,4])
ex3<-colSums(ex*c(1,2,3,4,5))

x<-matrix(1,3,4)
x[1,]<-ex1
x[2,]<-ex2
x[3,]<-ex3
x<-as.table(x)
colnames(x)<-c("û����仯","����1��","����2��","����3��")
row.names(x)<-c("̸Ц","�߰���","����")
summary(x)
x
plot(ca(x))
#####
# test for independence
# Correspondence analysis
# C2.37-38-39��C2.34
#####
#Correspondence analysis
library(ca)
#analysis on the types of likes
x1<-table(fdata$C2.37,fdata$C2.34)
x1
colnames(x1)<-c("06:12","11:40","21:00","20:15")
row.names(x1)<-c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
summary(x1)
x1

x2<-table(fdata$C2.38,fdata$C2.34)
x2
colnames(x2)<-c("06:12","11:40","21:00","20:15")
row.names(x2)<-c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
summary(x2)
x2

x3<-table(fdata$C2.39,fdata$C2.34)
x3
colnames(x3)<-c("06:12","11:40","21:00","20:15")
row.names(x3)<-c("�ܲ�����","��̫����","һ��","�Ƚ�����","�ǳ�����")
summary(x3)
x3
#each holder
ex<-matrix(1,5,4)
ex[,1]<-x1[,1]/sum(x1[,1])
ex[,2]<-x1[,2]/sum(x1[,2])
ex[,3]<-x1[,3]/sum(x1[,3])
ex[,4]<-x1[,4]/sum(x1[,4])
ex1<-colSums(ex*c(1,2,3,4,5))

ex<-matrix(1,5,4)
ex[,1]<-x2[,1]/sum(x2[,1])
ex[,2]<-x2[,2]/sum(x2[,2])
ex[,3]<-x2[,3]/sum(x2[,3])
ex[,4]<-x2[,4]/sum(x2[,4])
ex2<-colSums(ex*c(1,2,3,4,5))

ex<-matrix(1,5,4)
ex[,1]<-x3[,1]/sum(x3[,1])
ex[,2]<-x3[,2]/sum(x3[,2])
ex[,3]<-x3[,3]/sum(x3[,3])
ex[,4]<-x3[,4]/sum(x3[,4])
ex3<-colSums(ex*c(1,2,3,4,5))

x<-matrix(1,3,4)
x[1,]<-ex1
x[2,]<-ex2
x[3,]<-ex3
x<-as.table(x)
x
colnames(x)<-c("06:12","11:40","21:00","20:15")
row.names(x)<-c("̸Ц","�߰���","����")
summary(x)
x
plot(ca(x), dim = c(1,2), map = "symmetric", what = c("all", "all"), 
     mass = c(FALSE, FALSE), contrib = c("none", "none"), 
     col = c("blue", "red"), pch = c(16, 21, 17, 24), 
     labels = c(2, 2), arrows = c(FALSE, FALSE),
     lines = c(FALSE, FALSE), xlab = "_auto_", ylab = "_auto_",
     col.lab = c("blue", "red"))