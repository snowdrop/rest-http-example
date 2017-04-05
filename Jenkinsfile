node("maven") {
  checkout scm
  stage("Test") {
    sh "mvn test"
  }
  stage("Deploy") {
    sh "mvn fabric8:deploy -Popenshift -DskipTests"
  }
}
