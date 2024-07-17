library(data.table)
library(dplyr)
path <- getwd()
d <- 'UCI HAR Dataset'
#leer los objetos
Sub_Train <- data.table(read.table(file.path(path, d, 'train', 'subject_train.txt')))
Sub_Test <- data.table(read.table(file.path(path, d, 'test', 'subject_test.txt')))
Subj <- rbind(Sub_Train, Sub_Test)
names(Subj) <- c('Subject')
remove(Sub_Train,Sub_Test)
#leer las acciones
Y_train <- data.table(read.table(file.path(path, d, 'train','Y_train.txt')))
Y_test <- data.table(read.table(file.path(path,d,'test','Y_test.txt')))
Act <- rbind(Y_train,Y_test)
names(Act) <- c('Activity')
remove(Y_train,Y_test)
#unir las dos
Subj <- cbind(Subj,Act)
remove(Act)
#leer los datos de caracteres
X_train <- data.table(read.table(file.path(path,d,'train','X_train.txt')))
X_test <- data.table(read.table(file.path(path,d,'test','X_test.txt')))
dato <- rbind(X_train,X_test)
remove(X_train,X_test)
#fusionar en una tabla tema
dato <- cbind(Subj,dato)
setkey(dato,Subject,Activity)
remove(Subj)
#leer nombres de funciones, obtener solo funciones estándar y medias
features <- data.table(read.table(file.path(path,d,'features.txt'))) 
names(features) <- c('ftNum','ftName')
features <- features[grepl("mean\\(\\)|std\\(\\)",ftName)]
features$ftCode <- paste('V', features$ftNum, sep = "")

dato <- dato[,c(key(dato), features$ftCode),with=F]
setnames(dato, old=features$ftCode, new=as.character(features$ftName))
activity_labels <- data.table(read.table(file.path(path, d, 'activity_labels.txt')))
names(activity_labels) <- c('Activity','ActivityName')
dato <- merge(dato,activity_labels,by='Activity')
remove(activity_labels)

resultado <- dato %>% group_by(Subject, ActivityName) %>% summarise_each(funs(mean))
resultado$Activity <- NULL

names(resultado) <- gsub('^t', 'time', names(resultado))
names(resultado) <- gsub('^f', 'frequency', names(resultado))
names(resultado) <- gsub('Acc', 'Accelerometer', names(resultado))
names(resultado) <- gsub('Gyro','Gyroscope', names(resultado))
names(resultado) <- gsub('mean[(][)]','Mean',names(resultado))
names(resultado) <- gsub('std[(][)]','Std',names(resultado))
names(resultado) <- gsub('-','',names(resultado))

write.table(resultado, file.path(path, 'resultado.txt'), row.names=FALSE)
