node("launchpad-maven") {
  checkout scm
  stage("Test") {
    sh "mvn test"
  }
  stage("Deploy") {
    sh "mvn clean install -Popenshift -Ddekorate.deploy=true -DskipTests"
  }
}
