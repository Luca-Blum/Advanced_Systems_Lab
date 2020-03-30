


groundEmissionMatrix<- read.csv(file = 'test_matrices/groundEmissionMatrix.csv',header=FALSE)
groundTransitionMatrix<- read.csv(file = 'test_matrices/groundTransitionMatrix.csv',header=FALSE)

emissionMatrix<- read.csv(file = 'test_matrices/emissionMatrix.csv',header=FALSE)
emissionMatrix<-t(emissionMatrix)

transitionMatrix<- read.csv(file = 'test_matrices/transitionMatrix.csv',header=FALSE)
transitionMatrix<-t(transitionMatrix)

observations<- read.csv(file = 'test_matrices/observations.csv',header=FALSE)
observations<-t(observations)+1

stateProb<- read.csv(file = 'test_matrices/stateProb.csv',header=FALSE)
stateProb <-t(stateProb)


hmm = initHMM(seq(1,length(stateProb), by=1),seq(1,dim(emissionMatrix)[1], by=1),startProbs=stateProb, transProbs=transitionMatrix, emissionProbs=emissionMatrix)

print(hmm)
# Baum-Welch
bw = baumWelch(hmm,observations,maxIterations = 1000)
print(bw$hmm)
