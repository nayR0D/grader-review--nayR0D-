CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
file_path="student-submission/ListExamples.java"


if [[ -f $file_path ]];
then
    echo 'succeded'
else
    echo 'incorrect file submitted'
    exit
fi

# copy files to grading-area
cp $file_path 'grading-area'
cp -r 'lib' 'grading-area'
cp *.java 'grading-area'

cd grading-area
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > testoutput.txt

grep -o "Failures: [[:digit:]]\+" testoutput.txt > score.txt
fails=`grep -o "Failures: [[:digit:]]\+" testoutput.txt`
echo 'Failures:' $fails

grep -o "Failures: [[:digit:]]\+" testoutput.txt > score.txt
total=`grep -o "Tests run: [[:digit:]]\+" testoutput.txt > score.txt`
echo 'Total:' $total

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
